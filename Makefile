WORKSHOP_DIR=./GITIGN_workshop
ORG_SOURCE_DIR=./orgfiles
PDF_DIR=./exports/pdf_exports
HTML_DIR=./exports/html_exports

all: create_export_dir update_org html_export pdf_export reordering

create_export_dir: 
	@mkdir -p $(PDF_DIR) $(HTML_DIR)

update_org: $(ORG_SOURCE_DIR)/*.org
	@echo "updating org files"
	@cp $^ $(WORKSHOP_DIR)/

html_export: $(WORKSHOP_DIR)/*.org
	@echo "beginning html export"
	@for orgfile in $^; do \
		emacs $$orgfile --batch -f org-html-export-to-html --kill; \
	done

pdf_export: $(WORKSHOP_DIR)/*.org
	@echo "beginning pdf export"
	@for orgfile in $^; do \
		emacs $$orgfile --batch -f org-latex-export-to-pdf --kill; \
	done

reordering:
	@echo "reordering"
	@cp $(WORKSHOP_DIR)/*.html $(HTML_DIR)
	@cp $(WORKSHOP_DIR)/*.pdf $(PDF_DIR)

clean: $(WORKSHOP_DIR)/*~
	@echo "cleaning"
	@rm $^
