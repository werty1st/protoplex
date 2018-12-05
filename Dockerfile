# build
FROM golang:latest AS build

COPY protoplex/ /tmp/protoplex/protoplex
COPY protoplex.go /tmp/protoplex/
RUN go build -o /tmp/protoplex/protoplex /tmp/protoplex/protoplex.go

# deploy
FROM alpine:latest
COPY --from=build /tmp/protoplex/protoplex /protoplex

USER 999
ENTRYPOINT ["/protoplex"]
EXPOSE 8443/tcp
STOPSIGNAL SIGINT
