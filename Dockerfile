# Build Stage
FROM lacion/docker-alpine:gobuildimage AS build-stage

LABEL app="build-go-websockets-tutorial"
LABEL REPO="https://github.com/telanj/go-websockets-tutorial"

ENV GOROOT=/usr/lib/go \
    GOPATH=/gopath \
    GOBIN=/gopath/bin \
    PROJPATH=/gopath/src/github.com/telanj/go-websockets-tutorial

# Because of https://github.com/docker/docker/issues/14914
ENV PATH=$PATH:$GOROOT/bin:$GOPATH/bin

ADD . /gopath/src/github.com/telanj/go-websockets-tutorial
WORKDIR /gopath/src/github.com/telanj/go-websockets-tutorial

RUN make build-alpine

# Final Stage
FROM lacion/docker-alpine:latest

ARG GIT_COMMIT
ARG VERSION
LABEL REPO="https://github.com/telanj/go-websockets-tutorial"
LABEL GIT_COMMIT=$GIT_COMMIT
LABEL VERSION=$VERSION

# Because of https://github.com/docker/docker/issues/14914
ENV PATH=$PATH:/opt/go-websockets-tutorial/bin

WORKDIR /opt/go-websockets-tutorial/bin

COPY --from=build-stage /gopath/src/github.com/telanj/go-websockets-tutorial/bin/go-websockets-tutorial /opt/go-websockets-tutorial/bin/
RUN chmod +x /opt/go-websockets-tutorial/bin/go-websockets-tutorial

CMD /opt/go-websockets-tutorial/bin/go-websockets-tutorial