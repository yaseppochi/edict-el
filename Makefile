# Makefile for Edict

# This file is part of XEmacs.

# XEmacs is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the
# Free Software Foundation; either version 2, or (at your option) any
# later version.

# XEmacs is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# for more details.

# You should have received a copy of the GNU General Public License
# along with XEmacs; see the file COPYING.  If not, write to
# the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
# Boston, MA 02111-1307, USA.

VERSION = 1.06
AUTHOR_VERSION = 0.9.8
MAINTAINER = Stephen J. Turnbull <turnbull@sk.tsukuba.ac.jp>
PACKAGE = edict
PKG_TYPE = regular
REQUIRES = mule-base xemacs-base
CATEGORY = mule

EXTRA_SOURCES = edictj.demo ts-mode.el

ELCS = edict.elc dui.elc edict-morphology.elc edict-japanese.elc \
       edict-english.elc edict-edit.elc edict-test.elc dui-registry.elc

COMPATIBILITY_FLAGS = -eval "(setq byte-compile-print-gensym nil)"

include ../../XEmacs.rules

ifeq ($(BUILD_MULE),t)

all:: $(ELCS) auto-autoloads.elc

srckit: srckit-std

binkit: binkit-common

else
all::
	@echo Edict requires XEmacs/Mule to build

# Two noops
srckit:
binkit:

endif
