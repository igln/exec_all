
# use ./exec_all.sh 'command' 'container_name' 'pods that contains string'
kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep  $3 > /tmp/temp_pod_name
for i in `cat /tmp/temp_pod_name`
do
    kubectl exec -c "$2" --stdin --tty "$i" -- /bin/bash -c "$1"
done
rm -rf /tmp/temp_pod_name