       IDENTIFICATION DIVISION.
       PROGRAM-ID. 404-HANDLER.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       PROCEDURE DIVISION.

           DISPLAY "Status: 404 Not Found"
           DISPLAY "Content-type: text/html"
           DISPLAY X"0A"
           DISPLAY "<html><body>"
           DISPLAY "<h1>404 - File Not Found</h1>"
           DISPLAY "</body></html>"
           EXIT PROGRAM.

           END PROGRAM 404-HANDLER.
