       IDENTIFICATION DIVISION.
       PROGRAM-ID. CGI-HANDLER.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 PATH-INFO    PIC X(256).
       01 REQ-METHOD   PIC X(10).
       01 QUERY-STRING PIC X(256).

       PROCEDURE DIVISION.
           ACCEPT PATH-INFO FROM ENVIRONMENT "PATH_INFO"
           ACCEPT REQ-METHOD FROM ENVIRONMENT "REQUEST_METHOD"
           ACCEPT QUERY-STRING FROM ENVIRONMENT "QUERY_STRING"

           DISPLAY "Content-type: text/html"
           DISPLAY X"0A"
           DISPLAY "<html><body>"
           DISPLAY "<h1>COBOL CGI Response</h1>"
           DISPLAY "<p>Requested Path: " PATH-INFO "</p>"
           DISPLAY "<p>Request Method: " REQ-METHOD "</p>"
           DISPLAY "<p>Query String: " QUERY-STRING "</p>"
           DISPLAY "</body></html>"

           STOP RUN.
