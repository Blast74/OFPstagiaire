  echo "le nombre d'argument : $#"
  for((i=1;i<=4;i++)); do
    if ! [[ -z "${!i}" ]]; then
       echo "Argument n° $i : ${!i}"
    else
        echo "Argument n° $i : inexistant"
    fi
  done
  
  
