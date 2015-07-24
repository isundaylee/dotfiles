alias vssh-config='vagrant ssh-config'
alias viu='vagrant init hashicorp/precise32'
alias vup='vagrant up'

VAGRANT_SSH_CONFIG_FILE='.vagrant_ssh_config'

function vssh() {
    if [[ $1 == '-f' ]]; then
        rm $VAGRANT_SSH_CONFIG_FILE > /dev/null
    fi

    if [[ ! -f $VAGRANT_SSH_CONFIG_FILE ]]; then
        echo "Generating $VAGRANT_SSH_CONFIG_FILE"
        vagrant ssh-config > $VAGRANT_SSH_CONFIG_FILE
    fi

    ssh -F $VAGRANT_SSH_CONFIG_FILE default
}