FROM golang:1.16.6 as builder
ENV ROOT /go/src/
WORKDIR ${ROOT}
COPY go.mod go.sum ./
RUN go mod download
COPY main.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -o /go/bin/main

FROM golang as main
# FROM scratch as main
ENV TZ Asia/Tokyo
COPY --from=builder /go/bin/main /main
USER nobody
CMD ["/main"]