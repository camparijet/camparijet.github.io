#!/bin/bash -ex

this_dir=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
repo_dir=$(cd ${this_dir}/../ && pwd)

: ${remote_repo_name:=origin}

cd ${repo_dir}

if ! git branch --list | grep gh-pages > /dev/null; then
    git checkout master
    git checkout --orphan gh-pages
    git reset --hard
    echo iamhi.de > CNAME
    git add -f CNAME
    git commit --allow-empty -m "Initializing gh-pages branch"
    git push -f ${remote_repo_name} gh-pages
fi
git checkout master
