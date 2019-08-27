from openjdk:11.0.4-jre
MAINTAINER Firdaus Norazam <firdaus.norazam@ideagen.com>

VOLUME /tmp
ARG JAR_FILE
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]