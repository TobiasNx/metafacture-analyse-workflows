default infile = FLUX_DIR + "test.xml";

// fill in here the value that you are interested in:
fieldOfInterest = "metadata.mods:mods.mods:classification.valueURI";


infile
| open-file
| decode-xml
| handle-generic-xml(emitNamespace="true")
| flatten
| morph(FLUX_DIR + "fieldOfInterest.xml", *)
|	stream-to-triples
| count-triples(countBy="OBJECT")
| sort-triples(By="SUBJECT")
| template("${o}\t${s}")
| write("stdout")
;
