all:
	haxe build.hxml

deploy:
	rm -rf build
	haxe build.hxml
	uglifyjs --compress --mangle -- build/generated.js > build/generated.min.js
	mv build/generated.min.js build/generated.js
	rsync -ravze ssh . ubuntu@ivy.firefal.com:/var/www/html/fall--progress --exclude='**/*.hx' --exclude='.git'

