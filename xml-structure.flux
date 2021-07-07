default infile = FLUX_DIR + "test.xml";


infile
| open-file
| decode-xml
| handle-generic-xml
| flatten
|	stream-to-triples
| count-triples(countBy="PREDICATE")
| sort-triples(By="SUBJECT")
| template("${o}\t${s}")
| write("stdout")
;
