// Flux needs to run with a distribution created by the master. It does not work with the stand-alone version of metafacture.

// Quotationmarks in apiCall must be substituted with %22
default apiCall = "https://open.vhb.org/oersi.json";

apiCall
| open-http(accept="application/json")
| as-lines
// Provide record path of apiCall in "recordPath"
| decode-json(recordPath="$.data", arrayname="*")
| flatten
//This MORPH unqiues the fields in a record. Commented out every instance in a record will be counted.
| morph(FLUX_DIR + "uniqueFields.xml")
|	stream-to-triples
| count-triples(countBy="PREDICATE")
| sort-triples(By="object",numeric="TRUE")
| template("${o}\t${s}")
| write("stdout")
;
