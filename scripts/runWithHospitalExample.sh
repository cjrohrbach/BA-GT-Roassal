curl -L https://dl.feenk.com/scripts/linux.sh | bash

cd glamoroustoolkit
cp ../scripts/runWithHospitalExample.st .
./glamoroustoolkit --headless GlamorousToolkit.image runWithHospitalExample.st

cat /tmp/result.txt
if grep -q Error "/tmp/result.txt"; then
	echo "Errors: Some tests failed"
	exit 1
else
	echo "Passed: all the tests passed"
	exit 0
fi		
