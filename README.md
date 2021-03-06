# __edict.el__ optimized for XEmacs

Version 0.9.9

Converted-to-Markdown: 2021 August 12

This file Copyright 1998, 2002 Free Software Foundation, Inc.

The __edict.el__ package is Copyright 1991, 1992 Per Hammarlund
  <perham@nada.kth.se>, 1992 Bob Kerns <rwk@crl.dec.com>, and 1998, 2002
  Free Software Foundation, Inc.

Individual files may have their own Copyrights differing from the above.

This file is part of XEmacs.

It is free software; you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2, or (at your
option) any later version.

XEmacs is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with XEmacs; if not, write to the Free Software Foundation,
Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

Original author:  Per Hammarlund <perham@nada.kth.se>
Other authors:    Bob Kerns <rwk@crl.dec.com>
                  Stephen J. Turnbull <stephen@xemacs.org>

Adapted-by:  Stephen J. Turnbull <stephen@xemacs.org> for XEmacs
Maintainer:  Stephen J. Turnbull <stephen@xemacs.org>

## Whatzit?

The original __edict.el__ was written by Per Hammarlund. It is an
interface to the EDICT Japanese-English dictionary compiled by Jim
Breen at Monash University.  Using the region and couple of
keystrokes, __edict.el__ will look up the Japanese key and return all the
EDICT entries containing that key, in a pop-up buffer.  English is
even easier, you just put point anywhere in the word you want to look
up.

Bob Kerns added a morphology engine, which reduces a highly inflected
Japanese word to a list of dictionary forms (eg, itta -> (iku, iu)),
all of which are looked up.

## NEWS

Version 0.9.9

You can now use the Customize interface (in the 'edict subgroup of the
'mule group) to set variables.

An experimental automated update function is partially implemented,
but already useful.  `update-edict` uses wget to fetch the current
version(s) of the edict dictionary(ies) you use from the Monash
University Nihongo archive, or a user-specified mirror.

Version 0.9.8

After several years of service, it became partially incompatible with
recent GNU Emacsen, especially the keymaps and the byte compiler, and
never was adapted for XEmacs (which only recently acquired Japanese
capability).  This BETA release adapts __edict.el__ to XEmacs (because
that's what the maintainer uses), packages it for ease of installation
on XEmacs, and provides a unified interface to the functions via the
Dictionary Lookup minor mode.

Documentation from version 0.9.6 (the last version maintained by Per
Hammarlund) is included in the appropriate .../etc directory, with the
file extension .096.  (This numbering is unrelated to the numbering of
XEmacs packages.)

## Installation

For XEmacs >= 21.1, use the package user interface.

For XEmacs >= 20.3, get edict-<version>-pkg.tar.gz from

	       ftp://ftp.emacs.org/pub/xemacs/packages/

and untar it in the the directory ~/.xemacs (or top directory of your
package hierarchy).  If you are using XEmacs >= 20.5, you're done.  If
you're using XEmacs 20.3 or 20.4, then add

	 `(load-file "~/.xemacs/lisp/edict/auto-autoloads.el")`

to your __~/.emacs__ or __~/.xemacs/init.el__.

Get edict (the dictionary) from
ftp://ftp.cc.monash.edu.au/pub/nihongo/, and install it in an
appropriate etc/ or etc/edict/ in your package hierarchy
(~/.xemacs/etc/ is fine).  For trial purposes, there is a tiny
edictj.demo dictionary supplied with __edict.el__.

For mainline GNU Emacs >= 20.1, get edict-<version>-pkg.tar.gz from
the URL above.  Unpack it somewhere; .../emacs/site-lisp/edict/ is
recommended.  The dictionary should go in the same directory.  (This
is intended to be automatically found, but version 0.9.9 doesn't do
that yet.  You will have to set either the `edict-dictionary-path` or
`edict-dictionaries`.)

Users of other versions of Mule are welcome to play around; please
tell me what you did, whether it works or not.  Due to changes in
keymap code, it is highly unlikely that the current version of
__edict.el__ will work with nemacs or Mule based on Emacs version 18.

If you have special needs, the package sources are available by CVS,
see http://cvs.xemacs.org/.  Makefile is very XEmacs (>=20) specific;
Makefile.GNU is provided for building for the FSF's distribution of
Emacs.  Mainline GNU Emacs and XEmacs are nearly byte-code compatible;
unfortunately the incompatibilities are most likely to show up in Mule
applications, so you should byte-compile the source with the Emacs you
plan to use the package with.

## User Setup

Users of recent XEmacsen should need little setup, unless you are
using public dictionaries not named "edict" or user dictionaries not
in your home directory or not named ".edict".  In that case, set the
variables `edict-dictionaries` and `edict-user-dictionary` as needed.

Other users may need to set up autoloads and possibly their
load-paths.  A file auto-autoloads.el is provided; this file can only
(at this time) be produced using XEmacs, but it should work with other
Emacs.  This file is automatically consulted by XEmacs; users of
mainline GNU Emacs should be able to use it by adding

      `(load-file "<path-to>/site-lisp/edict/auto-autoloads.el")`

to .emacs.  (`load-file`, rather than `load-library`, is suggested
because every XEmacs package has a file named auto-autoloads.el.)

The necessary autoloads may also be found by

		  grep -A 1 '^;;;###autoload$' *.el

You should also probably set the variable `edict-dictionary-path` to
help edict find your public dictionaries.

For some reason, Mule occasionally has trouble recognizing the file
coding system of edict files.  If so, the Monash distribution
dictionary `edict`, which is in EUC-JP format, should be correctly
initialized by

	   `(setq edict-dictionaries '(("edict" . euc-jp)))`

in .emacs.  The value of this variable is a LIST of CONS-or-STRING.
If a CONS, it should have a STRING as car and a CODING-SYSTEM as cdr.
Note that the name of this variable has changed.  If your dictionary
directory is not found at all, you can setq `edict-dictionary-path` to
a LIST of strings, each of which should be a path to a directory which
might contain edict dictionaries.

## Usage

The interface to edict is now the Dictionary Lookup minor mode
(dl-mode).  It is invoked as usual by (eg) `M-x dl-mode`, and its
modeline indicator is "dl".  dl-mode is autoloaded.  The various
functions are bound to keys in a mode-specific keymap, which is
invoked by a prefix key.  The default prefix is `C-c $` (by analogy
with ispell's `M-$`).

Unlike the former interface, dui is intended to be a general interface
to various dictionary-like commands.  Dictionary lookup is bound to
`s` (for "search") in the sub-keymap; insertion and help are bound
to `i` and `d` (for "describe method" respectively.  The search mode
is initialized to "EDICT search Japanese" by default.

Using a prefix argument allows you to change modes.  Eg, `C-u C-c $ s`
generates a prompt for a "Method:".  Currently valid search methods
include "EDICT search Japanese", "EDICT search English", and "ispell
word".  Valid insert methods include "EDICT add English" and "EDICT add 
Japanese".

__edict.el__ provides a simple dictionary editing mode, automatically
invoked by the "EDICT add ..." methods, with TAB switching 
between fields.  An experimental `electric-henkan` mode is available,
in which the mode recognizes whether a field is Japanese or English
and invokes your preferred henkan method appropriately.  To try this
out `(setq edict-use-electric-henkan t)`.  Note that electric henkan
uses the LEIM interface, so it cannot work if your preferred input
method is XIM.

Due to the indirect way in which the actual methods are called, a
separate help function, `dui-describe-method`, bound to `C-c $ d`, is
provided to access method documentation.

Enjoy!

## Bug reports, comments, and feature requests

Please send these to "Stephen Turnbull" <stephen@xemacs.org>.

Bug reports are of course of high priority, but I am hoping that users 
will also report inflections and idioms that the morphology engine
does not handle.

Known bugs and problems are in the file TODO.  (Documentation and
organization are both known bugs....)

With the reimplementation as a minor mode, it now makes sense to
provide keystrokes for variations on the basic theme.  One example
(already implemented for ispell) is to use dl-mode to access other
dictionary applications.  Another possibility is that kanjidic can be
loaded into the *edict* buffer as well; one could imagine restricted
functions (not yet implemented) that only search kanjidic or only
edict.  Suggestions are welcome.

## Historical notes

The files __edict.el.096__ and __edict-test.el.096__ in the source
distribution are from the original version 0.9.6 distribution grabbed
from ftp.cc.monash.edu.au.  The ChangeLog for version 0.9.6 is in
ChangeLog.096, which is included in all forms of the current
distribution.

The __.el__ files in this package have been converted to ISO-2022-JP
encoding.

All hail Jim, Per, and Bob!

