#!/bin/bash
# Dependencies: 
# Install jq
# Assign permissions to the instance running the script
#   1. Using IAM role (preferred)
#   2. Using AWS Key and Shared Secret in .aws/.credentials

if [[ -z $1 ]]; then
	echo ""
	echo " ERROR: Please pass the filter string as first argument"
	echo "    Example: ./delete-old-snapshots.sh '2021-01-*'"
    echo "    to delete all snapshots matching deleteOn date of Jan 2021"
	echo ""
	exit 1
fi
snap_ids=$(aws ec2 describe-snapshots --filters Name=tag:DeleteOn,Values=$1 | jq .Snapshots[].SnapshotId)
matched=$(echo $snap_ids | wc -w)
echo "Matched Snapshots: "$matched

if [[ $matched -ne 0 ]]; then
    for id in $snap_ids; 
    do
        new_id=$(echo $id | sed -e s/\"//g)
        echo "deleteing $new_id"
        aws ec2 delete-snapshot --snapshot-id $new_id
    done
    echo "Successfully removed $matched snapshots"
else
    echo "No Snapshots to delete"
fi
