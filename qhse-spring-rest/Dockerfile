from openjdk:11
MAINTAINER Firdaus Norazam <firdaus.norazam@ideagen.com>

VOLUME /tmp
ARG JAR_FILE
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]
