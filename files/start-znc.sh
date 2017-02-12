#!/bin/sh

if [ ! -f "/home/znc/znc-firstrundone" ];
then
  mkdir -p /home/znc/.znc/configs

  if [ ! -f "/home/znc/.znc/configs/znc.conf" ];
  then
    cp /home/znc/default.conf /home/znc/.znc/configs/znc.conf
  fi

  touch /home/znc/znc-firstrundone
fi

/usr/local/bin/znc --foreground
