/**
 * This script is called when a GitHub action is run and serves the purpose of avoiding empty
 * lcov files being generated when tests are executed with --coverage
 * Does this by generating an empty main function which just has the imports in the file
 * in the form of ../lib/something instead of the usual package prefix as this leads
 * to empty lcov files for some reason. Every time a new project is created it should manually
 * be added here. Only the redux project is excluded because of the regex being used in this
 * bash script. It results in lots of errors as files which are not suppossed to be picked from
 * the redux project are selected. Hence it is excluded. 
 */

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
fs.writeFile("./apps/app/test/gather_files.sh",content,function(err){
    if(err) throw err;
})

fs.writeFile("./libs/consumer/test/gather_files.sh",content,function(err){
    if(err) throw err;
})

/*fs.writeFile("./libs/example/test/gather_files.sh",content,function(err){
    if(err) throw err;
})*/

fs.writeFile("./libs/tradesman/test/gather_files.sh",content,function(err){
    if(err) throw err;
})

fs.writeFile("./libs/consumer/test/gather_files.sh",content,function(err){
    if(err) throw err;
})

/*//fs.writeFile("./libs/general/test/gather_files.sh",content,function(err){
//    if(err) throw err;
//})*/

fs.writeFile("./libs/amplify/test/gather_files.sh",content,function(err){
    if(err) throw err;
})

fs.writeFile("./libs/authentication/test/gather_files.sh",content,function(err){
    if(err) throw err;
})




var script = exec("bash ./apps/app/test/gather_files.sh")
script = exec("bash ./libs/consumer/test/gather_files.sh")
//script = exec("bash ./libs/example/test/gather_files.sh")
//script = exec("bash ./libs/general/test/gather_files.sh")
script = exec("bash ./libs/tradesman/test/gather_files.sh")
script = exec("bash ./libs/amplify/test/gather_files.sh")
script = exec("bash ./libs/authentication/test/gather_files.sh")
