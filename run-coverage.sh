cd ./moshi/moshi
if [ ! $(grep -q "jacoco" "pom.xml") ]; then
ed pom.xml << END
61i
	<plugin>
		<groupId>org.jacoco</groupId>
		<artifactId>jacoco-maven-plugin</artifactId>
		<version>0.8.2</version>
		<executions>
			<execution>
				<goals>
					<goal>prepare-agent</goal>
				</goals>
			</execution>
			<!-- attached to Maven test phase -->
			<execution>
				<id>report</id>
				<phase>test</phase>
				<goals>
					<goal>report</goal>
				</goals>
			</execution>
		</executions>
	</plugin>
.
w
q
END
fi
time mvn test >>test-coverage.txt
echo 'Test Coverage Result' >> ../../README.txt
 sed -n '85p' test-coverage.txt >> ../../README.txt
 sed -n '94p' test-coverage.txt >> ../../README.txt
cd ./target/site/jacoco/
cp index.html ../../../../../test-coverage.html
cp -rf ./jacoco-resources ../../../../../jacoco-resources
cd ../../../../../
open test-coverage.html
