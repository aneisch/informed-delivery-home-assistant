FROM python:3-alpine

RUN pip install --no-cache-dir paho-mqtt && \
    apk --update add --no-cache imagemagick
    
COPY ./retrieve_mail.py /usr/local/bin/retrieve_mail.py
COPY ./nomail.gif /
COPY ./nomail.gif /output/todays_mails.gif

RUN chmod +x /usr/local/bin/retrieve_mail.py

ENV MQTT_SERVER 10.0.1.22
ENV MQTT_SERVER_PORT 1883

ENV MQTT_USERNAME mosquitto
ENV MQTT_PASSWORD password

ENV MQTT_USPS_MAIL_TOPIC /usps/mails
ENV MQTT_USPS_PACKAGE_TOPIC /usps/packages

ENV EMAIL_HOST imap.gmail.com
ENV EMAIL_PORT 993
ENV EMAIL_USERNAME xxx.xxx@outlook.com
ENV EMAIL_PASSWORD xxx
ENV EMAIL_FOLDER informed_delivery

ENV GIF_FILE_NAME todays_mails.gif
ENV GIF_MAKER_OPTIONS '/usr/bin/convert -delay 300 -loop 0'

ENV SLEEP_TIME_IN_SECONDS 300

ENTRYPOINT ["python3","-u","/usr/local/bin/retrieve_mail.py"]
