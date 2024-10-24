#!/bin/bash

set -e

WEBRTC_COMMIT_SHA="b5289d72befbebeced0fb540baab1225379209d0"

# Checkout depot_tools
if [[ ! -d depot_tools ]]; then
  git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
fi
pushd depot_tools
export PATH=$(pwd):$PATH
popd

# Checkout WebRTC
if [[ ! -d webrtc ]]; then
  mkdir webrtc
  pushd webrtc
  fetch --nohooks webrtc
  popd
fi

pushd webrtc/src
git checkout -f $WEBRTC_COMMIT_SHA
gclient sync -v

# Build WebRTC
gn gen out/Default
ninja -C out/Default
popd
