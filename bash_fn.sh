function mix_env(){
 local env="$1"
 if [ $env = "prod" ]; then
  export MIX_ENV=prod
  export MIX_TARGET=rpi3
 fi
 if [ $env = "dev" ]; then
  export MIX_ENV=dev
  export MIX_TARGET=host
 fi
 echo $MIX_ENV
 echo $MIX_TARGET
}

alias mixenv="mix_env"

function dboom(){
 docker rm $(docker ps -a -q)
 docker rmi $(docker images -q)
}

alias dboom="dboom"

function kubessh(){
 local pos="head"
 local which=$3
 if [ $which = 2 ]; then
  local pos="tail"
 fi
 local first_env=$(kubectl get pods -n alpha -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' | grep $1 | $pos -n 1)
 echo $first_env
 kubectl exec -i -t $first_env bash -n $2
}

alias kubessh="kubessh"

function gitup(){
 local branch=$(git branch | grep \* | cut -d ' ' -f2)
 local message=$1
 echo $message
 if [ $branch != "master" ]; then
   git add .
   git commit -m "$message"
   git push origin $branch
 fi
 if [ $branch = "master" ]; then
  echo "Not commit in master"
 fi
}

alias gitup="gitup"

