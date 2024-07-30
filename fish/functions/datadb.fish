function datadb
  set pod (kuber pick_a_pod betty6)

  # get database config as json
  set command "Betty.App.Matcher.match!(\"$argv[1]\") |> Map.get(:database) |> Jason.encode!() |> IO.puts"
  set config (kubectl exec -n frontend -it $pod -- bin/betty rpc $command | head -n 1)
  echo  $config

  kubectl exec -n frontend -it $pod -- mysql \
    -h (echo $config | jq -r .host) \
    -u (echo $config | jq -r .username) \
    -p(echo $config | jq -r .password) \
    -D (echo $config | jq -r .database)

end
