OnixTable.xml: ONIX_for_Books_Release3-0_docs+codes_Issue_40/ONIX_for_Books_Format_Specification_3.0.4.txt ExtractTagTable.pl
	perl ExtractTagTable.pl <$< >$@

ONIX_for_Books_Release3-0_docs+codes_Issue_40/ONIX_for_Books_Format_Specification_3.0.4.txt: ONIX_for_Books_Release3-0_docs+codes_Issue_40/ONIX_for_Books_Format_Specification_3.0.4.pdf
	pdftotext $^

.PHONY: download
## Downloads all downloadable ONIX specifications.
download: ONIX_for_Books_Release3-0_docs+codes_Issue_40.zip ONIX_Books_3.0_sample_2.zip ONIX_BookProduct_XSD_schema+codes_Issue_40.zip ONIX_BookProduct_RNG_schema+codes_Issue_40.zip ONIX_BookProduct_DTDs+codes_Issue_40.zip

.PHONY: unzip
## Unzips all downloadable ONIX specifications.
unzip: ONIX_for_Books_Release3-0_docs+codes_Issue_40/ Samples/ ONIX_BookProduct_XSD_schema+codes_Issue_40/ ONIX_BookProduct_RNG_schema+codes_Issue_40/ ONIX_BookProduct_DTDs+codes_Issue_40/

ONIX_for_Books_Release3-0_docs+codes_Issue_40.zip:
	wget http://www.editeur.org/files/ONIX%203/ONIX_for_Books_Release3-0_docs+codes_Issue_40.zip

ONIX_Books_3.0_sample_2.zip:
	wget http://www.editeur.org/files/ONIX%203/ONIX_Books_3.0_sample_2.zip

ONIX_BookProduct_XSD_schema+codes_Issue_40.zip:
	wget http://www.editeur.org/files/ONIX%203/ONIX_BookProduct_XSD_schema+codes_Issue_40.zip

ONIX_BookProduct_RNG_schema+codes_Issue_40.zip:
	wget http://www.editeur.org/files/ONIX%203/ONIX_BookProduct_RNG_schema+codes_Issue_40.zip

ONIX_BookProduct_DTDs+codes_Issue_40.zip:
	wget http://www.editeur.org/files/ONIX%203/ONIX_BookProduct_DTDs+codes_Issue_40.zip

ONIX_for_Books_Release3-0_docs+codes_Issue_40/: ONIX_for_Books_Release3-0_docs+codes_Issue_40.zip
	unzip -q $<
	touch $@

Samples/: ONIX_Books_3.0_sample_2.zip
	unzip -q $<
	touch $@

ONIX_BookProduct_XSD_schema+codes_Issue_40/: ONIX_BookProduct_XSD_schema+codes_Issue_40.zip
	unzip -q $<
	touch $@

ONIX_BookProduct_RNG_schema+codes_Issue_40/: ONIX_BookProduct_RNG_schema+codes_Issue_40.zip
	unzip -q $<
	touch $@

ONIX_BookProduct_DTDs+codes_Issue_40/: ONIX_BookProduct_DTDs+codes_Issue_40.zip
	unzip -q $<
	touch $@

.PHONY: validate
## Validates the downloaded sample files.
# Note: The downloaded shorttags sample file lacks a namespace declaration.
# Therefore, it only validates against DTD, not against XSD or RNG.
validate: Samples/ ONIX_BookProduct_XSD_schema+codes_Issue_40/ ONIX_BookProduct_RNG_schema+codes_Issue_40/ ONIX_BookProduct_DTDs+codes_Issue_40/
	xmllint --noout --relaxng ONIX_BookProduct_RNG_schema+codes_Issue_40/ONIX_BookProduct_3.0_reference.rng Samples/Onix3sample_refnames.xml
	xmllint --noout --schema ONIX_BookProduct_XSD_schema+codes_Issue_40/ONIX_BookProduct_3.0_reference.xsd Samples/Onix3sample_refnames.xml
	xmllint --noout --dtdvalid ONIX_BookProduct_DTDs+codes_Issue_40/ONIX_BookProduct_3.0_reference.dtd Samples/Onix3sample_refnames.xml
	xmllint --noout --dtdvalid ONIX_BookProduct_DTDs+codes_Issue_40/ONIX_BookProduct_3.0_short.dtd Samples/Onix3sample_shorttags.xml
	xmllint --noout --schema ONIX_BookProduct_XSD_schema+codes_Issue_40/ONIX_BookProduct_3.0_short.xsd Samples/Onix3sample_shorttags.xml
	xmllint --noout --relaxng ONIX_BookProduct_RNG_schema+codes_Issue_40/ONIX_BookProduct_3.0_short.rng Samples/Onix3sample_shorttags.xml


.PHONY: distclean
distclean::
	$(RM) -r \
	    ONIX_BookProduct_DTDs+codes_Issue_40/\
	    ONIX_BookProduct_DTDs+codes_Issue_40.zip\
	    ONIX_BookProduct_RNG_schema+codes_Issue_40/\
	    ONIX_BookProduct_RNG_schema+codes_Issue_40.zip\
	    ONIX_BookProduct_XSD_schema+codes_Issue_40/\
	    ONIX_BookProduct_XSD_schema+codes_Issue_40.zip\
	    ONIX_Books_3.0_sample_2.zip\
	    ONIX_for_Books_Release3-0_docs+codes_Issue_40/\
	    ONIX_for_Books_Release3-0_docs+codes_Issue_40.zip\
	    Samples/\

