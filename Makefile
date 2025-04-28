all: box lid
	
CC=openscad -m make --backend Manifold deckbox.scad
    
box: dist/box-1.stl dist/box-2.stl dist/box-3.stl

lid: dist/lid-1.stl dist/lid-2.stl
	
dist/box-1.stl: deckbox.scad | output_dirs
		$(CC) -o dist/box-1.stl -D PART=1 -D COLOR=1
dist/box-2.stl: deckbox.scad | output_dirs
		$(CC) -o dist/box-2.stl -D PART=1 -D COLOR=2
dist/box-3.stl: deckbox.scad | output_dirs
		$(CC) -o dist/box-3.stl -D PART=1 -D COLOR=3

dist/lid-1.stl: deckbox.scad | output_dirs
		$(CC) -o dist/lid-1.stl -D PART=2 -D COLOR=1
dist/lid-2.stl: deckbox.scad | output_dirs
		$(CC) -o dist/lid-2.stl -D PART=2 -D COLOR=2

output_dirs: dist deps

dist:
	mkdir -p dist	

deps:
	mkdir -p deps

.PHONY: clean
clean:
	rm -rf dist deps
