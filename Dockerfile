FROM golang:1.9-alpine AS build
ENV  CGO_ENABLED 0
ADD  . /go/src/github.com/NYTimes/gcs-helper
RUN  go test github.com/NYTimes/gcs-helper
RUN  go install github.com/NYTimes/gcs-helper

FROM alpine:3.6
RUN apk add --no-cache ca-certificates
COPY --from=build /go/bin/gcs-helper /usr/bin/gcs-helper
ENTRYPOINT ["/usr/bin/gcs-helper"]
