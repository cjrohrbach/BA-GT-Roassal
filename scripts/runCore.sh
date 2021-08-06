curl -L https://dl.feenk.com/scripts/linux.sh | bash

cd glamoroustoolkit
cp ../scripts/runCore.st .
#./glamoroustoolkit --headless GlamorousToolkit.image runCore.st
ls
./bin/GlamorousToolkit-cli GlamorousToolkit.image runCore.st

cat /tmp/result.txt
FILE=/tmp/result.txt
if [ ! -f "$FILE" ]; then
    echo "ERROR: $FILE does not exists!"
    exit 1
fi

if grep -q Error "/tmp/result.txt"; then
	echo "Errors: Some tests failed"
	exit 1
else
	echo "Passed: all the tests passed"
	exit 0
fi		
