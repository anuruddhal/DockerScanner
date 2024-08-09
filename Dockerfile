# FROM alpine:3.18.8

# ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

# # fontconfig and ttf-dejavu added to support serverside image generation by Java programs
# RUN apk upgrade --no-cache && apk add --no-cache fontconfig libretls musl-locales musl-locales-lang ttf-dejavu tzdata zlib libc6-compat gcompat\
#     && rm -rf /var/cache/apk/*

# ENV JAVA_VERSION jdk-17.0.9+9

# RUN set -eux; \
#     ARCH="$(apk --print-arch)"; \
#     case "${ARCH}" in \
#     amd64|x86_64) \
#     ESUM='70e5d108f51ae7c7b2435d063652df058723e303a18b4f72f17f75c5320052d3'; \
#     BINARY_URL='https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.9%2B9/OpenJDK17U-jre_x64_alpine-linux_hotspot_17.0.9_9.tar.gz'; \
#     ;; \
#     *) \
#     echo "Unsupported arch: ${ARCH}"; \
#     exit 1; \
#     ;; \
#     esac; \
#     wget -O /tmp/openjdk.tar.gz ${BINARY_URL}; \
#     echo "${ESUM} */tmp/openjdk.tar.gz" | sha256sum -c -; \
#     mkdir -p /opt/java/openjdk; \
#     tar --extract \
#     --file /tmp/openjdk.tar.gz \
#     --directory /opt/java/openjdk \
#     --strip-components 1 \
#     --no-same-owner \
#     ; \
#     rm -rf /tmp/openjdk.tar.gz;

# ENV LD_PRELOAD=/lib/libgcompat.so.0

# ENV JAVA_HOME=/opt/java/openjdk \
#     PATH="/opt/java/openjdk/bin:$PATH"

# RUN java --version


FROM alpine:3.17.6

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

# fontconfig and ttf-dejavu added to support serverside image generation by Java programs
RUN apk add --no-cache fontconfig libretls musl-locales musl-locales-lang ttf-dejavu tzdata zlib libc6-compat gcompat\
    && rm -rf /var/cache/apk/*

ENV JAVA_VERSION jdk-17.0.7+7

RUN set -eux; \
    ARCH="$(apk --print-arch)"; \
    case "${ARCH}" in \
    amd64|x86_64) \
    ESUM='711f837bacf8222dee9e8cd7f39941a4a0acf869243f03e6038ca3ba189f66ca'; \
    BINARY_URL='https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.7%2B7/OpenJDK17U-jre_x64_alpine-linux_hotspot_17.0.7_7.tar.gz'; \
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