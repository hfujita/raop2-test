#!/bin/bash

if [ ! -r ./config.sh ]; then
    echo "./config.sh not found! Please edit config.sh.sample and copy it as config.sh."
    exit 1
fi

. ./config.sh

function do_test()
{
    $mp3play $mp3file
}

. ./common.sh
