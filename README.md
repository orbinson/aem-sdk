# AEM SDK

AEM author and publish docker images for AEMaaCS using the AEM SDK.

## Pull the image

The `version` should be in the original format like `2024.10.18459.20241031T210302Z-241000`.

To pull the author image

```shell
docker pull ghcr.io/orbinson/aem-sdk:author-<version>
```

To pull the publish image

```shell
docker pull ghcr.io/orbinson/aem-sdk:publish-<version>
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
docker buildx . -t aem-sdk:author
```

And run the image

```shell
docker run -p 4502:4502 -p 5005:14502 aem-sdk:author
```
  
To build the publish image, you need to specify the correct build arguments.

```shell
docker buildx \
  --build-arg RUNMODE=publish \
  --build-arg PORT=4503 \
  . -t aem-sdk:publish
```

And run the image

```shell
docker run -p 4503:4503 -p 5006:14504 aem-sdk:publish
```
