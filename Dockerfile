FROM ubuntu:20.04 as build

WORKDIR /dero

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y wget \
    && wget https://github.com/deroproject/derohe/releases/download/Release50/dero_linux_amd64.tar.gz \
    && tar xfz dero_linux_amd64.tar.gz \
    && mv dero_linux_amd64/derod-linux-amd64 /usr/local/bin
#Somethign to consider for later (https://gist.github.com/steinwaywhw/a4cd19cda655b8249d908261a62687f8)

FROM ubuntu:20.04

# Expose rpc port
EXPOSE 9999
# Expose p2p port
EXPOSE 18089
# Expose getwork port
EXPOSE 10100

ENTRYPOINT ["derod-linux-amd64"]