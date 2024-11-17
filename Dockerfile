FROM azul/zulu-openjdk:11-jre-headless AS java-base-image

# Install lsof as it is added to the patched AEM stop script
RUN apt-get update &&\
  apt-get install -y --no-install-recommends lsof &&\
  rm -rf /var/lib/apt/lists/*

# Installer layer to extract and start AEM
FROM java-base-image AS installer

RUN apt-get update &&\
  apt-get install -y --no-install-recommends ca-certificates curl jq lsof &&\
  rm -rf /var/lib/apt/lists/* \
