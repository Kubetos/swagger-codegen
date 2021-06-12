#! /bin/bash

# Generate Client SDKs
# Python
./run-in-docker.sh generate -i /transaction_api/kubetos_transaction_api.yaml -l python -o /gen/out/kubetos_client_py -DpackageName=kubetos_client_py
# JS
./run-in-docker.sh generate -i /transaction_api/kubetos_transaction_api.yaml -l javascript -o /gen/out/kubetos_client_js -DpackageName=kubetos_client_js
# Generate Server stubs
# Python
./run-in-docker.sh generate -i /transaction_api/kubetos_transaction_api.yaml -l python-flask -o samples/server/kubetos_server_py -DpackageName=kubetos_server_py
# Go
./run-in-docker.sh generate -i /transaction_api/kubetos_transaction_api.yaml -l go-server -o samples/server/kubetos_server_go -DpackageName=kubetos_server_go

#Copy over to transaction_api repo
cp -rf out/kubetos_client_py ../transaction_api
cp -rf out/kubetos_client_js ../transaction_api
cp -rf samples/server/kubetos_server_go ../transaction_api
cp -rf samples/server/kubetos_server_py ../transaction_api
#Change connexion version due to issue with swagger and v1.1.15
sed -i '' 's/connexion == 1\.1\.15/connexion == 2\.7\.0/g' ../transaction_api/kubetos_server_py/requirements.txt
echo "DONE"
