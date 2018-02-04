OnixTable.xml: ONIX_for_Books_Release3-0_docs+codes_Issue_40/ONIX_for_Books_Format_Specification_3.0.4.txt ExtractTagTable.pl
	perl ExtractTagTable.pl <$< >$@

ONIX_for_Books_Release3-0_docs+codes_Issue_40/ONIX_for_Books_Format_Specification_3.0.4.txt: ONIX_for_Books_Release3-0_docs+codes_Issue_40/ONIX_for_Books_Format_Specification_3.0.4.pdf
	pdftotext $^

ONIX_for_Books_Release3-0_docs+codes_Issue_40.zip:
	wget http://www.editeur.org/files/ONIX%203/ONIX_for_Books_Release3-0_docs+codes_Issue_40.zip

ONIX_Books_3.0_sample_2.zip:
	wget http://www.editeur.org/files/ONIX%203/ONIX_Books_3.0_sample_2.zip

ONIX_for_Books_Release3-0_docs+codes_Issue_40/: ONIX_for_Books_Release3-0_docs+codes_Issue_40.zip
	unzip -q $<
	touch $@

Samples/: ONIX_Books_3.0_sample_2.zip
	unzip -q $<
	touch $@

.PHONY: distclean
distclean::
	$(RM) ONIX_for_Books_Release3-0_docs+codes_Issue_40.zip ONIX_for_Books_Release3-0_docs+codes_Issue_40
