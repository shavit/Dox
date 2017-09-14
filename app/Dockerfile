FROM golang:1.9

ENV GOPATH=/app
ENV PATH=$PATH:$GOPATH/bin
ENV DATABASE_URI=${DATABASE_URI}

WORKDIR /app

RUN go get github.com/lib/pq

ADD $PWD /app/src/app
