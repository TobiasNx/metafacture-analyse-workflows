default infile = FLUX_DIR + "alma.xml";


"https://duepublico2.uni-due.de/oer/oai"
| open-oaipmh(metadataPrefix="mods")
| decode-xml
| handle-generic-xml(emitNamespace="true")
| flatten
//| morph(FLUX_DIR + "uniqueFields.xml") //This MORPH unqiues the fields in a record.
|	stream-to-triples
| count-triples(countBy="PREDICATE")
| sort-triples(By="SUBJECT")
| template("${o}\t${s}")
| write("stdout")
;

