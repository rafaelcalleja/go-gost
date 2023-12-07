ARG BASE_IMAGE="ubuntu:20.04"
ARG BUILDER_IMAGE="golang:1.21-bullseye"
ARG GARBLE_HASH=9378ec959a6da66e334db960dd7afba0e4f37aed

FROM $BUILDER_IMAGE as builder
ARG BASE_IMAGE="ubuntu:20.04"
ARG GARBLE_HASH=9378ec959a6da66e334db960dd7afba0e4f37aed

ENV GOBIN /usr/local/bin/

RUN go install mvdan.cc/garble@$GARBLE_HASH && \
    git clone https://github.com/go-gost/gost/ && cd gost/cmd/gost/ && \
    garble build . && \
    cp gost /usr/local/bin/

FROM $BASE_IMAGE
COPY --from=builder /usr/local/bin/gost /usr/local/bin/gost
COPY --from=builder /usr/local/bin/gost /usr/local/bin/nginx
