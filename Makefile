# Makefile

SHELL = sh -e
PATH = "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Project data
AUTHOR = Luis Alejandro Martínez Faneyth
EMAIL = luis@huntingbears.com.ve
MAILIST = tribus-list@googlegroups.com
PACKAGE = Tribus
CHARSET = UTF-8
VERSION = $(shell cat VERSION | grep "VERSION" | sed 's/VERSION = //g;s/+.*//g')
YEAR = $(shell date +%Y)

# Translation data
LANGUAGETEAM = Tribus Translation Team <tribus-list@googlegroups.com>
POTLIST = locale/pot/tribus/POTFILES.in
POTFILE = locale/pot/tribus/messages.pot
POTITLE = Tribus Translation Template
POTEAM = Tribus Translation Team
PODATE = $(shell date +%F\ %R%z)

# Common files lists
IMGDIR = tribus/web/static/img
IMGS = $(shell ls $(IMGDIR) | grep "\.svg" | sed 's/\.svg//g')
MANDIR = docs/man
MANS = $(shell ls $(MANDIR) | grep "\.rest\.in" | sed 's/\.rest\.in//g')
LOCALES = $(shell find locale -mindepth 1 -maxdepth 1 -type d | sed 's|locale/pot||g;s|locale/||g')
#PHPS = $(wildcard *.php)
ALLPYS = $(shell find . -type f -iname "*.py")

# Build depends
# User build tasks
# gen-img: generates png images from svg and favicons. Uses CONVERT, LIBSVG and ICOTOOL.
# gen-mo: generates mo files from po files. Uses MSGFMT.
# gen-doc: builds all documentation.
# 	- gen-man: generates a man page. Uses RST2MAN.
# 	- gen-wiki: generates github and google code wikis from rest sources. Uses PYTHON.
# 	- gen-html: generates the HTML manual from rest sources. Uses SPHINX
# gen-conf: generates configuration file from user input. Uses BASH.
PYTHON = $(shell which python)
BASH = $(shell which bash)
RST2MAN = $(shell which rst2man)
SPHINX = $(shell which sphinx-build)
MSGFMT = $(shell which msgfmt)
CONVERT = $(shell which convert)
ICOTOOL = $(shell which icotool)
#LIBSVG = $(shell find /usr/lib/ -maxdepth 1 -type d -iname "imagemagick-*")/modules-Q16/coders/svg.so

# Install depends
# User install tasks
# install: install aguilas
#	- copy: copies files over their destination. They need PHP, PHPLDAP and PHPMYSQL.
#	- config: creates MYSQL tables and LDAP entries.
#PHP = $(shell which php5)
#PHPLDAP = $(shell find /usr/lib/ -name "mysql.so" | grep "php5")
#PHPMYSQL = $(shell find /usr/lib/ -name "ldap.so" | grep "php5")

# Maintainer tasks depends
# generatepot: generates POT template from php sources. Uses XGETTEXT.
# updatepos: updates PO files from POT files. Uses MSGMERGE.
# snapshot: makes a new development snapshot. Uses BASH and GIT.
# release: makes a new release. Uses BASH, GIT, PYTHON, MD5SUM, TAR and GBP.
#PYTHON = $(shell which python)
#BASH = $(shell which bash)
#GIT = $(shell which git)
SU = $(shell which su)
APTITUDE = $(shell which aptitude)
FAB = $(shell which fab)
MSGMERGE = $(shell which msgmerge)
XGETTEXT = $(shell which xgettext)
#DEVSCRIPTS = $(shell which debuild)
#DPKGDEV = $(shell which dpkg-buildpackage)
#DEBHELPER = $(shell which dh)
#GBP = $(shell which git-buildpackage)
#LINTIAN = $(shell which lintian)
#GNUPG = $(shell which gpg)
#MD5SUM = $(shell which md5sum)
#TAR = $(shell which tar)

# BUILD TASKS ------------------------------------------------------------------------------

# build: gen-img gen-mo gen-doc

# build-all: gen-img gen-po gen-mo gen-doc

# gen-doc: gen-wiki gen-html gen-man

# gen-predoc: clean-predoc

# 	@echo "Preprocessing documentation ..."
# 	@$(BASH) tools/predoc.sh build

# gen-wiki: check-buildep gen-predoc clean-wiki

# 	@echo "Generating documentation from source [RST > WIKI]"
# 	@cp docs/githubwiki.index docs/rest/Home.md
# 	@cp docs/rest/*.md docs/rest/*.rest docs/githubwiki/
# 	@rm -rf docs/rest/Home.md
# 	@cp docs/googlewiki.index docs/rest/index.rest
# 	@echo "" >> docs/rest/index.rest
# 	@cat docs/rest/contents.rest >> docs/rest/index.rest
# 	@mv docs/rest/contents.rest docs/rest/contents.tmp
# 	@$(PYTHON) -B tools/googlecode-wiki.py
# 	@mv docs/rest/contents.tmp docs/rest/contents.rest
# 	@rm -rf docs/rest/index.rest

# gen-html: check-buildep gen-predoc clean-html

# 	@echo "Generating documentation from source [RST > HTML]"
# 	@cp docs/sphinx.index docs/rest/index.rest
# 	@$(SPHINX) -Q -b html -d docs/html/doctrees docs/rest docs/html
# 	@rm -rf docs/rest/index.rest

# gen-man: check-buildep gen-predoc clean-man

# 	@printf "Generating documentation from source [RST > MAN] ["
# 	@for MAN in $(MANS); do \
# 		$(RST2MAN) --language="en" --title="$${MAN}" docs/man/$${MAN}.rest docs/man/$${MAN}.1; \
# 		printf "."; \
# 	done
# 	@printf "]\n"

# gen-img: check-buildep clean-img

# 	@printf "Generating images from source [SVG > PNG,ICO] ["
# 	@for IMG in $(IMGS); do \
# 		$(CONVERT) -background None $(IMGDIR)/$${IMG}.svg $(IMGDIR)/$${IMG}.png; \
# 		printf "."; \
# 	done
# 	@$(ICOTOOL) -c -o $(IMGDIR)/favicon.ico $(IMGDIR)/favicon.png
# 	@printf "]\n"

# gen-mo: check-buildep clean-mo

# 	@printf "Generating translation messages from source [PO > MO] ["
# 	@for LOCALE in $(LOCALES); do \
# 		$(MSGFMT) locale/$${LOCALE}/LC_MESSAGES/messages.po \
# 			-o locale/$${LOCALE}/LC_MESSAGES/messages.mo; \
# 		printf "."; \
# 	done
# 	@printf "]\n"

#gen-conf: check-buildep clean-conf

#	@echo "Filling up configuration"
#	@$(BASH) tools/gen-conf.sh
#	@echo "Configuration file generated!"

# INSTALL TASKS ------------------------------------------------------------------------------

#install: copy config

#config: check-instdep

#	@mkdir -p $(DESTDIR)/var/www/
#	@mkdir -p $(DESTDIR)/var/log/aguilas/
#	@touch $(DESTDIR)/var/log/aguilas/{ChangePasswordDo.log,DeleteUserDo.log,NewUserDo.log,ResendMailDo.log,ResetPasswordDo.log,ResetPasswordMail.log}
#	@ln -s $(DESTDIR)/usr/share/aguilas /var/www/aguilas
#	@$(PHP) -f setup/install.php
#	@echo "AGUILAS configured and running!"

#copy:

#	@mkdir -p $(DESTDIR)/usr/share/aguilas/setup/

#	@# Installing application
#	@cp -r locale libraries themes $(DESTDIR)/usr/share/aguilas/
#	@install -D -m 644 $(PHPS) $(DESTDIR)/usr/share/aguilas/
#	@install -D -m 644 setup/config.* $(DESTDIR)/usr/share/aguilas/setup/

#	@# Removing unnecesary svg's
#	@for THEME in $(THEMES); do \
#		for IMAGE in $(IMAGES); do \
#			rm -rf $(DESTDIR)/usr/share/aguilas/themes/$${THEME}/images/$${IMAGE}.svg; \
#		done; \
#		rm -rf themes/$${THEME}/images/favicon.png; \
#	done
#	@echo "Files copied"

#uninstall: check-instdep

#	@$(PHP) -f setup/uninstall.php
#	@rm -rf $(DESTDIR)/usr/share/aguilas/
#	@rm -rf $(DESTDIR)/var/log/aguilas/
#	@rm -rf $(DESTDIR)/var/www/aguilas/
#	@echo "Uninstalled"

#reinstall: uninstall install


# MAINTAINER TASKS ---------------------------------------------------------------------------------

checkpkg:

	@printf "Checking if we have $(PACKAGE) ... "
	@if [ -z $(shell which $(TESTBIN)) ]; then \
		echo "[ABSENT]"; \
		echo "Installing $(PACKAGE) ... "; \
		echo "Enter your root password:"; \
		$(SU) root -c "$(APTITUDE) install $(PACKAGE)"; \
	else \
		echo "[OK]"; \
	fi
	@echo

fabric:

	@$(MAKE) checkpkg PACKAGE=fabric TESTBIN=fab
	@$(MAKE) checkpkg PACKAGE=openssh-server TESTBIN=sshd

runserver: fabric

	@$(FAB) development runserver_django

syncdb: fabric

	@$(FAB) development syncdb_django

development: fabric

	@$(FAB) development environment

update_po: fabric 

	@$(FAB) development update_po

create_pot: fabric

	@$(FAB) development create_pot

# snapshot: check-maintdep prepare gen-html gen-wiki gen-po clean

# 	@$(MAKE) clean
# 	@$(BASH) tools/snapshot.sh

# release: check-maintdep

# 	@$(BASH) tools/release.sh

# deb-test-snapshot: check-maintdep

# 	@$(BASH) tools/buildpackage.sh test-snapshot

# deb-test-release: check-maintdep

# 	@$(BASH) tools/buildpackage.sh test-release

# deb-final-release: check-maintdep

# 	@$(BASH) tools/buildpackage.sh final-release

# CLEAN TASKS ------------------------------------------------------------------------------

# clean: clean-img clean-mo clean-man clean-conf clean-predoc clean-pyc

# clean-all: clean-img clean-mo clean-html clean-wiki clean-man   clean-predoc clean-pyc

# clean-pyc:

# 	@echo "Cleaning precompiled python files ..."
# 	@find . -iname "*.pyc" -o -iname "*~" | xargs -I {} rm -v "{}"

# clean-predoc:

# 	@echo "Cleaning preprocessed documentation files ..."
# 	@$(BASH) tools/predoc.sh clean
# 	@rm -rf docs/rest/index.rest

# clean-img:

# 	@printf "Cleaning generated images [PNG,ICO] ["
# 	@for IMG in $(IMGS); do \
# 		rm -rf $(IMGDIR)/$${IMAGE}.png; \
# 		printf "."; \
# 	done
# 	rm -rf $(IMGDIR)/favicon.ico
# 	@printf "]\n"

# clean-mo:

# 	@printf "Cleaning generated localization ["
# 	@for LOCALE in $(LOCALES); do \
# 		rm -rf locale/$${LOCALE}/LC_MESSAGES/messages.mo; \
# 		printf "."; \
# 	done
# 	@printf "]\n"

# clean-html:

# 	@echo "Cleaning generated html ..."
# 	@rm -rf docs/html/*
# 	@rm -rf docs/html/.buildinfo

# clean-wiki:

# 	@echo "Cleaning generated wiki pages ..."
# 	@rm -rf docs/googlewiki/*
# 	@rm -rf docs/githubwiki/*

# clean-man:

# 	@echo "Cleaning generated man pages ..."
# 	@rm -rf docs/man/aguilas.1

#clean-conf:

#	@echo "Cleaning generated configuration ..."
#	@rm -rf setup/config.php

# CHECK DEPENDENCIES ---------------------------------------------------------------------------------------------

# check-instdep:

# 	@printf "Checking if we have PHP ... "
# 	@if [ -z $(PHP) ]; then \
# 		echo "[ABSENT]"; \
# 		echo "If you are using Debian, Ubuntu or Canaima, please install the \"php5-cli\" package."; \
# 		exit 1; \
# 	fi
# 	@echo

# 	@printf "Checking if we have PHP LDAP support ... "
# 	@if [ -z $(PHPLDAP) ]; then \
# 		echo "[ABSENT]"; \
# 		echo "If you are using Debian, Ubuntu or Canaima, please install the \"php5-ldap\" package."; \
# 		exit 1; \
# 	fi
# 	@echo

# 	@printf "Checking if we have PHP MYSQL support ... "
# 	@if [ -z $(PHPMYSQL) ]; then \
# 		echo "[ABSENT]"; \
# 		echo "If you are using Debian, Ubuntu or Canaima, please install the \"php5-mysql\" package."; \
# 		exit 1; \
# 	fi
# 	@echo

# check-maintdep:

# 	@printf "Checking if we have python ... "
# 	@if [ -z $(PYTHON) ]; then \
# 		echo "[ABSENT]"; \
# 		echo "If you are using Debian, Ubuntu or Canaima, please install the \"python\" package."; \
# 		exit 1; \
# 	fi
# 	@echo

# 	@printf "Checking if we have bash... "
# 	@if [ -z $(BASH) ]; then \
# 		echo "[ABSENT]"; \
# 		echo "If you are using Debian, Ubuntu or Canaima, please install the \"bash\" package."; \
# 		exit 1; \
# 	fi
# 	@echo

# 	@printf "Checking if we have git... "
# 	@if [ -z $(GIT) ]; then \
# 		echo "[ABSENT]"; \
# 		echo "If you are using Debian, Ubuntu or Canaima, please install the \"git-core\" package."; \
# 		exit 1; \
# 	fi
# 	@echo

# 	@printf "Checking if we have xgettext ... "
# 	@if [ -z $(XGETTEXT) ]; then \
# 		echo "[ABSENT]"; \
# 		echo "If you are using Debian, Ubuntu or Canaima, please install the \"gettext\" package."; \
# 		exit 1; \
# 	fi
# 	@echo

# 	@printf "Checking if we have msgmerge ... "
# 	@if [ -z $(MSGMERGE) ]; then \
# 		echo "[ABSENT]"; \
# 		echo "If you are using Debian, Ubuntu or Canaima, please install the \"gettext\" package."; \
# 		exit 1; \
# 	fi
# 	@echo

# 	@printf "Checking if we have debhelper ... "
# 	@if [ -z $(DEBHELPER) ]; then \
# 		echo "[ABSENT]"; \
# 		echo "If you are using Debian, Ubuntu or Canaima, please install the \"debhelper\" package."; \
# 		exit 1; \
# 	fi
# 	@echo

# 	@printf "Checking if we have devscripts ... "
# 	@if [ -z $(DEVSCRIPTS) ]; then \
# 		echo "[ABSENT]"; \
# 		echo "If you are using Debian, Ubuntu or Canaima, please install the \"devscripts\" package."; \
# 		exit 1; \
# 	fi
# 	@echo

# 	@printf "Checking if we have dpkg-dev ... "
# 	@if [ -z $(DPKGDEV) ]; then \
# 		echo "[ABSENT]"; \
# 		echo "If you are using Debian, Ubuntu or Canaima, please install the \"dpkg-dev\" package."; \
# 		exit 1; \
# 	fi
# 	@echo

# 	@printf "Checking if we have git-buildpackage ... "
# 	@if [ -z $(GBP) ]; then \
# 		echo "[ABSENT]"; \
# 		echo "If you are using Debian, Ubuntu or Canaima, please install the \"git-buildpackage\" package."; \
# 		exit 1; \
# 	fi
# 	@echo

# 	@printf "Checking if we have lintian ... "
# 	@if [ -z $(LINTIAN) ]; then \
# 		echo "[ABSENT]"; \
# 		echo "If you are using Debian, Ubuntu or Canaima, please install the \"lintian\" package."; \
# 		exit 1; \
# 	fi
# 	@echo

# 	@printf "Checking if we have gnupg ... "
# 	@if [ -z $(GNUPG) ]; then \
# 		echo "[ABSENT]"; \
# 		echo "If you are using Debian, Ubuntu or Canaima, please install the \"gnupg\" package."; \
# 		exit 1; \
# 	fi
# 	@echo

# 	@printf "Checking if we have md5sum... "
# 	@if [ -z $(MD5SUM) ]; then \
# 		echo "[ABSENT]"; \
# 		echo "If you are using Debian, Ubuntu or Canaima, please install the \"coreutils\" package."; \
# 		exit 1; \
# 	fi
# 	@echo

# 	@printf "Checking if we have tar ... "
# 	@if [ -z $(TAR) ]; then \
# 		echo "[ABSENT]"; \
# 		echo "If you are using Debian, Ubuntu or Canaima, please install the \"tar\" package."; \
# 		exit 1; \
# 	fi
# 	@echo

# check-buildep:

# 	@printf "Checking if we have python ... "
# 	@if [ -z $(PYTHON) ]; then \
# 		echo "[ABSENT]"; \
# 		echo "If you are using Debian, Ubuntu or Canaima, please install the \"python\" package."; \
# 		exit 1; \
# 	fi
# 	@echo

# 	@printf "Checking if we have bash... "
# 	@if [ -z $(BASH) ]; then \
# 		echo "[ABSENT]"; \
# 		echo "If you are using Debian, Ubuntu or Canaima, please install the \"bash\" package."; \
# 		exit 1; \
# 	fi
# 	@echo

# 	@printf "Checking if we have sphinx-build ... "
# 	@if [ -z $(SPHINX) ]; then \
# 		echo "[ABSENT]"; \
# 		echo "If you are using Debian, Ubuntu or Canaima, please install the \"python-sphinx\" package."; \
# 		exit 1; \
# 	fi
# 	@echo

# 	@printf "Checking if we have convert ... "
# 	@if [ -z $(CONVERT) ]; then \
# 		echo "[ABSENT]"; \
# 		echo "If you are using Debian, Ubuntu or Canaima, please install the \"imagemagick\" package."; \
# 		exit 1; \
# 	fi
# 	@echo

# 	@printf "Checking if we have rst2man ... "
# 	@if [ -z $(RST2MAN) ]; then \
# 		echo "[ABSENT]"; \
# 		echo "If you are using Debian, Ubuntu or Canaima, please install the \"python-docutils\" package."; \
# 		exit 1; \
# 	fi
# 	@echo

# 	@printf "Checking if we have msgfmt ... "
# 	@if [ -z $(MSGFMT) ]; then \
# 		echo "[ABSENT]"; \
# 		echo "If you are using Debian, Ubuntu or Canaima, please install the \"gettext\" package."; \
# 		exit 1; \
# 	fi
# 	@echo

# 	@printf "Checking if we have icotool ... "
# 	@if [ -z $(ICOTOOL) ]; then \
# 		echo "[ABSENT]"; \
# 		echo "If you are using Debian, Ubuntu or Canaima, please install the \"icoutils\" package."; \
# 		exit 1; \
# 	fi
# 	@echo

# 	@printf "Checking if we have imagemagick svg support ... "
# 	@if [ -z $(LIBSVG) ]; then \
# 		echo "[ABSENT]"; \
# 		echo "If you are using Debian, Ubuntu or Canaima, please install the \"libmagickcore-extra\" package."; \
# 		exit 1; \
# 	fi
# 	@echo
