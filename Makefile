.PHONY: all

BROWSERSLIST_CONFIG = src/browserlistconfig

NODE_SASS = node_modules/node-sass/bin/node-sass --output-style compressed
POSTCSS = node_modules/postcss-cli/bin/postcss --no-map --use autoprefixer

all: assets/css/home.css assets/css/home-noscript.css

assets/css/home.css: src/scss/home.scss $(wildcard src/scss/_*.scss) $(BROWSERSLIST_CONFIG)
	mkdir -p $(dir $@)
	$(NODE_SASS) src/scss/home.scss | $(POSTCSS) > $@

assets/css/home-noscript.css: src/scss/home-noscript.scss
	mkdir -p $(dir $@)
	$(NODE_SASS) src/scss/home-noscript.scss | $(POSTCSS) > $@
