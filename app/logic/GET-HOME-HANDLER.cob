       IDENTIFICATION DIVISION.
       PROGRAM-ID. GET-HOME-HANDLER.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       PROCEDURE DIVISION.
      *    Just a simple landing page until I add more templating
           DISPLAY "Content-type: text/html"
           DISPLAY X"0A"
           DISPLAY "<!DOCTYPE html>"
           DISPLAY "<html>"
           DISPLAY "<head>"
           DISPLAY "<title>Broseki</title>"
           DISPLAY "<meta name='description' content='Computer "
           DISPLAY "Scientist and Explorer of Arcane Things'>"
           DISPLAY "<meta name='keywords' content='broseki, computer "
           DISPLAY "science, RIT, embedded software, COBOL'>"
           DISPLAY "</head>"
           DISPLAY "<body>"
           DISPLAY "<h1>Broseki</h1>"
           DISPLAY "<p>I used to have a blog running here that was "
           DISPLAY "powered by Plan9. That was not weird enough for my "
           DISPLAY "taste so now I am developing a COBOL based web "
           DISPLAY "framework. You can see the progress "
           DISPLAY "<a href='"
           DISPLAY "https://github.com/Broseki/Broseki-Website'>"
           DISPLAY "here</a>.</p>"
           DISPLAY "<p>"
           DISPLAY "<a href='https://github.com/Broseki'>Github</a> | "
           DISPLAY "<a href='https://gitlab.com/Broseki'>GitLab</a> | "
           DISPLAY "<a href='"
           DISPLAY "https://www.linkedin.com/in/"
           DISPLAY "michael-canning-490703191/'>"
           DISPLAY "LinkedIn</a> | "
           DISPLAY "<a href='https://broseki.eth.link'>"
           DISPLAY ".eth Landing Page</a>"
           DISPLAY "</p>"
           DISPLAY "<pre>"
           DISPLAY "               __"
           DISPLAY "              / _)"
           DISPLAY "     _.----._/ /"
           DISPLAY "    /         /"
           DISPLAY " __/ (  | (  |"
           DISPLAY "/__.-'|_|--|_|"
           DISPLAY "</pre>"
           DISPLAY "</body>"
           DISPLAY "</html>"

           EXIT PROGRAM.
           END PROGRAM GET-HOME-HANDLER.
