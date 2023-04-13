FROM golang:1.18 AS build

WORKDIR /

COPY . .

RUN go mod download && go build -o /openstack-exporter .

FROM gcr.io/distroless/base:nonroot as openstack-exporter

LABEL maintainer="Thong Tran <thongth@vnpay.vn>"


COPY --from=build /openstack-exporter /bin/openstack-exporter

ENTRYPOINT [ "/bin/openstack-exporter" ]
USER root
EXPOSE 9180
