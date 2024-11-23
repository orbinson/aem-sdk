FROM azul/zulu-openjdk:11-jre-headless as installer

ARG AEMC_VERSION=2.0.1
ARG TARGETOS=linux
ARG TARGETARCH=arm64

RUN apt-get update &&\
  apt-get install -y --no-install-recommends curl

RUN curl -L https://github.com/wttech/aemc/releases/download/v${AEMC_VERSION}/aemc-cli_${TARGETOS}_${TARGETARCH}.tar.gz | tar -xz -C /usr/local/bin

FROM azul/zulu-openjdk:11-jre-headless

ARG RUNMODE=author
ARG PORT=4502

ENV RUNMODE=${RUNMODE}
ENV AEM_VENDOR_JAVA_HOME_DIR=$JAVA_HOME

COPY --from=installer /usr/local/bin/aem /usr/local/bin/aem

EXPOSE ${PORT}

WORKDIR /opt

COPY aem-start.sh /usr/local/bin/aem-start
RUN chmod +x /usr/local/bin/aem-start

COPY aem-sdk-artifacts/aem-sdk-*.zip aem/home/lib/

RUN aem instance --instance-${RUNMODE} launch && aem instance down

HEALTHCHECK CMD /usr/local/bin/aem instance --instance-${RUNMODE} await

CMD ["/usr/local/bin/aem-start"]
