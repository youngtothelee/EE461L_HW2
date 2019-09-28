#Detect Operating System
if [[ "$OSTYPE" == "linux-gnu" ]]; then
     if hash maven 2>/dev/null; then
         echo 'Maven already installed. Skipping installation'
     else
         # Install Maven
         echo 'Maven does not exist. Installing Maven...'
         sudo apt install maven
     fi
 elif [[ "$OSTYPE" == "darwin"* ]]; then
     which -s brew
     if [[ $? != 0 ]]; then
         # Install Homebrew
         echo 'Homebrew does not exist. Installing Homebrew...'
         /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
     else
         echo 'Updating Homebrew...'
         brew update
     fi
     which -s mvn
     if [[ $? != 0 ]]; then
         echo 'Maven does not exist. Installing Maven...'
         # Install Maven
         brew install maven
     else
         echo 'Maven already installed. Skipping installation...'
     fi
 else
     echo 'This OS is not UNIX'
 fi

if [ ! -d ./moshi ]; then
    git clone https://github.com/youngtothelee/moshi
fi
cd moshi
git remote show origin | grep "Fetch URL:" >test-execution.txt
echo SHA: $(git rev-parse HEAD) >>test-execution.txt
time mvn test >>test-execution.txt
mv test-execution.txt ../test-execution.txt
cd ..
if [ ! -f ./README.txt ]; then
    touch README.txt
fi

__header="
Contributors: Young Lee, Kylar Osborne
Github (forked): https://github.com/youngtothelee/moshi.git
"

echo "$__header" >> README.txt
echo '==========================================================='>> README.txt
echo 'Test Execution Result:'>>README.txt
echo '==========================================================='>> README.txt
 awk '/Tests run:/' test-execution.txt >>README.txt
 awk '/Total time/' test-execution.txt >>README.txt
 echo -e "\n\n" >>README.txt
