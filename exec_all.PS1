# use .\exec_all.PS1 "command" 'container_name' 'pods that contains string'


$command=$args[0]
$container=$args[1]
$contain=$args[2]

kubectl get pods --no-headers -o custom-columns=":metadata.name" `
| Select-String "$contain" `
| Out-File -FilePath temp_pods_name.txt

foreach($line in Get-Content .\temp_pods_name.txt) {
    if ($line -ne "" ) {
        kubectl exec -c "$container" --stdin --tty "$line" -- /bin/bash -c "$command"
    }
}

del temp_pods_name.txt

