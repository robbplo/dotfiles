function gql
  kubectx -c
  set pod (kubectl get pods --namespace frontend | grep data-api | head -n1 | awk '{print $1}')

  kubectl exec -qit -n frontend $pod -- ./bin/server rpc "DataRPC.Data.gql(\"$argv[2]\", %{application_id: \"$argv[1]\"}) |> IO.inspect()"
end

