#!/bin/bash

# config
default_semvar_bump=${DEFAULT_BUMP:-patch}
with_v=${WITH_V:-false}

# get latest tag
tag=$(git describe --tags `git rev-list --tags --max-count=1`)
tag_commit=$(git rev-list -n 1 $tag)

# get current commit hash for tag
commit=$(git rev-parse HEAD)

if [ "$tag_commit" == "$commit" ]; then
    echo "No new commits since previous tag. Skipping..."
    exit 0
fi

# if there are none, start tags at 0.0.0
if [ -z "$tag" ]
then
    log=$(git log --pretty=oneline)
    tag=0.0.0
else
    log=$(git log $tag..HEAD --pretty=oneline)
fi

# get commit logs and determine home to bump the version
# supports #major, #minor, #patch (anything else will be 'patch')
case "$log" in
    *#major* ) new=$(semver bump major $tag);;
    *#minor* ) new=$(semver bump minor $tag);;
    *#patch* ) new=$(semver bump patch $tag);;
    * ) new=$(semver bump `echo $default_semvar_bump` $tag);;
esac

# prefix with 'v'
if $with_v
then
    new="v$new"
fi

# release to github
generate_post_data()
{
  cat <<EOF
{
  "tag_name": "$new",
  "target_commitish": "",
  "name": "Auto release",
  "body": "",
  "draft": false,
  "prerelease": false
}
EOF
}


token=${GITHUB_TOKEN}
repo_full_name=$(git config --get remote.origin.url)
url=$repo_full_name
re="^(https|git)(:\/\/|@)([^\/:]+)[\/:]([^\/:]+)\/(.+).git$"

if [[ $url =~ $re ]]; then
protocol=${BASH_REMATCH[1]}
separator=${BASH_REMATCH[2]}
hostname=${BASH_REMATCH[3]}
user=${BASH_REMATCH[4]}
repo=${BASH_REMATCH[5]}
fi

echo "https://api.github.com/repos/$user/$repo/releases"

curl --data "$(generate_post_data)" "https://api.github.com/repos/$user/$repo/releases?access_token=$token"