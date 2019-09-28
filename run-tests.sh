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
echo 'Test Execution Result'>> README.txt
 sed -n '859p' test-execution.txt >> README.txt
 sed -n '874p' test-execution.txt >> README.txt
