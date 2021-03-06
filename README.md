# Informed Delivery Home Assistant
<a href="https://www.buymeacoffee.com/aneisch" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-black.png" width="150px" height="35px" alt="Buy Me A Coffee" style="height: 35px !important;width: 150px !important;" ></a><br>

Retrieves USPS mail and package info from informed delivery emails via IMAP. Publishes mail and package count to MQTT and creates scanned mail gif. This container image was created based on content from the top link, check it out for additional Home Assistant sensor integration info. Credit to [@skalavala](https://github.com/skalavala) and [arychj](https://github.com/arychj) for the code and writeup!
* https://www.awesome-automations.com/blog/usps/ 
* https://community.home-assistant.io/t/a-working-usps-component-solved-for-now/41012/14

https://hub.docker.com/r/aneisch/informed-delivery-home-assistant

## Usage

### Example docker-compose:

```yaml
version: '3.2'
services:
    informed_delivery:
        container_name: informed_delivery
        image: aneisch/informed-delivery-home-assistant
        volumes:
          - '/etc/localtime:/etc/localtime:ro'
          # volume for mails image output
          - '/tmp/:/output/'
        environment:
          - EMAIL_USERNAME=your_email@your_provider.com
          - EMAIL_PASSWORD=your_password
          - MQTT_USPS_MAIL_TOPIC=/sensor/usps/mails
          - MQTT_USPS_PACKAGE_TOPIC=/sensor/usps/packages
          - SLEEP_TIME_IN_SECONDS=600
```

### Example `docker run`:
```bash
docker run -d -v '/tmp/:/output/' -v '/etc/localtime:/etc/localtime:ro' \
--name informed_delivery -e EMAIL_USERNAME=your_email@your_provider.com \
-e EMAIL_PASSWORD=your_password -e SLEEP_TIME_IN_SECONDS=600 \
aneisch/informed-delivery-home-assistant
```

### Environmental Variables
You only need to specify the environmental variables in `docker run` or your docker-compose file that you want/need to override:

variable | default | description
-- | -- | --
`MQTT_SERVER` | 10.0.1.22 | MQTT server address
`MQTT_SERVER_PORT` | 1883 | MQTT server port
`MQTT_USERNAME` | mosquitto | MQTT username (can be ignored if unneeded)
`MQTT_PASSWORD` | password | MQTT password (can be ignored if unneeded)
`MQTT_USPS_MAIL_TOPIC` | /usps/mails | Topic where mail count is published
`MQTT_USPS_PACKAGE_TOPIC` | /usps/packages | Topic where package count is published
`EMAIL_HOST` | imap.gmail.com | Email provider url (see table below)
`EMAIL_PORT` | 993 | Email IMAP port
`EMAIL_USERNAME` | xxx.xxx@outlook.com | Email login
`EMAIL_PASSWORD` | xxx | Email password
`EMAIL_FOLDER` | informed_delivery | Folder where Informed Delivery mail will be found (you can filter to a specific folder)
`GIF_FILE_NAME` | todays_mails.gif | Mail image gif output name
`GIF_MAKER_OPTIONS` | '/usr/bin/convert -delay 300 -loop 0' | Gif creation options
`SLEEP_TIME_IN_SECONDS` | 300 | Sleep time between checks

Email Provider | Host Address | Port
-- | -- | --
GMail | imap.gmail.com | 993
Yahoo | imap.mail.yahoo.com | 993
Outlook | imap-mail.outlook.com | 993

### Notes: 
* If using Gmail, you will need to [allow less secure apps](https://hotter.io/docs/email-accounts/secure-app-gmail/) to login. I suggest making a separate Google account for this. You will also need to enable IMAP from your Gmail inbox.
* If MQTT doesn't require login you can leave MQTT_USERNAME and MQTT_PASSWORD as is. 
