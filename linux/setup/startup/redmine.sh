#!/bin/bash

#echo redmine >> /work/debug.log
ruby script/rails server webrick -e production -d
