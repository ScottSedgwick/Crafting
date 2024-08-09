clean:
	rm -rf output

copy_assets: clean
	mkdir output
	cp -R assets/* output/

build: clean copy_assets
	elm make src/Main.elm --output=output/elm.full.js --optimize
	uglifyjs output/elm.full.js --compress "pure_funcs=[F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9],pure_getters,keep_fargs=false,unsafe_comps,unsafe" | uglifyjs --mangle --output output/elm.js
	rm output/elm.full.js