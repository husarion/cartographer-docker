# cartographer-docker

Building a Docker image with Cartographer.

Available for ROS distros:
- ROS 2 humble

Using in Docker Compose:

```yaml
  cartographer:
    image: husarion/cartographer:humble
    volumes:
        - ./config/pr2.lua:/pr2.lua
    command: >
      ros2 run cartographer_ros cartographer_node
        -configuration_directory /
        -configuration_basename pr2.lua

  cartographer-occ:
    image: husarion/cartographer:humble
    command: >
      ros2 run cartographer_ros cartographer_occupancy_grid_node
        -resolution 0.05
        -publish_period_sec 1.0
```

## Building locally for multiple architectures

```bash
sudo apt install -y qemu-user-static binfmt-support
docker buildx build --platform linux/arm64,linux/amd64 -t cartographer-test --build-arg PREFIX=vulcanexus- .
```