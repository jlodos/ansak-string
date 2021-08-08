all:
	rm -rf build 2>/dev/null; \
	mkdir build ;\
	cd build ;\
	if [ `uname` = "Darwin" ]; then\
		cmake ../ -G Xcode ;\
		xcodebuild -scheme ansakString -config Release ;\
	else \
		cmake ../ -G "Unix Makefiles" ;\
		make ansakString ;\
	fi

test: all
	cd build; \
	make ansakStringTest; \
    ctest .

install: all
	if [ `uname` = "Darwin" ]; then\
		mkdir -p $$HOME/include/ansak ;\
		cp interface/*hxx $$HOME/include/ansak ;\
		mkdir -p $$HOME/lib ;\
		cp build/Release/libansakString.a $$HOME/lib ;\
	elif [ `uname | sed 's/\(.....\).*/\1/'` = "MINGW" ]; \
		mkdir -p /usr/local/include/ansak ;\
		cp interface/*hxx /usr/local/include/ansak ;\
		cp build/libansakString.a /usr/local/lib ;\
	else \
		sudo mkdir -p /usr/local/include/ansak ;\
		sudo cp interface/*hxx /usr/local/include/ansak ;\
		sudo cp build/libansakString.a /usr/local/lib ;\
	fi

uninstall:
	if [ `uname` = "Darwin" ]; then\
		rm $$HOME/include/ansak/string.hxx $$HOME/include/ansak/string_trim.hxx $$HOME/include/ansak/string_splitjoin.hxx
		rm $$HOME/lib/libansakString.a ;\
	elif [ `uname | sed 's/\(.....\).*/\1/'` = "MINGW" ]; \
		rm /usr/local/include/ansak/string.hxx /usr/local/include/ansak/string_trim.hxx /usr/local/include/ansak/string_splitjoin.hxx  ;\
		rm /usr/local/lib/libansakString.a  ;\
	else \
		sudo rm /usr/local/include/ansak/string.hxx /usr/local/include/ansak/string_trim.hxx /usr/local/include/ansak/string_splitjoin.hxx  ;\
		sudo rm /usr/local/lib/libansakString.a  ;\
	fi

clean:
	-@rm -rf build 2>/dev/null
