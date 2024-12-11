FROM azul/zulu-openjdk:11-jre-headless

ARG TARGETOS
ARG TARGETARCH

ARG AEMC_VERSION=2.0.3
ARG RUNMODE=author
ARG PORT=4502

ENV RUNMODE=${RUNMODE}
ENV PORT=${PORT}
ENV AEM_VENDOR_JAVA_HOME_DIR=${JAVA_HOME}

EXPOSE ${PORT}

WORKDIR /opt

RUN apt-get update &&\
  apt-get install -y --no-install-recommends curl &&\
  apt-get clean &&\
  rm -rf /var/cache/apk/* &&\
  curl -L https://github.com/wttech/aemc/releases/download/v${AEMC_VERSION}/aemc-cli_${TARGETOS}_${TARGETARCH}.tar.gz | tar -xz -C /usr/local/bin

COPY aem-sdk-artifacts/aem-sdk-*.zip aem/home/lib/
COPY aem/default/etc/aem.yml aem/default/etc/aem.yml

RUN aem instance --instance-${RUNMODE} launch && aem instance down

COPY aem-start.sh /usr/local/bin/aem-start
RUN chmod +x /usr/local/bin/aem-start

HEALTHCHECK CMD /usr/bin/curl -f http://localhost:${PORT}/systemready

CMD ["/usr/local/bin/aem-start"]
