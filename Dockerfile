FROM golang:1.13-buster as builder

WORKDIR /tmp/dummy-service

COPY . ./

RUN make build

# ---

FROM gcr.io/distroless/static-debian10:fd0d99e8c54d7d7b2f3dd29f5093d030d192cbbc

COPY --from=builder /tmp/dummy-service/bin/dummy-service /

EXPOSE 8080

CMD ["/dummy-service"]
