all: main testp dynlib.dylib bradsnode.dylib filenode.dylib

main: main.c
	/usr/local/Cellar/llvm/11.0.0/bin/clang  main.c -g -o main

testp: testp.c
	/usr/local/Cellar/llvm/11.0.0/bin/clang  testp.c -o testp

dynlib.dylib: dynlib.c
	/usr/local/Cellar/llvm/11.0.0/bin/clang  dynlib.c -fpic -shared -Wl,-all_load -o dynlib.dylib

node:
	git clone https://github.com/nodejs/node.git
	cd node && git checkout v14.15.3 && cd ..

node/out/Release/libnode.a: node
	cd node && ./configure && cd ..
	make -C node

bradsnode.dylib: node/out/Release/libnode.a bradsdylib.c
	c++ -I node/deps/v8/include/ -I ./node/src/ -isystem ./node/src/  -std=c++11   -Wl,-force_load,./node/out/Release/libnode.a -Wl,-force_load,./node/out/Release/libv8_base_without_compiler.a -Wl,-force_load,./node/out/Release/libzlib.a -Wl,-force_load,./node/out/Release/libuv.a -Wl,-force_load,./node/out/Release/libv8_snapshot.a -Wl,-force_load,./node/out/Release/libopenssl.a -Wl,-no_pie -Wl,-search_paths_first -mmacosx-version-min=10.13 -arch x86_64 -L./node/out/Release -stdlib=libc++ -shared -undefined dynamic_lookup    -o bradsnode.dylib ./node/out/Release/obj.target/node/src/node_main.o ./node/out/Release/obj.target/node/gen/node_code_cache.o ./node/out/Release/obj.target/node/gen/node_snapshot.o ./node/out/Release/libhistogram.a ./node/out/Release/libuvwasi.a ./node/out/Release/libnode.a ./node/out/Release/libv8_snapshot.a ./node/out/Release/libv8_libplatform.a ./node/out/Release/libicui18n.a ./node/out/Release/libzlib.a ./node/out/Release/libllhttp.a ./node/out/Release/libcares.a ./node/out/Release/libuv.a ./node/out/Release/libnghttp2.a ./node/out/Release/libbrotli.a ./node/out/Release/libopenssl.a ./node/out/Release/libicuucx.a ./node/out/Release/libicudata.a ./node/out/Release/libv8_base_without_compiler.a ./node/out/Release/libv8_libbase.a ./node/out/Release/libv8_libsampler.a ./node/out/Release/libv8_zlib.a ./node/out/Release/libv8_compiler.a ./node/out/Release/libv8_initializers.a bradsdylib.c   -framework CoreFoundation -lm


filenode.dylib: node/out/Release/libnode.a filenodedylib.c
	c++ -I node/deps/v8/include/ -I ./node/src/ -isystem ./node/src/  -std=c++11   -Wl,-force_load,./node/out/Release/libnode.a -Wl,-force_load,./node/out/Release/libv8_base_without_compiler.a -Wl,-force_load,./node/out/Release/libzlib.a -Wl,-force_load,./node/out/Release/libuv.a -Wl,-force_load,./node/out/Release/libv8_snapshot.a -Wl,-force_load,./node/out/Release/libopenssl.a -Wl,-no_pie -Wl,-search_paths_first -mmacosx-version-min=10.13 -arch x86_64 -L./node/out/Release -stdlib=libc++ -shared -undefined dynamic_lookup    -o filenode.dylib ./node/out/Release/obj.target/node/src/node_main.o ./node/out/Release/obj.target/node/gen/node_code_cache.o ./node/out/Release/obj.target/node/gen/node_snapshot.o ./node/out/Release/libhistogram.a ./node/out/Release/libuvwasi.a ./node/out/Release/libnode.a ./node/out/Release/libv8_snapshot.a ./node/out/Release/libv8_libplatform.a ./node/out/Release/libicui18n.a ./node/out/Release/libzlib.a ./node/out/Release/libllhttp.a ./node/out/Release/libcares.a ./node/out/Release/libuv.a ./node/out/Release/libnghttp2.a ./node/out/Release/libbrotli.a ./node/out/Release/libopenssl.a ./node/out/Release/libicuucx.a ./node/out/Release/libicudata.a ./node/out/Release/libv8_base_without_compiler.a ./node/out/Release/libv8_libbase.a ./node/out/Release/libv8_libsampler.a ./node/out/Release/libv8_zlib.a ./node/out/Release/libv8_compiler.a ./node/out/Release/libv8_initializers.a filenodedylib.c   -framework CoreFoundation -lm



runNode: main bradsdylib.c
	./main testp "" bradsnode.dylib
	
demoRun: main testp dynlib.dylib
	unzip bradsnode.dylib.zip
	./main testp "" bradsnode.dylib
	
demoFile: main filenode.dylib
	./main testp "" filenode.dylib

