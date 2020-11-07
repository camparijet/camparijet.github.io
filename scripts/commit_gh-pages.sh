#!/bin/bash -ex

this_dir=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
repo_dir=$(cd ${this_dir}/../ && pwd)
: ${remote_repo_name:=origin}
: ${hugo_base_dir:="${repo_dir}/.hugo"}
: ${output_dir:="${hugo_base_dir}/public"}

: ${build_for_local:=false}

hugo_build_opts=()

if [[ ${build_for_local} = true && -z ${hugo_build_opt_base} ]]; then
    _ip_addr=$(ip -o route get 8.8.8.8 | sed -e 's/^.* src \([^ ]*\) .*$/\1/')
    [[ -z ${_ip_addr} ]] && _ip_addr=127.0.0.1
    : ${ip_addr:=${_ip_addr}}
    hugo_build_opts+=("-b" "http://${ip_addr}")
fi

cd ${repo_dir}

if git worktree list | grep gh-pages > /dev/null; then
    git worktree prune -v
    git worktree remove --force ${output_dir}
fi
rm -rf ${output_dir}
git worktree add -B gh-pages ${output_dir} ${remote_repo_name}/gh-pages

# list_all_org_files(){
#     find $(git rev-parse --show-toplevel) -type f -name "*.org"
# }

# for iFile in $(list_all_org_files)
# do
#     echo $iFile is htmlized
#     emacs -q --eval '(setq vc-handled-backends nil)' -batch ${iFile} -l ~/.emacs.d/cj-lisp/localhost_export_ox-hugo.el -f my-org-export-html
# done

cd ${hugo_base_dir}
hugo "${hugo_build_opts[@]}"
if [[ ${build_for_local} != true ]]; then
    cd ${output_dir}
    git add --all
    git commit --no-verify -m "Publishing to gh-pages"
    git push ${remote_repo_name} gh-pages
fi
cd ${hugo_base_dir}
