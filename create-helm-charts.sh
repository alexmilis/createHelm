#!/bin/bash

for i in "$@"; do
  case $i in
    -a=*|--version_service1=*)
      SERVICE1="${i#*=}"
      shift # past argument=value
      ;;
    -b=*|--version_service2=*)
      SERVICE2="${i#*=}"
      shift # past argument=value
      ;;
    -*|--*)
      echo "Unknown option $i"
      exit 1
      ;;
    *)
      ;;
  esac
done

echo "Version service 1 = ${SERVICE1}"
echo "Version service 2 = ${SERVICE2}"

if [[ -z $SERVICE1 || -z $SERVICE2 ]]; then
    echo "Both versions of services have to be specified!"
    exit 1
fi

if [ ! -x "$(command -v helm)" ]; then
    echo "Please helm to be able to run this script"
    exit 1
fi

sed -i "s/^\( *tag: *\)[^ ]*\(.*\)*$/\1$SERVICE1\2/" service1-helm/values.yaml
sed -i "s/^\( *tag: *\)[^ ]*\(.*\)*$/\1$SERVICE2\2/" service2-helm/values.yaml

helm template service1-helm
helm template service2-helm

helm package service1-helm
helm package service2-helm