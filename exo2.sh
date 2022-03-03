  echo "le nombre d'argument : $#"
  for ((i=1;i<=3;i++)); do
    if [[ -n "${!i}" ]]; then
      temp=$(ls -ld "${!i}")
     if [[ "${temp:0:1}" == "-" ]]; then
       echo "c'est un fichier ordinaire"
       echo "${!i} : [ ${temp:1:9} ]"
     fi
      if [[ "${temp:0:1}" == "s" ]]; then
       echo "c'est un fichier ordinaire"
     fi
     if [[ "${temp:0:1}" == "c" ]]; then
       echo "c'est un fichier char"
     fi
     
    fi
  done
  
  lsChar=("-" "s" "d" "c" "b" "p" "l")
  lsChamps=("Ordinaire" "socket" "répertoire" "caractère" "bloc" "Fifo" "Lien")

  echo "le nombre d'argument : $#"
  for((i=1;i<=3;i++)); do
    if [[ -n "${!i}" ]]; then
      temp=$(ls -ld "${!i}")
      for((i=0;i<${#lsChar[@]};i++)); do
        # echo "${lsChar["$i"]}"
       if [[ "${temp:0:1}" == ${lsChar["$i"]} ]]; then
         echo "le fichier est un fichier ${lsChamps["$i"]}"
         if [[ "${lsChar["$i"]}" == "-" ]]; then
           echo "${!i} : [ ${temp:1:9} ]"
         fi
         exit
       fi
      done
    fi
  done



  for indivArg in $@ ; do
    listing=$(echo $(ls -ld $indivArg))
    field=$(echo $listing | cut -d " " -f 1)
    droits=$(echo $field | cut -c 2-10)
    char=$(echo $field | cut -c 1)
   if [[ "${char}" == "-" ]]; then
     echo "$indivArg est une fichier avec comme droit $droits"
    elif [[ "${char}" == "d" ]]; then
     echo "$indivArg est une fichier repertoire"
    else
     echo "$indivArg est une fichier d'un autre type de fichier"
   fi
   
  done
  