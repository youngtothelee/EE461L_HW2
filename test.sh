if [[ "$OSTYPE" == "linux-gnu" ]]; then
    if hash maven 2>/dev/null; then
        echo 'maven already exists. Skipping installation'
    else
        echo 'maven does not exist. Installing maven...'
        sudo apt install maven
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    which -s brew
    if [[ $? != 0 ]]; then
        # Install Homebrew
        echo 'Homebrew does not exist. Installing Homebrew...'
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        echo 'Updating Homebrew'
        brew update
    fi
    which -s mvn
    if [[ $? != 0 ]]; then
        # Install Maven
        brew install maven
    else
        echo 'Maven already installed'
    fi
else
    echo 'This OS is not UNIX'
fi
