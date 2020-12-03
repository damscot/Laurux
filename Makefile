PROJECT:=Laurux
APP:=Laurux
GIT_SHA1:=$(shell git rev-list HEAD | head -n 1)
GIT_BRANCH:=$(shell git branch | grep "*" | sed -e "s/^* //g")
VERSION:=$(shell grep "Version=" .project | sed -e "s/Version=//g")
CHANGELOG_GEN:=$(HOME)/github-changelog-generator/bin/github_changelog_generator
GIT_TOKEN:=`cat $(HOME)/github_token`

prefix ?= /usr
bindir ?= bin

vecho = @echo
ifeq ("$(V)","1")
Q :=
vvecho = @echo
else
Q := @
vvecho = @true
endif

ifeq ("$(O)","")
O:=.hidden/Stable
endif

all: $(APP) 

$(APP).desktop: Makefile
	$(Q) echo "[Desktop Entry]" > $@
	$(Q) echo "Name=$(APP)" >> $@
	$(Q) echo "Exec=$(DESTDIR)$(prefix)/$(bindir)/$(APP)" >> $@
	$(Q) echo "Icon=Larus.png" >> $@
	$(Q) echo "Terminal=false" >> $@
	$(Q) echo "Type=Application" >> $@
	$(Q) echo "Categories=Finance" >> $@
	$(Q) chmod 755 $@

$(APP): $(APP).desktop .project $(shell find .src -type f)
	$(vvecho) "Setting version info sha1 to $(GIT_SHA1) for $(GIT_BRANCH)"
	$(Q) echo "$(GIT_SHA1)" > sha1.txt
	$(Q) echo "$(GIT_BRANCH)" > branch.txt
	$(vecho) "Compiling $(PROJECT) for Version $(VERSION) ($(GIT_SHA1))"
	$(Q)gbc3 -agt >/dev/null 2>&1
	$(vecho) "Generation Binary $@"
	$(Q)gba3 -o $@
	$(vvecho) "Restoring default sha1 / branch"

clean:
	$(vecho) "Cleaning $(PROJECT)"	
	$(Q)rm -f $(APP)
	$(Q)rm -f $(APP).desktop
	$(Q)rm -rf $(O)
	$(Q)rm -rf .gambas

changelog:
	$(vecho) "Generating Changelog $(PROJECT)"
	$(Q)$(CHANGELOG_GEN) -u Laurux -p $(PROJECT) -t $(GIT_TOKEN)

$(O)/$(VERSION)/$(PROJECT).tar.gz: $(APP) $(APP).desktop Icones/Larus.png
	$(vecho) "Packaging $(PROJECT) v$(VERSION) ($(GIT_SHA1)) in path $(O)/$(VERSION)"
	$(Q) mkdir -p $(O)/$(VERSION)
	$(Q) echo "$(PROJECT) v$(VERSION)" > $(O)/$(VERSION)/version.txt
	$(Q) tar --transform 's,^,$(PROJECT)/,' -zcf $@ $^

install: $(APP) $(APP).desktop Icones/Larus.png
	$(Q) install -D $(APP) -m 755 -t $(DESTDIR)$(prefix)/$(bindir)
	$(Q) install -D $(APP).desktop -m 644 -t $(DESTDIR)$(prefix)/share/applications
	$(Q) install -D Icones/Larus.png -m 644 -t $(DESTDIR)$(prefix)/share/icons/hicolor/64x64/apps

.phony: package
package: $(O)/$(VERSION)/$(PROJECT).tar.gz

