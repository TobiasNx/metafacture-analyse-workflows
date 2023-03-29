// fill in here the value that you are interested in:
fieldOfInterest = "metadata.mods:mods.mods:classification.valueURI";


"https://duepublico2.uni-due.de/oer/oai"
| open-oaipmh(metadataPrefix="mods")
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
