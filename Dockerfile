# Copyright 2022 WSO2 Inc. (http://wso2.org)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM alpine:3.18.8

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

# fontconfig and ttf-dejavu added to support serverside image generation by Java programs
RUN apk upgrade --no-cache && apk add --no-cache curl tar python3 jq unzip zip procps bash fontconfig libretls musl-locales musl-locales-lang ttf-dejavu tzdata zlib libc6-compat gcompat\
    && rm -rf /var/cache/apk/*

ENV JAVA_VERSION jdk-17.0.9+9

RUN set -eux; \
    ARCH="$(apk --print-arch)"; \
    case "${ARCH}" in \
    amd64|x86_64) \
    ESUM='70e5d108f51ae7c7b2435d063652df058723e303a18b4f72f17f75c5320052d3'; \
    BINARY_URL='https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.9%2B9/OpenJDK17U-jre_x64_alpine-linux_hotspot_17.0.9_9.tar.gz'; \
    ;; \
    *) \
    echo "Unsupported arch: ${ARCH}"; \
    exit 1; \
    ;; \
    esac; \
    wget -O /tmp/openjdk.tar.gz ${BINARY_URL}; \
    echo "${ESUM} */tmp/openjdk.tar.gz" | sha256sum -c -; \
    mkdir -p /opt/java/openjdk; \
    tar --extract \
    --file /tmp/openjdk.tar.gz \
    --directory /opt/java/openjdk \
    --strip-components 1 \
    --no-same-owner \
    ; \
    rm -rf /tmp/openjdk.tar.gz;

ENV LD_PRELOAD=/lib/libgcompat.so.0

ENV JAVA_HOME=/opt/java/openjdk \
    PATH="/opt/java/openjdk/bin:$PATH"

RUN java --version

# Install ballerina - if $BASE_BALLERINA_DISTRIBUTION is removed from support, be sure to update the version here!
RUN curl -s https://dist.ballerina.io/downloads/2201.8.3/ballerina-2201.8.3-swan-lake.zip --output ballerina.zip \
    && unzip -q ./ballerina.zip -d / \
    && rm ./ballerina.zip

ENV JAVA_HOME=/opt/java/openjdk \
    PATH="/opt/java/openjdk/bin:$PATH"

ENV PATH=/ballerina-2201.8.3-swan-lake/bin:${PATH}


RUN bal version
RUN bal dist pull 2201.8.4
RUN rm -r /ballerina-2201.8.3-swan-lake/dependencies/
RUN bal version
