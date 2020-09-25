function _awsListAll() {
    credentialFileLocation=${AWS_SHARED_CREDENTIALS_FILE};
    if [ -z $credentialFileLocation ]; then
        credentialFileLocation=~/.aws/credentials
    fi

    while read line; do
        if [[ $line == "["* ]]; then echo $line | sed -e 's/[][\]//g' ; fi;
    done < $credentialFileLocation;
};

function _awsSwitchProfile() {
    if [ -z $1 ]; then
        if [ $commands[fzf] ]; then
            profile=$(_awsListAll | fzf --exit-0) && _awsSwitchProfile "$profile" || echo "Failed to switch profile"
            return
        else
            echo "Usage: awsp profilename"; return
        fi
    fi
   
    exists="$(aws configure get aws_access_key_id --profile $1)"
    if [ -n "$exists" ]; then
        export AWS_PROFILE=$1;
        echo "Switched to AWS Profile: $1";
        # aws configure list
    fi
};

function _awsDisableProfile() {
    unset AWS_PROFILE
};
alias awsall="_awsListAll"
alias awsp="_awsSwitchProfile"
alias awswho="aws configure list"
alias awsoff="_awsDisableProfile"
