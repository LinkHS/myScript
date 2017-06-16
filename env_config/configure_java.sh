#!/bin/bash

export JAVA_HOME=/opt/JAVA/java-7-openjdk-amd64
export JRE_HOME=$JAVA_HOME/jre
export CLASSPATH=$CLASSPATH:$JAVA_HOME/lib:$JRE_HOME/lib
export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$JAVA_HOME:$JAVA_HOME/lib:$PATH

