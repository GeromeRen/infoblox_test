#!/bin/bash

echo "[Info] ############# Begin terraform plan #############"

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

echo "[Debug] 6. Start to run terraform init"
terraform init \
  -plugin-dir "$HOME/.terraform.d/plugins/" \
  -get-plugins=false \
  -backend-config="storage_account_name=sa5064iactf" \
  -backend-config="container_name=$AZURERM_BACKEND_STORAGE_CONTAINER" \
  -backend-config="key=$AZURERM_BACKEND_STORAGE_CONTAINER_BLOB_KEY"

echo "[Debug] 7. Start to run terraform workspace"
terraform workspace select ${CLOUD_ENV_NAME} || terraform workspace new ${CLOUD_ENV_NAME}
terraform workspace list -no-color 

echo "[Debug] 8. Start to list terraform providers"
ls -ail .terraform/plugins/linux_amd64
terraform providers

echo "[Debug] 9. Start to run terraform plan"

terraform plan -input=false -var "infoblox_username=$IPAM_ID"  -var "infoblox_password=$IPAM_PWD" -out "infoblox_tfplan.tfplan" -var-file="cloud-${CLOUD_ENV_NAME}.tfvars"

echo "[Debug] 10. Start to run terraform apply"
#terraform apply -auto-approve -lock=true -lock-timeout=10m -input=false -no-color ./infoblox_tfplan.tfplan

echo "[Debug] 11. List current folder after running terraform plan"
ls -ail && pwd

echo "[Info] ############# End terraform apply #############"