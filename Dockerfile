FROM maven:3.3-jdk-8-alpine

ARG MVN_COMMAND="mvn dependency:copy -q"

COPY pom.xml .

RUN $MVN_COMMAND

FROM alpine:3.7

RUN apk --update add openjdk8-jre

# environment variables
ENV APP_DIR=/saartha/saartha-support-rulesengine
ENV APP=saartha-trigger-rulesengine.jar

#copy JAR and property files to the image
COPY --from=0 *.jar $APP_DIR/$APP
COPY *.jar $APP_DIR/
COPY *.yml $APP_DIR/
COPY *.properties $APP_DIR/

#set the working directory
WORKDIR $APP_DIR

ENTRYPOINT java -cp $APP -Dloader.path=code-generation.jar -Dloader.main=com.saartha.iot.rulesengine.RulesEngineApplication org.springframework.boot.loader.PropertiesLauncher
