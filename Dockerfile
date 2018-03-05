FROM quay.io/ukhomeofficedigital/openjdk8:latest

ENV SCREEN_WIDTH=1360 \
    SCREEN_HEIGHT=1020 \
    SCREEN_DEPTH=24 \
    DISPLAY=:99.0

ENV SELENIUM_DOWNLOAD_URL=https://selenium-release.storage.googleapis.com/3.10/selenium-server-standalone-3.10.0.jar \
    CHROME_DRIVER_VERSION=2.33

RUN yum install -y sudo unzip wget Xvfb dbus && \
    yum clean all && \
    sed -i 's/\/dev\/urandom/\/dev\/.\/urandom/' /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.*/jre/lib/security/java.security && \
    sed -i -e 's/Defaults    requiretty/#Defaults requiretty/g' /etc/sudoers && \
    mkdir -p /opt/selenium && \
    wget --no-verbose ${SELENIUM_DOWNLOAD_URL} -O /opt/selenium/selenium-server-standalone.jar && \
    useradd seluser --shell /bin/bash --create-home && \
    echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    echo 'seluser:secret' | chpasswd && \
    mkdir -p /var/lib/dbus/ && \
    dbus-uuidgen > /var/lib/dbus/machine-id

COPY google-chrome.repo /etc/yum.repos.d/google-chrome.repo

RUN yum install -y firefox google-chrome-stable && yum clean all && \
    wget --no-verbose -O /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip && \
    rm -rf /opt/selenium/chromedriver && \
    unzip /tmp/chromedriver_linux64.zip -d /opt/selenium && \
    rm /tmp/chromedriver_linux64.zip && \
    mv /opt/selenium/chromedriver /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION && \
    chmod 755 /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION && \
    ln -fs /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION /usr/bin/chromedriver

COPY config.json /opt/selenium/config.json
COPY chrome_launcher.sh /opt/google/chrome/google-chrome
COPY entrypoint.sh /opt/bin/entrypoint.sh

USER seluser

ENTRYPOINT ["/opt/bin/entrypoint.sh"]

EXPOSE 4444
