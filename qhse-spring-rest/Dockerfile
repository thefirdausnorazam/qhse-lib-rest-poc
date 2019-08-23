from openjdk:11
MAINTAINER Firdaus Norazam <firdaus.norazam@ideagen.com>

ENTRYPOINT ["/usr/bin/java", "-jar", "/usr/share/qhse/qhse-rest.jar"]

# Add Maven dependencies (not shaded into the artifact; Docker-cached)
ADD target/lib           /usr/share/qhse/lib
# Add the service itself
ARG JAR_FILE
ADD target/${JAR_FILE} /usr/share/qhse/qhse-rest.jar