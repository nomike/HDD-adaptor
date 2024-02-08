SHELL := /bin/bash

default: build-stl

.PHONY: build-stl clean

out:
	mkdir -p out

build-stl: out
	for drive_height in 5 7 9.5 12.5 15 19 ; do \
		for sliders in small big none ; do \
		   openscad -o out/$${drive_height}mm-$${sliders}-sliders-HDD\ adaptor.stl -D drive_height=$$drive_height -D sliders=\"$$sliders\" HDD\ adaptor.scad ; \
		done ; \
	done

clean:
	rm -rf out