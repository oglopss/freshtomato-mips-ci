#!/usr/bin/env bash

export BROADCOM_SDK=src-rt
export GH_TOKEN=NOTSET

if [ -z $1 ]; then
  BUILDS="z,9 r2z,24 n60z,38"
else
  BUILDS=$1,1
fi

idx=1

for i in $BUILDS; do
  # echo building $i

  KEY=${i%,*};
  VAL=${i#*,};
  echo $KEY" --- fake job number "$VAL;

  export TT_BUILD=$KEY
  export TRAVIS_JOB_NUMBER=$VAL

  cd ~/freshtomato-mips
  git clean -xfd
  git checkout .

  echo current dir: `pwd`

  . ~/freshtomato-mips-ci/.travis.sh

  # pre_build_prep

  cd ~/freshtomato-mips/release/$BROADCOM_SDK

  build_tomato

  cd ~/freshtomato-mips/release/$BROADCOM_SDK

  # only upload to my repo if manual argument is passed
  if [ "GH_TOKEN" != "NOTSET" ]; then
    . ~/freshtomato-mips/update-gh-pages.sh manual
  fi

  # break

done





