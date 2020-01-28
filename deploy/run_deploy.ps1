Write-Host "####################################" -ForegroundColor Green
Write-Host "#           Deploy Starting        #" -ForegroundColor Green
Write-Host "####################################" -ForegroundColor Green

Write-Host "Creating Service Principal For Deploy..." -ForegroundColor White
$SUBSCRIPTION_ID = "#######################"

az account set --subscription=$SUBSCRIPTION_ID
$sp_result = az ad sp create-for-rbac --name dacrook-terraform | ConvertFrom-Json

Write-Host "Sleeping because sp creation returns before actual creation completed..." -ForegroundColor White
Start-Sleep 60

WRITE-HOST "Setting environment variables for Terraform" -ForegroundColor White

$env:ARM_SUBSCRIPTION_ID=$SUBSCRIPTION_ID
$env:ARM_CLIENT_ID=$sp_result.appId
$env:ARM_CLIENT_SECRET=$sp_result.password
$env:ARM_TENANT_ID=$sp_result.tenant

Write-Host "Running Terraform" -ForegroundColor Green
terraform init

terraform plan

terraform apply -auto-approve
Write-Host "Terraform Complete..." -ForegroundColor Green

Write-Host "Starting Compile & Containerize Steps" -ForegroundColor Green

$docker_user = terraform output acr_user_name
$docker_password = terraform output acr_password
$docker_login_server = terraform output acr_login_server

docker login -u $docker_user -p $docker_password $docker_login_server

Write-Host "Compiling & Containerizing Apis..." -ForegroundColor White
dotnet publish ../src/StreamCon.Apis/StreamCon.Apis.csproj -c Release -f netcoreapp3.1 -o StreamCon.Apis
docker build -t $docker_login_server"/streamconapis:latest" ./StreamCon.Apis

Write-Host "Compiling & Containerizing UI..." -ForegroundColor White
dotnet publish ../src/StreamCon.UI/StreamCon.UI.csproj -c Release -f netcoreapp3.1 -o StreamCon.UI
docker build -t $docker_login_server"/streamconui:latest" ./StreamCon.UI

Write-Host "Compiling & Containerizing Data Generator..." -ForegroundColor White
dotnet publish ../src/StreamCon.DataGenerator/StreamCon.DataGenerator.csproj -c Release -f netcoreapp3.1 -o StreamCon.DataGenerator
docker build -t $docker_login_server"/streamcondatagen:latest" ./StreamCon.DataGenerator

Write-Host "Finished Compile & Containerize Steps" -ForegroundColor Green

Write-Host "Start Pushing Containers to Remote Registry" -ForegroundColor Green
docker push $docker_login_server"/streamconapis:latest"
docker push $docker_login_server"/streamconui:latest"
docker push $docker_login_server"/streamcondatagen:latest"
Write-Host "Finished Pushing Containers to Remote Registry" -ForegroundColor Green

Write-Host "Cleaning Up Deploy Service Principal" -ForegroundColor Green
az ad sp delete --id $sp_result.appId

Write-Host "####################################" -ForegroundColor Green
Write-Host "#           Deploy Complete        #" -ForegroundColor Green
Write-Host "####################################" -ForegroundColor Green