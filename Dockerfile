FROM alpine:3.7
RUN apk --update add openjdk8-jre
ENV APP_DIR=/saartha/saartha-support-rulesengine
COPY *.jar $APP_DIR/
COPY *.yml $APP_DIR/
COPY *.properties $APP_DIR/
WORKDIR $APP_DIR
ENTRYPOINT java -cp saartha-trigger-rulesengine.jar -Dloader.path=code-generation.jar -Dloader.main=com.saartha.iot.rulesengine.RulesEngineApplication org.springframework.boot.loader.PropertiesLauncher