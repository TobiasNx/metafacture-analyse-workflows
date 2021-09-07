default infile = "/home/tobias/git/lobid-resources/src/test/resources/jsonld";


infile
| read-dir(filenamepattern=".*\\.json")
| open-file
| as-records
| decode-json(arrayname="*")
| flatten
//| morph(FLUX_DIR + "uniqueFields.xml") //This MORPH unqiues the fields in a record.
|	stream-to-triples
| count-triples(countBy="PREDICATE")
| sort-triples(By="SUBJECT")
| template("${o}\t${s}")
| write("stdout")
;
