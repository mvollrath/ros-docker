ros-docker
==========

A [Docker](https://www.docker.com/) project for building, testing, installing, and running ROS software in a container with an exposed [rosbridge](http://wiki.ros.org/rosbridge_suite) node.

##### Why would you want to put ROS in a container?

ROS for OS X is unsupported, so this exists as a prepared solution for running tests, playing with rosbridge, developing [roslibjs](http://wiki.ros.org/roslibjs) applications, or creating a container-ized build farm.

If you need a mature, industrial build farm, refer to the [ROS build farm](http://wiki.ros.org/buildfarm) project which is also based on Docker.

### Building the image

Optionally, drop your ROS packages into `src/`.  Any packages in this path will be built and installed.  `rosdep` will attempt to install any declared dependencies.

By default, the container will run rosbridge websocket and rosapi nodes.  Add any additional launch activity you want to `user.launch`.

If you're running your own packages, be sure to set up install targets in `CMakeLists.txt` or roslaunch won't be able to find your stuff.

Finally, build the container:

    $ docker build -t rosdev /path/to/ros-docker

### Running the image

Be sure to specify local port forwarding when starting the container.

Running in the foreground (with screen output from roslaunch):

    $ docker run -p 9090:9090 -i -t rosdev

Running in the background:

    $ docker run -p 9090:9090 -d rosdev

While the container is runnning, you should be able to connect to its rosbridge socket at `ws://localhost:9090`.

Verify in a Chrome dev console or use [wscat](http://einaros.github.io/ws/):

    $ wscat --connect ws://localhost:9090
    connected (press CTRL+C to quit)
    >

### OS X

If you're using a Mac, you'll need to set up [boot2docker](http://docs.docker.com/installation/mac/).

### Boot2Docker port forwarding

Once boot2docker is running and the `docker` command is working, run the `boot2docker_forward.sh` script to forward the rosbridge port through the VM.

