#!/bin/bash

function setup() {    
    $shairport -o dummy -v &
    shairport_pid=$!

    sleep 5

    $pa_bin -n -F $default_pa -p $pa_dir/src --log-time=1 -vvvv >pulse.log 2>&1 &

    sleep 5

    pactl set-default-sink $sinkname
    if [ $? != 0 ]; then
	"Setting sink to $sinkname failed"
	return 1
    fi

    return 0
}

function teardown() {
    pactl exit
    kill $shairport_pid
}

setup
if [ ! $? ]; then
    exit 1
fi

do_test
if [ ! $? ]; then
    echo "Test failed"
fi

teardown

echo "Success"
