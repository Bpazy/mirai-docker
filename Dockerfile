FROM ubuntu:latest AS builder
RUN apt-get update \
    && apt-get install -y wget \
    && mkdir /mcl && cd /mcl \
    && wget https://github.com/iTXTech/mcl-installer/releases/download/v1.0.4/mcl-installer-1.0.4-linux-amd64  -O mcl-installer \
    && chmod +x ./mcl-installer \
    && yes '' | ./mcl-installer

FROM ubuntu:latest AS runner
COPY --from=builder /mcl /mcl
WORKDIR /mcl
ENTRYPOINT ["./mcl"]

# TODO 可选支持插件安装：https://github.com/Bpazy/blog/issues/220#issuecomment-1076067529
