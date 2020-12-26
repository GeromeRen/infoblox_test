#!/bin/bash

echo "[Info] Start to run terraform plan"

echo "[Debug] list files under /sharedfolder/infoblox-workspace"
cd /sharedfolder/infoblox-workspace
ls -ail && pwd

echo "[Debug] ~/.terraform.d/plugins"
ls -ail ~/.terraform.d/plugins

echo "[Debug] list files under /sharedfolder/infoblox-workspace"
ls -ail /sharedfolder/infoblox-workspace

cp /sharedfolder/infoblox-workspace/.terraformrc ~/.terraformrc

echo "[Debug] list files under home"
ls -ail ~

echo "[Debug] environment variable IPAM_ID"
printenv | grep IPAM_ID

echo "[Debug] environment variable IPAM_PWD"
printenv | grep IPAM_PWD

#echo "[Debug] Start to run terraform init"
#terraform init -plugin-dir "$HOME/.terraform.d/plugins/" -get-plugins=false
#
#echo "[Debug] Start to list terraform providers"
#ls -ail .terraform/plugins/linux_amd64
#terraform providers
#
#echo "[Debug] Start to run terraform plan"
#terraform plan -input=false -var "infoblox_username=$IPAM_ID"  -var "infoblox_password=$IPAM_PWD" -out "infoblox_tfplan.tfplan"
#
#echo "[Debug] List current folder after running terraform plan"
#ls -ail && pwd
#
#terraform show -json infoblox_tfplan.tfplan > infoblox_tfplan.json
#
#echo "[Debug] List current folder after running terraform show"
#ls -ail && pwd
#
#cp infoblox_tfplan.json /sharedfolder/infoblox_tfplan.json
#
#echo "[Debug] List sharedfolder folder after copying infoblox_tfplan.json to /sharedfolder"
#ls /sharedfolder
