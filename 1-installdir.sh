#!bin/sh

mkdir /opt/sn
ln -s $(pwd) /opt/sn
mkdir /.ssh
chmod 700 /.ssh
cp ssh/* /.ssh/
chmod 600 /.ssh/*
