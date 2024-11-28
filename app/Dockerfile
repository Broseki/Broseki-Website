FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    apache2 \
    gnucobol \
    && a2enmod cgi

COPY apache-config.conf /etc/apache2/sites-available/000-default.conf
RUN mkdir -p /usr/lib/cgi-bin

COPY logic/script.cob /usr/lib/cgi-bin/
WORKDIR /usr/lib/cgi-bin
RUN cobc -x script.cob -o script.cgi
RUN chmod +x script.cgi

CMD ["apache2ctl", "-D", "FOREGROUND"]
