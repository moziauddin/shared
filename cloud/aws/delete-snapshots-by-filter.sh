#!/bin/bash
# Dependencies: 
# Install jq
# Assign permissions to the instance running the script
#   1. Using IAM role (preferred)
#   2. Using AWS Key and Shared Secret in .aws/.credentials

if [[ -z $1 && -z $2 ]]; then
	echo ""
	echo " ERROR: Please pass the filter attribute as first argument and its value as second with wild card"
	echo "    Example: ./delete-old-snapshots.sh 'start-time' '2016*'"
        echo "    to delete all snapshots matching deleteOn date of Jan 2021"
	echo ""
	exit 1
fi
echo "Proceed with caution!"
echo "Once deleted, snapshots cannot be recovered"
echo "UNCOMMENT line 28 to actually delete"
snap_ids=$(aws ec2 describe-snapshots --filters Name=$1,Values=$2 | jq .Snapshots[].SnapshotId)
matched=$(echo $snap_ids | wc -w)
echo "Matched Snapshots: "$matched

if [[ $matched -ne 0 ]]; then
    for id in $snap_ids; 
    do
        new_id=$(echo $id | sed -e s/\"//g)
        echo "deleteing $new_id"
        # aws ec2 delete-snapshot --snapshot-id $new_id
    done
else
    echo "No Snapshots to delete"
fi
