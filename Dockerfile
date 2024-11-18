FROM azul/zulu-openjdk:11-jre-headless as installer

ARG AEMC_VERSION=1.9.0
ARG PLATFORM=linux
ARG ARCH=arm64

EXPOSE 4502

RUN apt-get update &&\
  apt-get install -y --no-install-recommends curl

RUN curl -L https://github.com/wttech/aemc/releases/download/v${AEMC_VERSION}/aemc-cli_${PLATFORM}_${ARCH}.tar.gz | tar -xz -C /usr/local/bin

WORKDIR /opt

COPY aem-start.sh /usr/local/bin/aem-start

COPY aem-sdk-*.zip aem/home/lib/

RUN chmod +x /usr/local/bin/aem-start

ENV AEM_JAVA_HOME_DIR=$JAVA_HOME

RUN aem instance -A launch && aem instance down

CMD ["/usr/local/bin/aem-start"]
