default infile = "testFiles/test.json";

// fill in here the value that you are interested in:
fieldOfInterest = "license.id";


infile
| open-file
| as-lines
| decode-json(arrayname="*")
| flatten
| morph(FLUX_DIR + "fieldOfInterest.xml", *)
|	stream-to-triples
| count-triples(countBy="OBJECT")
| sort-triples(By="SUBJECT")
| template("${o}\t${s}")
| write("stdout")
;
