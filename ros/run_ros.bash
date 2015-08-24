#!/usr/bin/env bash

. /opt/ros/indigo/setup.bash
. /root/ros.conf

Xvfb :0 &
spacenavd &
exec roslaunch --local --screen /root/run_ros.launch
