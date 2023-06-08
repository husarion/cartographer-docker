ARG ROS_DISTRO=humble
ARG PREFIX=

FROM husarnet/ros:${PREFIX}${ROS_DISTRO}-ros-core

SHELL ["/bin/bash", "-c"]

ARG PREFIX
ENV PREFIX_ENV=$PREFIX

RUN apt update && apt upgrade -y && \
    # install build tools
    apt install -y \
        ros-$ROS_DISTRO-cartographer-ros && \
    # clean to make the image smaller
    apt autoremove -y && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*


COPY config/pr2.lua /opt/ros/humble/share/cartographer_ros/configuration_files/pr2.lua
RUN echo $(cat /ros2_ws/src/cartographer_ros/package.xml | grep '<version>' | sed -r 's/.*<version>([0-9]+.[0-9]+.[0-9]+)<\/version>/\1/g') > /version.txt
