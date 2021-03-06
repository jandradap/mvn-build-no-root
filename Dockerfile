FROM openjdk:18-alpine3.15

RUN apk add --no-cache curl tar bash procps

ARG MAVEN_VERSION=3.2.5
ARG USER_HOME_DIR="/home/maven"

RUN adduser maven -D

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL http://dlcdn.apache.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    | tar -xzC /usr/share/maven --strip-components=1 \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

COPY settings.xml $MAVEN_CONFIG/settings.xml

RUN mkdir $MAVEN_CONFIG/repository \
  && chown maven:maven $USER_HOME_DIR -R \
  && mkdir -p /root/.m2/repository /.m2/repository \
  && chown -R maven:maven /root/.m2 /.m2 \
  && chmod 777 /root/.m2 /.m2

USER maven

CMD ["mvn"]