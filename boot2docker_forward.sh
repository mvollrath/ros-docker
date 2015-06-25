#!/bin/sh

VBoxManage controlvm boot2docker-vm natpf1 "rosbridge,tcp,127.0.0.1,9090,,9090"
