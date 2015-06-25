#!/usr/bin/env bash

set -e

source /opt/ros/indigo/setup.bash

rosdep install --from-paths src --ignore-src --rosdistro indigo -y && apt-get clean

catkin_lint src

catkin_make
catkin_make run_tests
catkin_test_results

catkin_make install -DCMAKE_INSTALL_PREFIX=/opt/ros/indigo

