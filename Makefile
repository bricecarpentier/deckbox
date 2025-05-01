all: box lid
	
CMD=openscad -m make --backend Manifold deckbox.scad

extract_part = $(basename $(subst -,.,$(basename $(notdir $(1)))))
extract_color = $(subst .,,$(suffix $(subst -,.,$(basename $(notdir $(1))))))
    
box: dist/box-1.stl dist/box-2.stl dist/box-3.stl

lid: dist/lid-1.stl dist/lid-2.stl

dist/%.stl: deckbox.scad | output_dirs
	$(CMD) -o $@ -D 'PART="$(call extract_part,$@)"' -D COLOR=$(call extract_color,$@)

output_dirs: dist deps

dist:
	mkdir -p dist	

deps:
	mkdir -p deps

.PHONY: clean
clean:
	rm -rf dist deps
