default infile = "testFiles/alma-hbz.json";

// set the incoming data as you wish
infile
| open-file
| as-records
| decode-json

// this can be reused for all incoming data streams
| fix("nothing()",repeatedFieldsToEntities="true")
| flatten
| encode-json
| match(pattern="\\.\\d+\\.", replacement=".\\*.")
| match(pattern="\\.\\d+\"", replacement=".\\*\"")
| decode-json
| stream-to-triples
| count-triples(countBy="predicate")
| template("${s}\t ${o}")
| print;
;