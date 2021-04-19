curl -L https://dl.feenk.com/scripts/linux.sh | bash

cd glamoroustoolkit
cp ../runG.st .
./glamoroustoolkit --headless GlamorousToolkit.image runG.st

cat /tmp/result.txt
set RES = `grep ERROR /tmp/result.txt`

if [ -n "$RES" ]; then
		exit 1
else
		echo "ALL TEST PASSED"
		exit 0
fi		
