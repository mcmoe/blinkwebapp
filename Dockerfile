FROM openjdk:8-jdk-alpine AS build

RUN apk add --update-cache \
    npm git \
  # clone and build UI
  && git clone https://github.com/adrian-dobre/BlinkWebUI \
  && cd BlinkWebUI \
  && npm install \
  && npm run build \
  && cd .. \
  # clone and build Backend
  && git clone https://github.com/adrian-dobre/BlinkWebService.git \
  && cd BlinkWebService \
  && ./gradlew build bootJar \
  && cd .. \
  # package all in a release folder
  && mkdir blinkwebapp \
  && cd blinkwebapp \
  && mkdir dist \
  && cp /BlinkWebService/build/libs/*jar ./blink-web-ui.jar \
  && cp /BlinkWebUI/dist/* ./dist \
  # clean up
  && apk del \
    npm git \
  && rm -rf /BlinkWebUI/ \
  && rm -rf /BlinkWebService/ \
  && rm -rf /var/cache/apk/*

FROM openjdk:8-jre-alpine
COPY --from=build /blinkwebapp /blinkwebapp

CMD ["java", "-jar", "/blinkwebapp/blink-web-ui.jar", "--uiBuildPath=/blinkwebapp/dist/", "--server.port=80"]
