FROM golang:1.12.6-alpine as build
WORKDIR /go/src/
RUN apk update && apk add make git && git clone https://github.com/TeleTrackingTechnologies/rds_exporter.git
WORKDIR /go/src/rds_exporter
RUN go get -u github.com/golang/dep/cmd/dep && dep ensure 
RUN export GO111MODULE=on && go mod init && go mod tidy && go mod vendor
RUN go build
FROM alpine:latest

COPY --from=build ["/go/src/rds_exporter/rds_exporter", "/bin/" ]
# COPY config.yml           /etc/rds_exporter/config.yml

RUN apk update && \
    apk add ca-certificates && \
    update-ca-certificates

EXPOSE      9042
ENTRYPOINT  [ "/bin/rds_exporter", "--config.file=/etc/rds_exporter/config.yml" ]
