# Spigot in a Box

A turnkey, high-performance Minecraft server inside a Docker container

## Getting Started

These instructions will help you get your own Minecraft server up and running in no time. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

Your only requirement is a system running Docker with a fair amount of RAM depending on how many instances you want to run. A good rule of thumb is about 4GB of RAM per instance and possibly more if you want to run any heavy plugins.

You can visit the official Docker website (here)[https://docs.docker.com/install/] for installation instructions.

### Installation

Getting an instance of your Spigot-powered Minecraft server up and running is remarkably easy and can be done with a single command:

```
docker run pragma8123/spigot-in-a-box:latest
```

This will start a server running on the default port of 25565. However, **this is not recommended as your server will not persist across container restarts.** For this, we need to mount a volume inside the container at `/minecraft`.

For example:

```
docker run -v /my-servers/server-1:/minecraft pragma8123/spigot-in-a-box:latest
```

This will mount the folder `/my-servers/server-1` from host machine inside the container at `/minecraft`. This will be the main working folder for the server containing our config files, logs, and world data.

From here we can add a few more options to our command and get this:

```
docker run \
  --restart unless-stopped \
  --detach \
  -e MEM_MIN=1G \
  -e MEM_MAX=4G \
  -v /my-servers/server-1:/minecraft \
  pragma8123/spigot-in-a-box:latest
```

Explanation:
- `--restart unless-stopped` - tell our container to restart if something crashes or the host system restarts
- `--detach` - run in the background
- `-e MEM_MIN=1G` - initial JVM heap size of 1GB
- `-e MEM_MAX=4G` - maximum JVM heap size of 4GB
- `-v /my-servers/server-1/:/minecraft` - mount volume
