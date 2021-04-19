curl -L https://dl.feenk.com/scripts/linux.sh | bash

cd glamoroustoolkit
cp ../scripts/runG.st .
./glamoroustoolkit --headless GlamorousToolkit.image runG.st

cat /tmp/result.txt
if grep -q ERROR "/tmp/result.txt"; then
	echo "Errors: Some tests failed"
	exit 1
else
	echo "Passed: all the tests passed"
	exit 0
fi		
