#!/bin/bash

trap '[ "$?" -eq 0 ] || read -p "Looks like something went wrong in step ´$STEP´... Press any key to continue..."' EXIT

##############################################################################
# Docker start scrip for work offline or behind corporate proxy. Win Only
# Save it to `c:\Program Files\Docker Toolbox\`
##############################################################################

export PATH="/c/Program Files/Docker Toolbox:$PATH"
VM=${DOCKER_MACHINE_NAME-default}
DOCKER_MACHINE=./docker-machine.exe

STEP="Looking for vboxmanage.exe"
if [ ! -z "$VBOX_MSI_INSTALL_PATH" ]; then
  VBOXMANAGE="${VBOX_MSI_INSTALL_PATH}VBoxManage.exe"
else
  VBOXMANAGE="${VBOX_INSTALL_PATH}VBoxManage.exe"
fi

BLUE='\033[1;34m'
GREEN='\033[0;32m'
NC='\033[0m'

#clear all_proxy if not socks address
if  [[ $ALL_PROXY != socks* ]]; then
  unset ALL_PROXY
fi
if  [[ $all_proxy != socks* ]]; then
  unset all_proxy
fi

if [ ! -f "${DOCKER_MACHINE}" ]; then
  echo "Docker Machine is not installed. Please re-run the Toolbox Installer and try again."
  exit 1
fi

if [ ! -f "${VBOXMANAGE}" ]; then
  echo "VirtualBox is not installed. Please re-run the Toolbox Installer and try again."
  exit 1
fi

"${VBOXMANAGE}" list vms | grep \""${VM}"\" &> /dev/null
VM_EXISTS_CODE=$?

set -e

STEP="Setting cache for offline work"
CACHE_ISO=boot2docker.iso
CACHE_ISO_SOURCE="/c/Program Files/Docker Toolbox/${CACHE_ISO}"
CACHE_ISO_TARGET=~/.docker/machine/cache/$CACHE_ISO
CERTS_DIR_SOURCE=~/.docker/machine/certs/
CERTS_DIR_TARGET=~/.docker/machine/machines/default/

online=1
curl -sf -m 0,2 http://github.com > /dev/null || online=0

if [ $online -eq 0 ]; then
  echo "Offline work"
  if [ $OS == "Windows_NT" ]; then
      if [ ! -f "$CACHE_ISO_TARGET" ]; then
        echo "not found target cache for online work"
        if [ -f "$CACHE_ISO_SOURCE" ]; then
          echo "found source for cache"
          cp "$CACHE_ISO_SOURCE" "$CACHE_ISO_TARGET"
        else
          echo "bad installation: there no CACHE_ISO_SOURCE"
          exit 1
        fi
      fi
  fi
fi

STEP="Checking if machine $VM exists"
if [ $VM_EXISTS_CODE -eq 1 ]; then
  "${DOCKER_MACHINE}" rm -f "${VM}" &> /dev/null || :
  rm -rf ~/.docker/machine/machines/"${VM}"
  #set proxy variables if they exists
  if [ "${HTTP_PROXY}" ]; then
    PROXY_ENV="$PROXY_ENV --engine-env HTTP_PROXY=$HTTP_PROXY"
  fi
  if [ "${HTTPS_PROXY}" ]; then
    PROXY_ENV="$PROXY_ENV --engine-env HTTPS_PROXY=$HTTPS_PROXY"
  fi
  if [ "${NO_PROXY}" ]; then
    PROXY_ENV="$PROXY_ENV --engine-env NO_PROXY=$NO_PROXY"
  fi
  "${DOCKER_MACHINE}" create -d virtualbox $PROXY_ENV "${VM}"
fi

STEP="Setting certs for offline VM config"
if [ $online -eq 1 ]; then
    echo "Offline work"
    if [ $OS == "Windows_NT" ]; then
        if [ ! -f "${CERTS_DIR_TARGET}ca.pem" ]; then
          echo "not found cert for VM 'default'"
          if [ -f "${CERTS_DIR_SOURCE}ca.pem" ]; then
            echo "found default certs"
            cp -r "${CERTS_DIR_SOURCE}." "${CERTS_DIR_TARGET}"
          else
            echo "bad installation: there no default certs"
            exit 1
          fi
        fi
    fi
fi

STEP="Checking status on $VM"
VM_STATUS="$(${DOCKER_MACHINE} status ${VM} 2>&1)"
if [ "${VM_STATUS}" != "Running" ]; then
  "${DOCKER_MACHINE}" start "${VM}"
  yes | "${DOCKER_MACHINE}" regenerate-certs "${VM}"
fi

STEP="Setting env"
eval "$(${DOCKER_MACHINE} env --shell=bash --no-proxy ${VM})"

STEP="Finalize"
clear
cat << EOF


                        ##         .
                  ## ## ##        ==
               ## ## ## ## ##    ===
           /"""""""""""""""""\___/ ===
      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~
           \______ o           __/
             \    \         __/
              \____\_______/

EOF
echo -e "${BLUE}docker${NC} is configured to use the ${GREEN}${VM}${NC} machine with IP ${GREEN}$(${DOCKER_MACHINE} ip ${VM})${NC}"
echo "For help getting started, check out the docs at https://docs.docker.com"
echo
cd

docker () {
  MSYS_NO_PATHCONV=1 docker.exe "$@"
}
export -f docker

if [ $# -eq 0 ]; then
  echo "Start interactive shell"
  exec "$BASH" --login -i
else
  echo "Start shell with command"
  exec "$BASH" -c "$*"
fi
