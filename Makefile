# Makefile for Edict

# Copyright (C) 1998, 2002 Free Software Foundation, Inc.

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

VERSION = 1.13
AUTHOR_VERSION = 0.9.9
MAINTAINER = Stephen J. Turnbull <stephen@xemacs.org>
PACKAGE = edict
PKG_TYPE = regular
REQUIRES = mule-base xemacs-base
CATEGORY = mule

ELCS = edict.elc dui.elc edict-morphology.elc edict-japanese.elc \
       edict-english.elc edict-edit.elc edict-update.elc \
       edict-test.elc dui-registry.elc

EXTRA_SOURCES = ts-mode.el Makefile.GNU
DATA_FILES = edictj.demo README \
             ChangeLog.096 README.096 edict.doc.096
DATA_DEST = $(PACKAGE)

COMPATIBILITY_FLAGS = -eval "(setq byte-compile-print-gensym nil)"

include ../../XEmacs.rules
