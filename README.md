# AEM SDK

AEM author and publish docker images for AEMaaCS using the AEM SDK.

## Using the image

The `version` should be in the original format like `2025.3.19823.20250304T101418Z-250200`.

To pull the author image

```shell
docker pull ghcr.io/orbinson/aem-sdk:author-<version>
```

To run an AEM author on port 4502 with Java debugger on port 5005

```shell
docker run -p 4502:4502 -p 5005:14502 ghcr.io/orbinson/aem-sdk:author-<version>
```

To pull the publish image

```shell
docker pull ghcr.io/orbinson/aem-sdk:publish-<version>
```

To run an AEM publisher on port 4503 with Java debugger on port 5006

```shell
docker run -p 4503:4503 -p 5006:14503 ghcr.io/orbinson/aem-sdk:author-<version>
```

## Development

First you need to get the artifacts from the private [aem-sdk-artifacts](https://github.com/orbinson/aem-sdk-artifacts) repository.

```shell
git clone git@github.com:orbinson/aem-sdk-artifacts.git
git lfs pull
```

Or create the `aem-sdk-artifacts` directory and copy the artifacts there from your Downloads folder for example.

```shell
mkdir aem-sdk-artifacts
mv ~/Downloads/aem-sdk-*.zip aem-sdk-artifacts/
```

Afterward you can build the image, by default and author is built.

```shell
docker build . -t aem-sdk:author
```

And run the image with Java debugger on port 5005

```shell
docker run -p 4502:4502 -p 5005:14502 aem-sdk:author
```
  
To build the publish image, you need to specify the correct build arguments.

```shell
docker build \
  --build-arg RUNMODE=publish \
  --build-arg PORT=4503 \
  . -t aem-sdk:publish
```

And run the image with Java debugger on port 5006

```shell
docker run -p 4503:4503 -p 5006:14503 aem-sdk:publish
```
