#!/bin/sh

api="$1"

output="$(kubectl get api $api -o json | jq '.metadata.name' -r)"
echo "$output"

dir=""
for d in */ ; do
    mkdir -p $d/Interceptors
    mkdir -p $d/libs
    dir="--from-file=$d $dir"
    echo "$dir"
done

if [ "$output" = "$api" ]; then
    echo "API exists in the system. Hence updaing the API"
    apictl update api -n $api $dir	
else
    echo "Adding API to the Kuberenetes"
    apictl add api -n $api $dir
fi
