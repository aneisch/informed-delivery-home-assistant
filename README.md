# Informed Delivery Home Assistant
<a href="https://www.buymeacoffee.com/aneisch" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-black.png" width="150px" height="35px" alt="Buy Me A Coffee" style="height: 35px !important;width: 150px !important;" ></a><br>

Retrieves USPS mail and package info from informed delivery emails via IMAP. Publishes mail and package count to MQTT and creates mail image gif. This image created based on https://blog.kalavala.net/usps/homeassistant/mqtt/2018/01/12/usps.html. Also see: https://community.home-assistant.io/t/a-working-usps-component-solved-for-now/41012/14


## Usage

### Example docker-compose

```yaml
version: '3.2'
services:
    informed_delivery:
        container_name: informed_delivery
        image: aneisch/informed_delivery_home_assistant
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

## Environmental Variables
You only need to specify the environmental variables in `docker run` or your docker-compose file that you want/need to override:

variable | default | description
-- | -- | --
`MQTT_SERVER` | 10.0.1.22 | MQTT server address
`MQTT_SERVER_PORT` | 1883 | MQTT server port
`MQTT_USERNAME` | mosquitto | MQTT username
`MQTT_PASSWORD` | password | MQTT password
`MQTT_USPS_MAIL_TOPIC` | /usps/mails | Topic where mail count is published
`MQTT_USPS_PACKAGE_TOPIC` | /usps/packages | Topic where package count is published
`EMAIL_HOST` | imap.gmail.com | Email provider
`EMAIL_PORT` | 993 | Email IMAP port
`EMAIL_USERNAME` | xxx.xxx@outlook.com | Email login
`EMAIL_PASSWORD` | xxx | Email password
`EMAIL_FOLDER` | informed_delivery | Folder where Informed Delivery mail will be found (you can filter to a specific folder)
`GIF_FILE_NAME` | todays_mails.gif | Mail image gif output name
`GIF_MAKER_OPTIONS` | '/usr/bin/convert -delay 300 -loop 0' | Gif creation options
`SLEEP_TIME_IN_SECONDS` | 300 | Sleep time between checks


**Notes**: 
* If using Gmail, you will need to [allow less secure apps](https://hotter.io/docs/email-accounts/secure-app-gmail/) to login. 
* I suggest making a separate Google account for this. 
If MQTT doesn't require login you can leave MQTT_USERNAME and MQTT_PASSWORD as is. 
