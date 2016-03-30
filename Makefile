SRCS = millions-react.jsx Renderer.jsx

BROWSERIFY = $(shell npm bin)/browserify
MAKEDEPS = $(shell npm bin)/makedeps
BABEL_CLI = $(shell npm bin)/babel
BFLAGS = -t [ babelify --presets [ es2015 react ] ] --extension=.jsx
BCLIFLAGS =

all: build/dist/millions-react.js
compiled: $(addprefix build/compiled/,$(subst .jsx,.js,$(SRCS)))

clean:
	rm -rf build

build/compiled/%.js: src/%.jsx
	@echo "compile " $<
	@mkdir -p $(dir $@)
	@$(BABEL_CLI) $< -o $@

build/dist/millions-react.js: build/compiled/millions-react.js compiled
	@echo "bundle  " $<
	@mkdir -p $(dir $@) build/deps/$(dir $*)
	@$(BROWSERIFY) $< -o $@ $(BFLAGS) -s MillionsReact
	@$(BROWSERIFY) $< -o $@ $(BFLAGS) -s MillionsReact --list | $(MAKEDEPS) $@ > build/deps/$*.js.d

# include the generated deps so that changes to dependent files trigger rebuilds
-include $(addsuffix .d,$(addprefix build/deps/,$(OUTPUTS)))
