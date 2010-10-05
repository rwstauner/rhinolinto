SHELL = /bin/bash
RHINO_REV = rhino1_7R2

.PHONY : all deps
all : deps

deps :
	if ! [[ -d vendor ]]; then mkdir vendor; fi; \
	cd vendor; \
	if ! [[ -e jslint.js ]]; then \
		wget http://www.jslint.com/rhino/jslint.js; \
	fi; \
	if ! [[ -e rhino.jar ]]; then \
		wget ftp://ftp.mozilla.org/pub/mozilla.org/js/$(RHINO_REV).zip; \
		unzip -p $(RHINO_REV).zip $(RHINO_REV)/js.jar > rhino.jar; \
	fi
