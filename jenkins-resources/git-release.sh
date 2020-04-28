#!bin/sh

branch="$1"
bump="1"
user=$2
pass=$3
repo=$4

echo "API Name is: $branch"

git status
output=$(git describe --abbrev=0 --tags)

if [ "$output" = "" ]; then
    echo "not tag avaialble"
    newtag="$branch-v1"
else
    echo "tag available"
    oldv="$( echo "$output" | cut -d'v' -f2)"
    echo "$oldv"
    newv=$(echo "$oldv + $bump" | bc)
    newtag="$branch-v$newv"
fi
git tag $newtag
git push https://$user:$pass@github.com/$repo.git $newtag

echo "$newtag"
git checkout tags/$newtag -b $newtag
export releaseversion=$newtag
