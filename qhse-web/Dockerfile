from openjdk:11.0.4-jre
MAINTAINER Firdaus Norazam <firdaus.norazam@ideagen.com>

VOLUME /tmp
ARG WAR_FILE
COPY ${WAR_FILE} app.war
ENTRYPOINT ["java", "-jar", "/app.war"]