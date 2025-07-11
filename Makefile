.PHONY: all
.DELETE_ON_ERROR:

ADOC_HTMLS := index.en.html index.zh.html
CSSS := $(addprefix assets/css/, home.css home-noscript.css)

ASCIIDOCTOR = bundle exec asciidoctor -r asciidoctor-html5s -r slim -r asciidoctor-html5s/../../data/templates/helpers.rb -r ./lib/slim-helpers.rb -b html5s -T src/templates
SASS = node_modules/sass/sass.js
POSTCSS = node_modules/postcss-cli/index.js --no-map --use autoprefixer --use cssnano

all: $(ADOC_HTMLS) $(CSSS)

$(CSSS): assets/css/%.css: src/scss/%.scss $(wildcard src/scss/_*.scss) src/browserlistconfig
	@mkdir -p $(dir $@)
	$(SASS) $< | $(POSTCSS) > $@

$(ADOC_HTMLS): %.html: src/%.adoc $(wildcard src/templates/*.slim) $(wildcard lib/*.rb) $(wildcard src/_*.adoc) $(CSSS)
	$(ASCIIDOCTOR) -a lang@=$(subst .,,$(suffix $(basename $@))) -o $@ $<
