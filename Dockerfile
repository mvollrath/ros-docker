# Creates a trusty+indigo ROS environment.
FROM ubuntu:trusty
MAINTAINER Matt Vollrath <matt@endpoint.com>

# Update everything
RUN apt-get update && apt-get -y upgrade

# Install system dependencies.
RUN apt-get -y install g++

# Prepare ROS sources.
RUN echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list
ADD https://raw.githubusercontent.com/ros/rosdistro/master/ros.key /root/ros.key
RUN cat /root/ros.key | apt-key add -
RUN apt-get update && apt-get -y install ros-indigo-ros-base ros-indigo-rosbridge-suite python-catkin-lint
RUN rosdep init && rosdep update

# Trim the image by clearing cached packages.
RUN apt-get clean

# Create a catkin workspace.
RUN mkdir -p /root/catkin_ws/src
WORKDIR /root/catkin_ws/src
RUN bash -c "source /opt/ros/indigo/setup.bash && catkin_init_workspace"

# Expose rosbridge port.
EXPOSE 9090

# Install ROS scripts.
COPY ros/ros.conf /root/ros.conf
COPY ros/run_ros.bash /root/bin/run_ros.bash
COPY ros/run_ros.launch /root/run_ros.launch
COPY ros/build.bash /root/bin/build.bash

# Build user ROS packages.
WORKDIR /root/catkin_ws
COPY src /root/catkin_ws/src/
RUN /bin/bash /root/bin/build.bash

# Install user launch configuration.
COPY user.launch /root/user.launch

# Start things up.
CMD exec /bin/bash /root/bin/run_ros.bash
