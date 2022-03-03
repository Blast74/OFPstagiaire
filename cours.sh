#!/bin/bash

#^^^^^^^^^^ shebang defini l'interpresteur/shell pour exécuter le script

###déclarer et initialiser une variable

age=18

###incrémenter un variable de 2

age=$((age+2))



# if [ -e eleve.txt ]; then
#      # if body
#      echo "le fichier est là !!"
# elif [ $age -eq 18 ]; then
#      # else if body
#      echo "l'age est de 18 super vous êtes majeur"
# else
#      # else body
#      echo "le fichier n'est pas là"
# fi

###redefinir un variable

age=71

###numérique

intvar=1

###nombre réel

float=0.2

###chaine de caractère

string="hello world"


# if [ $age -lt 18 ]; then
#      # if body
#      echo "vous êtes mineur"
# elif [ $age -ge 18 ] && [ $age -le 70 ]; then
#      # else if body
#     echo "vous avez le bon age "
# else
#      # else body
#      echo "vous etes trop vieux"
# fi

# toto=


###boucle for  

# for((toto=0;toto<15;toto+=2)); do
    
#     echo "${toto}"
#     # toto=$((toto+1))
# done


#  for item in `cat ./eleve.txt`; do
#       echo "${item}"
#  done
 
###boucle for 

 for col in $(ps aux | awk '{ print $3":"$2 }'); do
     echo "${col}" | cut -d ':' -f 1
     echo "${col}" | cut -d ':' -f 2
 done
 
read -p "reponse :" answer
 if [ "$answer" = "o" ]; then
      echo "operation annulé"
 else
      echo "fait quelque chose"
 fi

###boucle while

# while [ true ]; do
#      echo "hello wolrd !"
# done

###afficher un chiffre un nombre aléatoire entre 1 et 10

echo $(($RANDOM % 10 +1))



function echo_var () {
     echo "$1" # de 1 à 9
}

$?

echo_var "toto" tata titi

declare -a tab1

tab2=(
     hello
     wolrd
     coucou
)
tab2=(hello world coucou)
#tab["indice"]=valeur

tab2[4]="online"

tab2[2]=laclasse

echo ${tab2[*]}
echo ${#tab2[*]}
echo ${#tab2[2]}

#boucle select
#Exemple

PS3="Votre réponse : "
echo "Que choisissez-vous ?"
IFS=""
tab=("salut les amis" "coucou" "on est là !") 
select rep in ${tab[*]} 
do
echo "vous avez choisi $rep"
if [[ "$rep" == "on est là !" ]] ;then 
    break; #Utiliser une fonction serait judicieux
fi
done


#Options + arguments d'options

while getopts ":v:g:" option; do
    case "${option}" in
        v)
            v=${OPTARG} #initialise une variable v avec comme valeur OPTARG 
            #OPTARG est l'argument suivant -v dans l'execution du script 
            #exemple read -p "voulez vous continuer ?" --> OPTARG="voulez vous continuer ?"
            if ((v == 15 || v == 75));then
                echo 'egale à 15 ou 75'
            else
                echo 'non'
            fi 
            ;;
        g)
            g=${OPTARG}
            ;;
        *)
            echo 'Option non définie'
            ;;
    esac
done
shift $((OPTIND-1))

    echo "v = ${v}"
    echo "g = ${g}"

#### à tester
# ./test.sh -v coucou -g file.txt
# ./test.sh -j

#exemple ssh 
#connexion avec mot de passe
ssh  -t -l login -p 22 192.168.1.x 'ls -a'
#connexion avec clé ssh
ssh  -i ./ssh_key -t  -p 22 login@192.168.1.x 'ls -a'


#Fonction utiles 

function MergeDataToString () {
   if [[ -z "${1}" ]] && [[ -z "${2}" ]] && [[ -z "${3}" ]] && [[ -z "${4}" ]]  ; then
        echo 1
        return 1
    else
       if (( $# < 4 )); then
            echo 2
            return 1
       else
            echo "$1$4$2$4$3"
            return 0
       fi
       
   fi
   
}

#fonction prenant en entrée une chaine de caractère qui vérifie si la saisie utilisateur est bien "o" ou "n"
function testOuiNon () {
    local reset=0
    while [ ${reset} = 0 ]; do
    read -p "$1 [o/n]" reponse 
    if [[ "${reponse}" =~ ^[oO]$ ]]; then
        echo "0"
        reset=1
    elif [[ ${reponse} =~ ^[nN]$ ]]; then 
            echo "1"
            reset=1
    else
        reset=0
    fi   
   done

}

#fonction plus optimisée prenant en entrée une chaine de caractère qui vérifie si la saisie utilisateur est bien "o" ou "n"
function testYesNo () {
    local reset=0
    while [ ${reset} = 0 ]; do
    read -p "$1 [o/n]" reponse 
    if [[ "${reponse}" == "o" ]] || [[ "${reponse}" == "O" ]]; then
        echo "0"
        reset=1
    elif [[ "${reponse}" == "n" ]] || [[ "${reponse}" == "N" ]]; then 
            echo "1"
            reset=1
    else
        reset=0
    fi   
   done

}

function FileToPrint () {
    local result
    local file=$(cat "${1}")
    local -n column="$2"
    for col in "${column[@]}"; do
        printf '\t\t||\t\t%s' "$col"  #echo -n -e "\t\t\t\t\t$col:"
    done
    # result+=$(printf '%s||\n' "")    
     local lineNumber=1
     for line in $file; do
        local temp=""
        for((i=1;i<=${#column[@]};i++)); do
            temp+=$(printf '\t\t||\t\t') 
            temp+=$(cut -d";" -f"$i" <<< "$line")
            #temp+=$(echo $line | cut -d";" -f "$i")
        done
        # echo '-------------' 
        printf '\n%s%s' $lineNumber "$temp"
        ((lineNumber+=1))
     done
    #result=$(echo $result | tr ';' '\t\t\t\t\t')
     echo "$result"
}

function FileToPrintColumn () {
    local result
    fileContent=$(cat "${1}")
    local -n column="$2"
    for col in "${column[@]}"; do
        printf ' %s%s' "$3" "$col"  #echo -n -e "\t\t\t\t\t$col:"
    done
    # result+=$(printf '%s||\n' "")    
     local lineNumber=1
     for line in $fileContent; do
        printf '\n%s%s%s' $lineNumber "$3" "$line"
        ((lineNumber+=1))
     done
    #  printf '%s' "$result"
}

file='./test2.txt'
tab=("LOGIN" "PWD" "COMMENTAIRE" "COMMENTAIRE1" "COMMENTAIRE2")
delimiter='|'

#sudo apt install bsdmainutils
FileToPrintColumn "$file" tab $delimiter | column -t -s $delimiter


#install mkpasswd : sudo apt install whois

function FileToUseraddString () {
    fileContent=$(cat "${1}") #initialisation de fileContent avec le contenu de du fichier un Premier argument 
    local result=   #initialisation d'une valeur de retour
    for lineOfFile in ${fileContent}; do
        local login="$(echo $lineOfFile | cut -d"${2}" -f 1)" #recupération du 1er champs de la ligne séparés par un délimiter --> en 2ême argument de la function
        local password="$(echo $lineOfFile | cut -d"${2}" -f 2)"
        local comment="$(echo $lineOfFile | cut -d"${2}" -f 3)"
        result+=$(printf 'sudo useradd -m -s /bin/bash -p $(mkpasswd "%s") -c "%s"  "%s" ;' "$password" "$comment" "$login") #concatenation de commande à exécuter (ajout d'utilisateur)
    done
    echo $result # renvoi de la chaine de caractère (ensemble de commandes)
}


#add color to read 
read -p "$(printf "I \033[0;31mlove\033[0m Stack Overflow\n")" ok

# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37


while getopts ":v:i:r:" option; do
    case "${option}" in
        v)
            v=${OPTARG} #initialise une variable v avec comme valeur OPTARG 
            #OPTARG est l'argument suivant -v dans l'execution du script 
            #exemple read -p "voulez vous continuer ?" --> OPTARG="voulez vous continuer ?"
            if ((v == 15 || v == 75));then
                echo 'egale à 15 ou 75'
            else
                echo 'non'
            fi 
            ;;
        i)
            g=${OPTARG}
            ;;
        i)
            g=${OPTARG}
            ;;
        *)
            echo 'Option non définie'
            ;;
    esac
done
shift $((OPTIND-1))