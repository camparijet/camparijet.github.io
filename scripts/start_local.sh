#!/bin/bash

this_dir=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
repo_dir=$(cd ${this_dir}/../ && pwd)

_ip_addr=$(ip -o route get 8.8.8.8 | sed -e 's/^.* src \([^ ]*\) .*$/\1/')
[[ -z ${_ip_addr} ]] && _ip_addr=127.0.0.1
: ${ip_addr:=${_ip_addr}}
: ${_port:=38459}

hugo server -D -b "https://${ip_addr}" --bind ${ip_addr} --port ${_port} --disableFastRender
