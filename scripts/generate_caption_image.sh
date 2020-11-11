#!/bin/bash

this_dir=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
repo_dir=$(cd ${this_dir}/../ && pwd)
hugo_dir=${repo_dir}/.hugo
static_hugo_ox=${hugo_dir}/static/ox-hugo
static_hugo_caption=${hugo_dir}/static/captions

: ${sketch_blur:=30}

mkdir -p ${static_hugo_caption}

for i in $(ls ${static_hugo_ox}/*.png)
do
    # convert $i -sketch ${sketch_blur}x${sketch_blur} ${static_hugo_caption}/$(basename $i)
    output=${static_hugo_caption}/$(basename $i)
    [[ ! -f ${output} ]] && convert $i -blur 0x${sketch_blur} ${static_hugo_caption}/$(basename $i)
done
