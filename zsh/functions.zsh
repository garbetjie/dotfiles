#!/usr/bin/env zsh

function clear_dns() {
  sudo killall -HUP mDNSResponder;
}

function set_gcloud_config() {
  echo "$PWD"
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

function cloudsql() {
  # Ensure we have the SQL proxy installed.
  if ! type cloud_sql_proxy > /dev/null; then
    echo "CloudSQL Proxy not found. Ensure it is available in your \$PATH."
    return 1
  fi

  # Create the directory if it doesn't exist.
  if [ ! -d /tmp/cloudsql ]; then
    echo "Creating the /tmp/cloudsql directory. Please provide your password if prompted."
    sudo mkdir -p /tmp/cloudsql
    sudo chown "$(id -un):$(id -gn)" /tmp/cloudsql
  fi

  local instance_list=""
  local sep=""
  local help="Connections are available on the following sockets:\n"

  # If no args are given, then default to the tencentafrica-*-joox projects.
  if [ $# -lt 1 ]; then
    cloud_sql_proxy -dir /tmp/cloudsql -projects tencentafrica-testing-joox,tencentafrica-prod-joox,ta-org-prod
  else
    while [ $# -gt 0 ]; do
      instance_list="${instance_list}${sep}$1"
      help="$help - /tmp/cloudsql/$1\n"
      sep=","
      shift
    done

    echo "$help"
    cloud_sql_proxy -dir /tmp/cloudsql -instances "$instance_list"
  fi
}

#function kct() {
#  kubectl --context gke_tencentafrica-testing-joox_europe-west4_main "$@"
#}
#
#function kcp() {
#  kubectl --context gke_tencentafrica-prod-joox_europe-west4_main "$@"
#}
