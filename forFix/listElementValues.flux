default infile = "testFiles/test.xml";

// fill in here the element that you are interested in:
fieldOfInterest = "metadata.mods:mods.mods:subject.mods:topic.*.value";

// set the incoming data stream as you need
infile
| open-file
| decode-xml
| handle-generic-xml(emitNamespace="true")

// This part can be reused to analyse values of an element.
| fix(FLUX_DIR + "fieldOfInterest.fix", *)
|	stream-to-triples
| count-triples(countBy="OBJECT")
| sort-triples(By="SUBJECT")
| template("${o}\t${s}")
| write("stdout")
;
