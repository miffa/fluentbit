FROM alpine

WORKDIR /tmp

ENV FLUENT_BIT_VERSION 0.12.10

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && buildDeps=' \
    make \
    cmake \
    g++ \
    ' \
    && apk add $buildDeps --update \
    && wget http://fluentbit.io/releases/0.12/fluent-bit-${FLUENT_BIT_VERSION}.tar.gz -O fb.tar.gz \
    && tar -xzf fb.tar.gz \
    && cd fluent-bit-${FLUENT_BIT_VERSION}/build \
    && cmake .. && make install \
    && rm -rf /tmp/* \
    && apk del --purge $buildDeps \
    && echo "build finished~"

WORKDIR /

COPY parsers.conf .
