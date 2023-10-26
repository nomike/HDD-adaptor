SHELL := /bin/bash

default: build-stl

.PHONY: build-stl clean

out:
	mkdir -p out

build-stl: out
	for drive_heigth in 5 7 9.5 12.5 15 19 ; do \
		for sliders in small big none ; do \
		   openscad -o out/$${drive_heigth}mm-$${sliders}-sliders-HDD\ adaptor.stl -D drive_heigth=$$drive_heigth -D sliders=\"$$sliders\" HDD\ adaptor.scad ; \
		done ; \
	done

clean:
	rm -rf out