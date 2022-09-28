#!/bin/bash


function cleanup_image(){
    index=0
    for repos in $repository
    do  
    image_taglist=$(az acr repository show-tags --orderby time_desc --name $registry --repository $repos --output tsv )
    SAVEIFS=$IFS   
    IFS=$'\n'      
    image_taglist=($image_taglist) 
    IFS=$SAVEIFS   
    for prefix in $imgtag_prefix
    do
        for (( i=0; i<${#image_taglist[@]}; i++ ))
        do
            image_tag=`(echo ${image_taglist[$i]} | grep ^"$prefix")`
            for tag in $image_tag
            do
                echo "tag $i:$tag"
                if [ $index -lt $threshold_img_count ]
                then
                index=$((index+1))
                else
                echo "Deleting image : $repos:$tag"
                az acr repository delete --name $registry --image $repos:$tag -y
                fi
            done 
        done 
        index=0
    done  
    image_taglist=""
    done
}



registry=$1
repository=$2
IFS=","
imgtag_prefix=$3
IFS=","
threshold_img_count=$4
resource_group=$5
client_id=$6
client_secret=$7

subscription="82f6da0c-972f-4e06-b7f0-36e6a6303f46"
tenant_id="d138c625-5abd-4cfe-aaf6-4b1e605c1d0d"

az login --service-principal -u "${client_id}" -p "${client_secret}" --tenant "${tenant_id}" --verbose
az account set --subscription "${subscription}"

cleanup_image

az logout