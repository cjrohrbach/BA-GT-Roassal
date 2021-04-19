curl -L https://dl.feenk.com/scripts/linux.sh | bash

cd glamoroustoolkit
cp ../scripts/runG.st .
./glamoroustoolkit --headless GlamorousToolkit.image runG.st

cat /tmp/result.txt
if grep -q ERROR "/tmp/result.txt"; then
	echo "SOME ERROR WERE FOUND"
	exit 1
else
	echo "ALL TEST PASSED"
	exit 0
fi		
