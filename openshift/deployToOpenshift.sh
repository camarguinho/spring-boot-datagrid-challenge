# define configuration variables
export NAMESPACE_USER="user1"
#export RHDG_URL=$(oc get route ${CLUSTER_NAME}-external -n ${CLUSTER_NAMESPACE} -o template='https://{{.spec.host}}')
export datagrid_cluster=rhdg
export app_name=challenge3
export datagrig_namespace=${NAMESPACE_USER}-${app_name}
export RHDG_URL=${datagrid_cluster}.${datagrig_namespace}.svc.cluster.local:11222
export git_repo=https://github.com/camarguinho/spring-boot-datagrid-challenge.git

# generate configmap configuration
oc create configmap ${app_name}-config --dry-run=client \
--from-file=application.properties=./application-k8s.properties \
-n $datagrig_namespace \
-o yaml > configmap.yaml

# generate oc resources configuration
oc process -f ./rhdg-client.yaml \
-p APPLICATION_NAME=$app_name \
-p GIT_REPOSITORY=$git_repo \
-p APP_NAMESPACE=$datagrig_namespace \
-p RHDG_CLUSTER_NAME=$datagrid_cluster \
-p DATAGRID_AUTH_ENABLED=true > openshift.yaml

# apply generated configuration
oc apply  -f configmap.yaml 
oc apply -f openshift.yaml