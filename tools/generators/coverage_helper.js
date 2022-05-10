process.chdir(__dirname);
const {exec}  =  require('child_process')
const fs = require('fs');

var val = "${BASH_SOURCE[0]}"
var content = `
parent_path=$( cd "$(dirname "${val})")" ; pwd -P )
cd "$parent_path"

file=coverage_helper_test.dart

echo "// Helper file to make coverage work for all dart files\\n" >$file 
echo "// ignore_for_file: unused_import" >> $file
echo "import 'package:flutter_test/flutter_test.dart';">$file

find ../lib '!' -path '*generated*/*' '!' -name '*.g.dart' '!' -name '*.part.dart' '!' -name '*.freezed.dart' -name '*.dart' | cut -c4- |
awk -v package=$1 '{printf "import '\\''../%s%s'\\'';\\n", package,
$1}' >> $file
echo "void main( ){}" >> $file 

`
fs.writeFile("./home/runner/work/ReverseHand/ReverseHand/apps/app/test/gather_files.sh",content,function(err){
    if(err) throw err;
})

fs.writeFile("./home/runner/work/ReverseHand/ReverseHand/libs/consumer/test/gather_files.sh",content,function(err){
    if(err) throw err;
})

fs.writeFile("./home/runner/work/ReverseHand/ReverseHand/libs/example/test/gather_files.sh",content,function(err){
    if(err) throw err;
})

fs.writeFile("./home/runner/work/ReverseHand/ReverseHand/libs/tradesman/test/gather_files.sh",content,function(err){
    if(err) throw err;
})

fs.writeFile("./home/runner/work/ReverseHand/ReverseHand/libs/consumer/test/gather_files.sh",content,function(err){
    if(err) throw err;
})

fs.writeFile("./home/runner/work/ReverseHand/ReverseHand/libs/general/test/gather_files.sh",content,function(err){
    if(err) throw err;
})


//Note: Due to regex being used, redux_comp cannot be catered for

var script = exec("bash ./home/runner/work/ReverseHand/ReverseHand/apps/app/test/gather_files.sh")
script = exec("bash ./home/runner/work/ReverseHand/ReverseHand/libs/consumer/test/gather_files.sh")
script = exec("bash ./home/runner/work/ReverseHand/ReverseHand/libs/example/test/gather_files.sh")
script = exec("bash ./home/runner/work/ReverseHand/ReverseHand/libs/general/test/gather_files.sh")
script = exec("bash ./home/runner/work/ReverseHand/ReverseHand/libs/tradesman/test/gather_files.sh")
