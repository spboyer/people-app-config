export GROUP="shboyer-aks"
export CLUSTER_NAME="shboyer-demo-cluster"

# password needed for the Windows nodes if we create a Win Node Pool
export PASSWORD_WIN="P@ssw0rd1234"

az group create -l eastus -n $GROUP

#create the aks cluster
az aks create \
    --resource-group $GROUP \
    --name $CLUSTER_NAME \
    --node-count 1 \
    --enable-addons monitoring \
    --kubernetes-version 1.14.0 \
    --generate-ssh-keys \
    --windows-admin-password $PASSWORD_WIN \
    --windows-admin-username azureuser \
    --enable-vmss \
    --network-plugin azure

# set kubectl context
az aks get-credentials -g $GROUP -n $CLUSTER_NAME

#sh ./serviceprincipal.sh

az aks browse -n $CLUSTER_NAME -g $GROUP

# create the windows node pool
az aks nodepool add \
    --resource-group $GROUP \
    --cluster-name $CLUSTER_NAME \
    --os-type Windows \
    --name npwin \
    --node-count 1 \
    --kubernetes-version 1.14.0