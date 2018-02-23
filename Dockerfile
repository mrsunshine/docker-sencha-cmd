# docker build --tag=sencha-cmd:6.x.y.z . (6.x.y.z is the same as SENCHA_CMD_VERSION)
# docker run -t --user=$(id -u):$(id -g) -v /:/system -w /system/$(pwd) sencha-cmd:6.5.3.6 <args>

FROM library/java

# Set to the Siesta version you use in the image
ENV SENCHA_CMD_VERSION 6.5.3.6

LABEL maintainer="Nils Dehl <mail@nils-dehl.de>" \
      version=${SENCHA_CMD_VERSION}

ARG user=build
ARG group=build
ARG uid=108
ARG gid=65534
ENV BUILD_HOME /build_home

RUN useradd -d "$BUILD_HOME" -u ${uid} -g ${gid} -G root -m -s /bin/bash ${user} \
    && chown -R ${uid}:${gid} "${BUILD_HOME}"

RUN apt-get update && apt-get install jq

USER ${user}

WORKDIR ${BUILD_HOME}

RUN mkdir -p ${BUILD_HOME}/tmp && \
    curl -o ${BUILD_HOME}/tmp/sencha.sh.zip \
      http://cdn.sencha.com/cmd/${SENCHA_CMD_VERSION}/no-jre/SenchaCmd-${SENCHA_CMD_VERSION}-linux-amd64.sh.zip && \
    unzip ${BUILD_HOME}/tmp/sencha.sh.zip -d ${BUILD_HOME}/tmp && \
    sh  ${BUILD_HOME}/tmp/SenchaCmd-${SENCHA_CMD_VERSION}*-linux-amd64.sh -q && \
    rm -rf ${BUILD_HOME}/tmp

ENTRYPOINT ["/build_home/bin/Sencha/Cmd/sencha"]


