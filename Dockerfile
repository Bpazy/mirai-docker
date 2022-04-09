FROM ubuntu:latest AS builder
RUN apt-get update \
    && apt-get install -y wget \
    && mkdir /mirai && cd /mirai \
    && wget https://github.com/iTXTech/mcl-installer/releases/download/v1.0.4/mcl-installer-1.0.4-linux-amd64  -O mcl-installer \
    && chmod +x ./mcl-installer \
    && yes '' | ./mcl-installer
COPY entrypoint.sh /mirai/entrypoint.sh
RUN chmod +x /mirai/entrypoint.sh

FROM ubuntu:latest AS runner
COPY --from=builder /mirai /mirai
WORKDIR /mirai
ENTRYPOINT ["./entrypoint.sh"]
