FROM python:3

RUN pip install --no-cache-dir paho-mqtt && \
    apt-get update && \
    apt-get install imagemagick && \
    apt-get clean
    
COPY ./retreive_mail.py /usr/bin/retreive_mail.py

RUN chmod +x /usr/bin/retreive_mail.py

RUN echo '00  *  *  *  *  /usr/bin/retreive_mail.py' >> /etc/crontab

ENV MQTT_SERVER 10.0.1.22
ENV MQTT_SERVER_PORT 1883

ENV MQTT_USERNAME mosquitto
ENV MQTT_PASSWORD password

ENV MQTT_USPS_MAIL_TOPIC /usps/mails
ENV MQTT_USPS_PACKAGE_TOPIC /usps/packages

ENV EMAIL_HOST imap-mail.outlook.com
ENV EMAIL_PORT 993
ENV EMAIL_USERNAME xxx.xxx@outlook.com
ENV EMAIL_PASSWORD xxx
ENV EMAIL_FOLDER inbox

ENV GIF_FILE_NAME todays_mails.gif
ENV GIF_MAKER_OPTIONS '/usr/bin/convert  -delay 300 -loop 0'

ENTRYPOINT crond -l 2 -f
