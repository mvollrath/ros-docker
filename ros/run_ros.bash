#!/usr/bin/env bash

. /opt/ros/indigo/setup.bash
. /root/ros.conf

exec roslaunch --local --screen /root/run_ros.launch
