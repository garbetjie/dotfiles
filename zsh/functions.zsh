#!/usr/bin/env zsh

function clear_dns() {
  sudo killall -HUP mDNSResponder;
}

function man-preview() {
  man -t "$@" | open -f -a Preview
}

function xdebug() {
  php \
    -dxdebug.remote_enable=1 \
    -dxdebug.remote_mode=req \
    -dxdebug.remote_port=9000 \
    -dxdebug.remote_host=127.0.0.1 \
    -dxdebug.remote_autostart=1 \
    "$@"
}

function kcc() {
  kubectl config current-context;
}

function b64_json() {
  b64 "$1" | jq .
}

function b64() {
  count="$(printf "%s" "$1" | wc -c)";
  b64="$1";
  [[ $((count % 4)) == 2 ]] && b64="${b64}==";
  [[ $((count % 4)) == 3 ]] && b64="${b64}=";
  echo "$b64" | base64 -d
}

#function kct() {
#  kubectl --context gke_tencentafrica-testing-joox_europe-west4_main "$@"
#}
#
#function kcp() {
#  kubectl --context gke_tencentafrica-prod-joox_europe-west4_main "$@"
#}
