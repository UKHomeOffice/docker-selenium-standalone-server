FROM quay.io/ukhomeofficedigital/centos-base

ENV SCREEN_WIDTH 1360
ENV SCREEN_HEIGHT 1020
ENV SCREEN_DEPTH 24
ENV DISPLAY :99

RUN yum install -y java-1.8.0-openjdk \
                   sudo \
                   unzip \
                   wget \
                   Xvfb && \
    yum clean all && \
    sed -i \
        's/\/dev\/urandom/\/dev\/.\/urandom/' \
        ./usr/lib/jvm/java-1.8.0-openjdk-1.8.0.*/jre/lib/security/java.security && \
    sed -i -e 's/Defaults    requiretty/#Defaults requiretty/g' /etc/sudoers && \
    mkdir -p /opt/selenium && \
    wget --no-verbose \
         http://selenium-release.storage.googleapis.com/2.47/selenium-server-standalone-2.47.1.jar \
         -O /opt/selenium/selenium-server-standalone.jar && \
    useradd seluser --shell /bin/bash --create-home && \
    echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    echo 'seluser:secret' | chpasswd


ENV CHROME_DRIVER_VERSION 2.18

COPY google-chrome.repo /etc/yum.repos.d/google-chrome.repo
RUN yum install -y firefox google-chrome-stable && yum clean all && \
  wget --no-verbose \
       -O /tmp/chromedriver_linux64.zip \
       http://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip \
  && rm -rf /opt/selenium/chromedriver \
  && unzip /tmp/chromedriver_linux64.zip -d /opt/selenium \
  && rm /tmp/chromedriver_linux64.zip \
  && mv /opt/selenium/chromedriver /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION \
  && chmod 755 /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION \
  && ln -fs /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION /usr/bin/chromedriver

COPY config.json /opt/selenium/config.json
COPY chrome_launcher.sh /opt/google/chrome/google-chrome
COPY entry_point.sh /opt/bin/entry_point.sh

USER seluser

ENTRYPOINT ["/opt/bin/entry_point.sh"]

EXPOSE 4444
