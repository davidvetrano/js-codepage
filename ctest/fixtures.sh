#!/bin/bash
OFILE=${1:-ctest/fixtures.js}

echo "README={}" > $OFILE 
make_file(){
	echo "README['"$1"'] = " >> $OFILE
	echo "$2" >> $OFILE
	echo ";" >> $OFILE 
}

echo "main file: $OFILE"
make_file "str" "$(node -pe "JSON.stringify(require('fs').readFileSync('misc/codepage.md.utf8','utf8'))")"
for enc in ascii utf{7,8,{16,32}{le,be}}; do
	echo "$enc" >&2
	make_file "$enc" "$(node -pe "JSON.stringify(require('fs').readFileSync('misc/codepage.md.$enc'))")"
done

OFILE=${2:-ctest/iefix.js}
echo "README={}" > $OFILE 

echo "mini file: $OFILE"
make_file "str" "$(node -pe "JSON.stringify(require('fs').readFileSync('misc/codepage_mini.md.utf8','utf8'))")"
for enc in ascii utf{7,8,{16,32}{le,be}}; do
	echo "$enc" >&2
	make_file "$enc" "$(node -pe "JSON.stringify(require('fs').readFileSync('misc/codepage_mini.md.$enc'))")"
done
