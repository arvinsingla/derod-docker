# Dero Daemon (derod) docker container

A simple docker container for the dero daemon (derod) 

When I say simple, I mean simple. All this docker container does is pull the most recently released binary and pass along whatever derod commands you want and executes them against the binary.

## Disclaimer

I built this for myself to easily host on my home infrastructure. No associations with the Dero team exist or are implied. No warranties, guarentees, or any kind of support are promised if you use this.

If you run this container with default settings the integrator address is set to a wallet I own. This can easily be changed by providing the `--integrator-address` as a parameter to the container

## Docker Hub

This repo is used to build the images available at:

https://hub.docker.com/r/arvinsingla/derod

## Recommended Usage

The docker image itself simply runs the derod binary without passing ay parameters. This means you are responsible for passing all parameters required to run.

I highly recommend you mount a volume to the container that will store the mainnet blockchain files in the event your container gets destroyed you can easily spin up another using the same data.

### Command line

This executes the container directly from the command line. Any derod options you want to pass can be chained at the end of the docker run command.

```
docker run -it --name="derod" -p 10100:10100 -p 10102:10102 -p 18090:18090 -v /SOMEWHERE_I_WANT_MY_FILES/dero:/mnt/dero arvinsingla/derod:latest --data-dir=/mnt/dero --p2p-bind=0.0.0.0:18090 --rpc-bind=0.0.0.0:10102 --integrator-address YOUR_WALLET_ADDRESS
```

Here's a breakdown of the above command. If none of this makes sense to you then you probably need to learn more about docker, the derod, or both.

* `docker run -it --name="derod"`: Primary docker command to run a container in terminal interactive mode and give it a name
* `-p 10100:10100 -p 10102:10102 -p 18090:18090`: Expose the port 10100, 10102, and 18090 to the network interface
* `-v /SOMEWHERE_I_WANT_MY_FILES/dero:/mnt/dero`: Mounts the local folder `/SOMEWHERE_I_WANT_MY_FILES/dero` to the container folder `/mnt/dero`
* `arvinsingla/derod:latest`: Pointing to this docker image
* `--p2p-bind=0.0.0.0:18090`: Bind p2p to the network interface on port 18090 (Used for peer node connections)
* `--rpc-bind=0.0.0.0:10102`: Bind rpc to the network interface on port 10102 (Used for wallet and other connections)
* `--integrator-address`: Add your wallet address to ensure 100% payments

To see a list of available derod options you can run the following.

```
docker run --name="derod" arvinsingla/derod:latest --help
```

### Docker compose

This container works great with docker compose. The example above is replicated as the following `docker-compose.yml`    

```
version: '3'
services:
  derod:
    image: arvinsingla/derod:latest
    restart: unless-stopped
    container_name: derod
    tty: true
    stdin_open: true
    volumes:
      - /SOMEWHERE_I_WANT_MY_FILES/dero:/mnt/dero
    ports:
      - 10100:10100
      - 10102:10102
      - 18090:18090
    command: >-
      --data-dir=/mnt/dero
      --p2p-bind=0.0.0.0:18090
      --rpc-bind=0.0.0.0:10102
      --integrator-address YOUR_WALLET_ADDRESS
```

## Donation

Found it useful? Feel free to donate!

`dero1qynxvpudx7rhs5z2h6cnll94e446k9hpcaxc8jw322h9ycsd7c0fjqg9lyzel`