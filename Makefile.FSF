# Makefile.FSF

# This file is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the
# Free Software Foundation; either version 2, or (at your option) any
# later version.

# It is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# for more details.

# You should have received a copy of the GNU General Public License
# along with it; see the file COPYING.  If not, write to
# the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
# Boston, MA 02111-1307, USA.

# Makefile to bytecompile edict.el sources under FSF Emacs and build a
# tarball that can be untarred somewhere on the load-path.

# The recommended location is .../emacs/site-lisp/edict, and the
# default location for the dictionary is there also.

AUTHOR_VERSION = 0.9.8
MAINTAINER = Stephen J. Turnbull <turnbull@sk.tsukuba.ac.jp>

# edict-autoloads.el is automatically generated using XEmacs.  It is
# therefore not guaranteed to be 100% up-to-date, but probably is.
# It can be loaded from your .emacs.

ETC = edict-test.el.096 edict.el.096 edict.doc.096 README.096 \
      Makefile.096 install.edict.096 README ChangeLog TODO COPYING

EXTRA_SOURCES = edictj.demo ts-mode.el auto-autoloads.el Makefile

ELCS = edict.elc dui.elc edict-morphology.elc edict-japanese.elc \
       edict-english.elc edict-edit.elc edict-test.elc dui-registry.elc

# path to Emacs
EMACS = emacs

# Emacs without any site or user customizations
VANILLA = --no-init-file --no-site-file

# path to utilities
TAR = tar

# nothing below this line should be changed

.phony: tar

%.elc: %.el
	$(EMACS) $(VANILLA) -batch \
		 --eval "(setq load-path (cons \".\" load-path))" \
		 -f batch-byte-compile $<

all:: $(ELCS)

clean::
	rm -f $(ELCS)

mostlyclean: clean

extraclean: clean

distclean: extraclean
	rm -f core *~

tar:
	if [ -e Makefile.FSF ]; then \
         mv Makefile Makefile.XEmacs; \
	 cp Makefile.FSF Makefile; \
        fi
	$(TAR) cvf edict-$(AUTHOR_VERSION)-fsf.tar \
	           $(ELCS:.elc=.el) $(ETC) $(EXTRA_SOURCES)
	gzip -9 edict-$(AUTHOR_VERSION)-fsf.tar
	if [ -e Makefile.XEmacs ]; then mv Makefile.XEmacs Makefile; fi
