#!/bin/bash -xe

##################################################################################
function usage(){
  echo "usage: $(basename $0) /path/to/jenkins_home archive.tar.gz"
}
##################################################################################

readonly JENKINS_HOME=$1
readonly DIST_FILE=$2
readonly CUR_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
readonly ARC_DIR="$CUR_DIR/jenkins-backup"

if [ -z "$JENKINS_HOME" -o -z "$DIST_FILE" ] ; then
  usage >&2
  exit 1
fi

mkdir -p $ARC_DIR
tar xzvf $DIST_FILE -C $ARC_DIR --strip-components=1

rm -rf $JENKINS_HOME/*
cp -a $ARC_DIR/* $JENKINS_HOME
chown -R 1000.1000 $JENKINS_HOME/*

rm -rf $ARC_DIR
