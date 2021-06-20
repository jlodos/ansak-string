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


install:
	if [ `uname` = "Darwin" ]; then\
		@mkdir -p $$HOME/include/ansak ;\
		@cp interface/*hxx $$HOME/include/ansak ;\
		@mkdir -p $$HOME/lib ;\
		@cp build/Release/libansakString.a $$HOME/lib ;\
	else \
		sudo mkdir -p /usr/local/include/ansak ;\
		sudo cp interface/*hxx /usr/local/include/ansak ;\
		sudo cp build/libansakString.a /usr/local/lib ;\
	fi

uninstall:
	if [ `uname` = "Darwin" ]; then\
		rm $$HOME/include/ansak/string.hxx $$HOME/include/ansak/string_trim.hxx $$HOME/include/ansak/string_splitjoin.hxx
		rm $$HOME/lib/libansakString.a ;\
	else \
		sudo rm /usr/local/include/ansak/string.hxx /usr/local/include/ansak/string_trim.hxx /usr/local/include/ansak/string_splitjoin.hxx  ;\
		sudo cp build/libansakString.a /usr/local/lib ;\
	fi
