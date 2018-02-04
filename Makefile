OnixTable.xml: Downloads/ONIX_for_Books_Release3-0_docs+codes_Issue_40/ONIX_for_Books_Format_Specification_3.0.4.txt ExtractTagTable.pl
	perl ExtractTagTable.pl <$< >$@

Downloads/ONIX_for_Books_Release3-0_docs+codes_Issue_40/ONIX_for_Books_Format_Specification_3.0.4.txt: Downloads/ONIX_for_Books_Release3-0_docs+codes_Issue_40/ONIX_for_Books_Format_Specification_3.0.4.pdf
	pdftotext $^

.PHONY: download
## Downloads all downloadable ONIX specifications.
download: \
		Downloads/ONIX_BookProduct_DTDs+codes_Issue_40.zip \
		Downloads/ONIX_BookProduct_RNG_schema+codes_Issue_40.zip \
		Downloads/ONIX_BookProduct_XSD_schema+codes_Issue_40.zip \
		Downloads/ONIX_Books_3.0_sample_2.zip \
		Downloads/ONIX_for_Books_Release3-0_docs+codes_Issue_40.zip \


.PHONY: unzip
## Unzips all downloadable ONIX specifications.
unzip: \
		Downloads/ONIX_BookProduct_DTDs+codes_Issue_40/ \
		Downloads/ONIX_BookProduct_RNG_schema+codes_Issue_40/ \
		Downloads/ONIX_BookProduct_XSD_schema+codes_Issue_40/ \
		Downloads/ONIX_for_Books_Release3-0_docs+codes_Issue_40/ \
		Downloads/Samples/ \

Downloads/:
	mkdir -p $@

Downloads/ONIX_for_Books_Release3-0_docs+codes_Issue_40.zip: | Downloads/
	wget -q -O $@ http://www.editeur.org/files/ONIX%203/ONIX_for_Books_Release3-0_docs+codes_Issue_40.zip

Downloads/ONIX_Books_3.0_sample_2.zip: | Downloads/
	wget -q -O $@ http://www.editeur.org/files/ONIX%203/ONIX_Books_3.0_sample_2.zip

Downloads/ONIX_BookProduct_XSD_schema+codes_Issue_40.zip: | Downloads/
	wget -q -O $@ http://www.editeur.org/files/ONIX%203/ONIX_BookProduct_XSD_schema+codes_Issue_40.zip

Downloads/ONIX_BookProduct_RNG_schema+codes_Issue_40.zip: | Downloads/
	wget -q -O $@ http://www.editeur.org/files/ONIX%203/ONIX_BookProduct_RNG_schema+codes_Issue_40.zip

Downloads/ONIX_BookProduct_DTDs+codes_Issue_40.zip: | Downloads/
	wget -q -O $@ http://www.editeur.org/files/ONIX%203/ONIX_BookProduct_DTDs+codes_Issue_40.zip

Downloads/ONIX_for_Books_Release3-0_docs+codes_Issue_40/: Downloads/ONIX_for_Books_Release3-0_docs+codes_Issue_40.zip
	unzip -q $< -d Downloads/
	touch $@

Downloads/Samples/: Downloads/ONIX_Books_3.0_sample_2.zip
	unzip -q $< -d Downloads/
	touch $@

Downloads/ONIX_BookProduct_XSD_schema+codes_Issue_40/: Downloads/ONIX_BookProduct_XSD_schema+codes_Issue_40.zip
	unzip -q $< -d Downloads/
	touch $@

Downloads/ONIX_BookProduct_RNG_schema+codes_Issue_40/: Downloads/ONIX_BookProduct_RNG_schema+codes_Issue_40.zip
	unzip -q $< -d Downloads/
	touch $@

Downloads/ONIX_BookProduct_DTDs+codes_Issue_40/: Downloads/ONIX_BookProduct_DTDs+codes_Issue_40.zip
	unzip -q $< -d Downloads/
	touch $@

.PHONY: validate
## Validates the downloaded sample files.
# Note: The downloaded shorttags sample file lacks a namespace declaration.
# Therefore, it only validates against DTD, not against XSD or RNG.
validate: Downloads/Samples/ Downloads/ONIX_BookProduct_XSD_schema+codes_Issue_40/ Downloads/ONIX_BookProduct_RNG_schema+codes_Issue_40/ Downloads/ONIX_BookProduct_DTDs+codes_Issue_40/
	xmllint --noout --relaxng  Downloads/ONIX_BookProduct_RNG_schema+codes_Issue_40/ONIX_BookProduct_3.0_reference.rng Downloads/Samples/Onix3sample_refnames.xml
	xmllint --noout --schema   Downloads/ONIX_BookProduct_XSD_schema+codes_Issue_40/ONIX_BookProduct_3.0_reference.xsd Downloads/Samples/Onix3sample_refnames.xml
	xmllint --noout --dtdvalid Downloads/ONIX_BookProduct_DTDs+codes_Issue_40/ONIX_BookProduct_3.0_reference.dtd       Downloads/Samples/Onix3sample_refnames.xml
	xmllint --noout --dtdvalid Downloads/ONIX_BookProduct_DTDs+codes_Issue_40/ONIX_BookProduct_3.0_short.dtd           Downloads/Samples/Onix3sample_shorttags.xml
	xmllint --noout --schema   Downloads/ONIX_BookProduct_XSD_schema+codes_Issue_40/ONIX_BookProduct_3.0_short.xsd     Downloads/Samples/Onix3sample_shorttags.xml
	xmllint --noout --relaxng  Downloads/ONIX_BookProduct_RNG_schema+codes_Issue_40/ONIX_BookProduct_3.0_short.rng     Downloads/Samples/Onix3sample_shorttags.xml


.PHONY: distclean
distclean::
	$(RM) -r Downloads/
