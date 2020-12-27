#!/bin/bash

echo "[Info] ############# Start to run terraform plan #############"

echo "[Debug] 1. Print Environment Variables:"
echo "[Debug] environment variable IPAM_ID"
printenv | grep IPAM_ID
echo "[Debug] environment variable IPAM_PWD"
printenv | grep IPAM_PWD
echo "[Debug] environment variable AZURERM_BACKEND_STORAGE_CONTAINER"
printenv | grep AZURERM_BACKEND_STORAGE_CONTAINER
echo "[Debug] environment variable AZURERM_BACKEND_STORAGE_CONTAINER_BLOB_KEY"
printenv | grep AZURERM_BACKEND_STORAGE_CONTAINER_BLOB_KEY
echo "[Debug] environment variable CLOUD_ENV_NAME"
printenv | grep CLOUD_ENV_NAME

echo "[Debug] 2. List files under /sharedfolder/infoblox-workspace"
cd /sharedfolder/infoblox-workspace
ls -ail && pwd

echo "[Debug] 3. List ~/.terraform.d/plugins"
ls -ail ~/.terraform.d/plugins

echo "[Debug] 4. List files under /sharedfolder/infoblox-workspace"
ls -ail /sharedfolder/infoblox-workspace

cp /sharedfolder/infoblox-workspace/.terraformrc ~/.terraformrc

echo "[Debug] 5. List files under home"
ls -ail ~

#echo "[Debug] Start to run terraform init"
#terraform init -plugin-dir "$HOME/.terraform.d/plugins/" -get-plugins=false -backend-config="storage_account_name=sa5064iactf"
terraform init \
  -plugin-dir "$HOME/.terraform.d/plugins/" \
  -get-plugins=false \
  -backend-config="storage_account_name=sa5064iactf" \
  -backend-config="container_name=$AZURERM_BACKEND_STORAGE_CONTAINER" \
  -backend-config="key=$AZURERM_BACKEND_STORAGE_CONTAINER_BLOB_KEY"

echo "[Debug] 6. Start to list terraform providers"
ls -ail .terraform/plugins/linux_amd64
terraform providers

echo "[Debug] 7. Start to run terraform plan"

terraform plan -input=false -var "infoblox_username=$IPAM_ID"  -var "infoblox_password=$IPAM_PWD" -out "infoblox_tfplan.tfplan" -var-file="cloud-$CLOUD_ENV_NAME"

echo "[Debug] 8. List current folder after running terraform plan"
ls -ail && pwd

terraform show -json infoblox_tfplan.tfplan > infoblox_tfplan.json

echo "[Debug] 9. List current folder after running terraform show"
ls -ail && pwd

cp infoblox_tfplan.json /sharedfolder/infoblox-workspace/infoblox_tfplan.json

echo "[Debug] 10. List sharedfolder folder after copying infoblox_tfplan.json to /sharedfolder"
ls /sharedfolder/infoblox-workspace
