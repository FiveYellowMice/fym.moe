.PHONY: all

ADOC_HTMLS := index.en.html index.zh.html
CSSS := $(addprefix assets/css/, home.css)

ASCIIDOCTOR = bundle exec asciidoctor -r asciidoctor-html5s -r slim -r asciidoctor-html5s/../../data/templates/helpers.rb -r ./lib/slim-helpers.rb -b html5s -T src/templates
NODE_SASS = node_modules/node-sass/bin/node-sass --output-style compressed
POSTCSS = node_modules/postcss-cli/bin/postcss --no-map --use autoprefixer

all: $(ADOC_HTMLS) $(CSSS)

$(CSSS): assets/css/%.css: src/scss/%.scss $(wildcard src/scss/_*.scss) src/browserlistconfig
	@mkdir -p $(dir $@)
	$(NODE_SASS) $< | $(POSTCSS) > $@

$(ADOC_HTMLS): %.html: src/%.adoc $(wildcard src/templates/*.slim) $(wildcard lib/*.rb) $(wildcard src/_*.adoc) $(CSSS)
	$(ASCIIDOCTOR) -a lang@=$(subst .,,$(suffix $(basename $@))) -o $@ $<
