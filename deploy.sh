#!/bin/sh

A=`git rev-parse --abbrev-ref HEAD | sed -e 's/\///' | sed -e 's/feature//'`

echo $A
