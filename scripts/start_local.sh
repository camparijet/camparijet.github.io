#!/bin/bash

this_dir=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
repo_dir=$(cd ${this_dir}/../ && pwd)
hugo_dir=${repo_dir}/.hugo

_ip_addr=$(ip -o route get 8.8.8.8 | sed -e 's/^.* src \([^ ]*\) .*$/\1/')
[[ -z ${_ip_addr} ]] && _ip_addr=127.0.0.1
: ${ip_addr:=${_ip_addr}}
: ${_port:=38459}

cd ${hugo_dir}

hugo server -D -b "http://${ip_addr}" --bind ${ip_addr} --port ${_port} --disableFastRender
