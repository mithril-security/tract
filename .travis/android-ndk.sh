#!/bin/sh

set -ex

which java || (
sudo apt install -y default-jdk
# sudo    apt-get install -y software-properties-common
# sudo add-apt-repository ppa:linuxuprising/java
# sudo apt-get update
# echo debconf shared/accepted-oracle-license-v1-2 select true | debconf-set-selections
# echo debconf shared/accepted-oracle-license-v1-2 seen true | debconf-set-selections
# sudo apt-get install -y oracle-java11-installer ca-certificates-java python
#    apt-get install -y software-properties-common
#    add-apt-repository -y ppa:webupd8team/java
#    apt-get update
#    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
#   echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
#    apt-get install -y oracle-java9-installer ca-certificates-java python
)

# export JAVA_OPTS='-XX:+IgnoreUnrecognizedVMOptions --add-modules java.se.ee'

ANDROID_SDK=$HOME/cached/android-sdk
if [ ! -d "$ANDROID_SDK" ]
then
    mkdir -p $ANDROID_SDK
    cd $ANDROID_SDK

      # ANDROID_SDK_VERSION=4333796
      # "https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip"

    curl -s -o android-sdk.zip \
       https://dl.google.com/android/repository/commandlinetools-linux-8092744_latest.zip
    unzip -q android-sdk.zip
    rm android-sdk.zip
fi

yes | $ANDROID_SDK/cmdline-tools/bin/sdkmanager --sdk_root=$ANDROID_SDK --licenses > /dev/null

$ANDROID_SDK/cmdline-tools/bin/sdkmanager --sdk_root=$ANDROID_SDK \
    "build-tools;30.0.0" "platform-tools" "platforms;android-31" "tools" "ndk-bundle" \
    > /dev/null
