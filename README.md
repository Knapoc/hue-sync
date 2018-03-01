# hue-sync
[![](https://images.microbadger.com/badges/image/knapoc/hue-sync.svg)](https://microbadger.com/images/knapoc/hue-sync "Get your own image badge on microbadger.com")

Dockerized version of [hue-sync](https://github.com/kwasmich/shairport-sync) [shairport-sync fork](https://github.com/mikebrady/shairport-sync).

### Build

```bash
# Build version master
docker build -t knapoc/hue-sync .

# Build other version
docker build --build-arg SHAIRPORT_VERSION=master -t knapoc/shairport-sync:master .
```

### Run

```bash
docker run -d \
    --name=container_name
    --net=host \
    --device=/dev/snd:/dev/snd \
    -e "HUE_BRIDGE_IP=0.0.0.0" \
    -e "BRIDGE_ACCESS_IDENTIFIER=randomidentifier" \
    -e "HUE_LAMP_COUNT=1,2,3" \
    -e "AIRPLAY_NAME=hue-sync-docker" \
    knapoc/shairport-sync
```

### Compose

```yaml
  version: '2'
  services:
    shairportSync:
      restart: always
      image: knapoc/shairport-sync
      network_mode: host
      environment:
        - "HUE_BRIDGE_IP=0.0.0.0"
        - "BRIDGE_ACCESS_IDENTIFIER=randomidentifier"
        - "HUE_LAMP_COUNT=1,2,3"
        - "AIRPLAY_NAME=hue-sync-docker"
      devices:
        - "/dev/snd:/dev/snd"
```

### Parameters

* `--net=host` **must** be run in host mode
* `--device=/dev/snd:/dev/snd` share host alsa system with container. Does not require `--privileged` as `-v /dev/snd:/dev/snd` would
* environment variables:
  * `HUE_BRIDGE_IP`: the ip of your hue bridge
  *  `BRIDGE_ACCESS_IDENTIFIER`: your developer identifier. For further information please check this [link](https://developers.meethue.com/documentation/getting-started).
  * `HUE_LAMP_COUNT`: Lights that are going to be controlled (The number of the lamp as it is shown in your hue App).
  * `AIRPLAY_NAME`: sets the AirPlay device name. Defaults to hue-sync-docker.
