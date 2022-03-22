FROM ubuntu:20.04

WORKDIR /dero

COPY get-latest-dero-release.sh .

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y wget curl \
    && chmod +x get-latest-dero-release.sh \
    && ./get-latest-dero-release.sh \
    && mv dero_linux_amd64/derod-linux-amd64 /usr/local/bin

# Expose rpc port
EXPOSE 10102
# Expose p2p port
EXPOSE 18089
# Expose getwork port
EXPOSE 10100

HEALTHCHECK --interval=30s --timeout=5s CMD curl -f -X POST http://localhost:10102/json_rpc -H 'content-type: application/json' -d '{"jsonrpc": "2.0","id": "1","method": "DERO.Ping"}' || exit 1

# Start derod with sane defaults that are overridden by user input (if applicable)
ENTRYPOINT ["derod-linux-amd64"]
CMD ["--rpc-bind=0.0.0.0:10102", "--p2p-bind=0.0.0.0:18089", "--data-dir=/mnt/dero", "integrator-address dero1qynxvpudx7rhs5z2h6cnll94e446k9hpcaxc8jw322h9ycsd7c0fjqg9lyzel"]