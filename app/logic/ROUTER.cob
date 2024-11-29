       IDENTIFICATION DIVISION.
       PROGRAM-ID. ROUTER.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ROUTES-FILE ASSIGN TO "routes"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  ROUTES-FILE.
       01  ROUTES-RECORD PIC X(100).

       WORKING-STORAGE SECTION.
       01  WS-CGI-ROUTE PIC X(100).
       01  WS-CGI-METHOD PIC X(10).
       01  WS-ROUTE-PARTS.
           05  WS-METHOD    PIC X(10).
           05  WS-PATH      PIC X(50).
           05  WS-HANDLER   PIC X(30).
       01  WS-DELIM-POS.
           05  WS-SPACE-POS PIC 99.
           05  WS-ARROW-POS PIC 99.
       01  WS-ROUTE-LINE   PIC X(100).
       01  WS-EOF-ROUTES   PIC X VALUE 'N'.
           88  EOF-ROUTES   VALUE 'Y'.
       01  WS-404-HANDLER  PIC X(30).
       01  WS-MATCH-FOUND  PIC X VALUE 'N'.
           88  MATCH-FOUND  VALUE 'Y'.

       PROCEDURE DIVISION.
      * Read in environment variables from the CGI request
           ACCEPT WS-CGI-ROUTE FROM ENVIRONMENT "PATH_INFO"
           ACCEPT WS-CGI-METHOD FROM ENVIRONMENT "REQUEST_METHOD"
      * Read in the routes file and search for a match for the request 
           OPEN INPUT ROUTES-FILE
           PERFORM UNTIL EOF-ROUTES
               READ ROUTES-FILE INTO WS-ROUTE-LINE
                   AT END
                       MOVE 'Y' TO WS-EOF-ROUTES
                   NOT AT END
                       PERFORM PARSE-ROUTE
      * Check for a 404 handler, we do it here so we only need to
      * search the routes file once
                       IF WS-METHOD = "404" AND WS-PATH = "*"
                           MOVE WS-HANDLER TO WS-404-HANDLER
                       ELSE
                           IF WS-CGI-METHOD = WS-METHOD AND
                              WS-CGI-ROUTE = WS-PATH
                               PERFORM CALL-HANDLER
                               MOVE 'Y' TO WS-MATCH-FOUND
                               MOVE 'Y' TO WS-EOF-ROUTES
                           END-IF
                       END-IF
               END-READ
           END-PERFORM
      * If we could not find a match, use the 404 handler
           IF NOT MATCH-FOUND AND WS-404-HANDLER NOT = SPACES
               PERFORM CALL-HANDLER
           END-IF

           CLOSE ROUTES-FILE
           STOP RUN.
      
      * Function to parse each line of the routes file
      * The lines are expected to be in the format:
      * METHOD PATH -> HANDLER
      * ex: GET /test -> TEST-HANDLER
       PARSE-ROUTE.
           INITIALIZE WS-ROUTE-PARTS
           INITIALIZE WS-DELIM-POS

      * Search for the first space to find the method which is before
      * the first space
           PERFORM VARYING WS-SPACE-POS FROM 1 BY 1
               UNTIL WS-SPACE-POS > 100
               OR WS-ROUTE-LINE(WS-SPACE-POS:1) = SPACE
               CONTINUE
           END-PERFORM
           MOVE WS-ROUTE-LINE(1:WS-SPACE-POS - 1) 
               TO WS-METHOD
      * Find the arrow
           PERFORM VARYING WS-ARROW-POS FROM WS-SPACE-POS BY 1
               UNTIL WS-ARROW-POS > 100
               OR WS-ROUTE-LINE(WS-ARROW-POS:2) = "->"
               CONTINUE
           END-PERFORM

      * The path is before the arrow after a space, and the 
      * handler function name is after the arrow after a space
           MOVE WS-ROUTE-LINE(WS-SPACE-POS + 1:
                            WS-ARROW-POS - WS-SPACE-POS - 2)
               TO WS-PATH

           MOVE WS-ROUTE-LINE(WS-ARROW-POS + 3:)
               TO WS-HANDLER.
           
           CALL-HANDLER.
           CALL WS-HANDLER
               ON EXCEPTION
                   DISPLAY "Handler not found: " WS-HANDLER
               END-CALL.

       END PROGRAM ROUTER.
