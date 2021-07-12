default infile = FLUX_DIR + "test.json";


infile
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
