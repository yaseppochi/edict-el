;; edict-update.el --- Dictionary update functions for edict.el

;; Copyright (C) 2002 Free Software Foundation, Inc.

;; Author:      Stephen J. Turnbull <stephen@xemacs.org>
;; Keywords:    mule, edict, dictionary
;; Version:     0.5
;; Created:     27 January 2002
;; Last Update: 27 January 2002
;; Maintainer:  Stephen J. Turnbull <stephen@xemacs.org>

;;   This file is part of XEmacs.

;;   XEmacs is free software; you can redistribute it and/or modify it
;;   under the terms of the GNU General Public License as published by
;;   the Free Software Foundation; either version 2, or (at your
;;   option) any later version.

;;   XEmacs is distributed in the hope that it will be useful, but
;;   WITHOUT ANY WARRANTY; without even the implied warranty of
;;   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;   General Public License for more details.
;; 
;;   You should have received a copy of the GNU General Public License
;;   along with XEmacs; if not, write to the Free Software Foundation,
;;   Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

;;; Commentary:

;; Functions to update EDICT dictionaries and to report private dictionary
;; words upstream.

;; Usage:

;; Customize `edict-dictionary-path', `edict-dictionaries',
;; `edict-update-file-list', `edict-update-staging',
;; `edict-update-local-mirror', and `edict-update-archive-url'
;; appropriately.  Then "M-x edict-update RET" and if you're lucky,
;; you're done.

;; TODO:

;; 1. Use the package transport stuff I wrote; test it here.
;; 2. Think carefully about the process of updating packages.  The
;;    problem is that there should be a difference between updates
;;    done by administrators and updates done by ordinary users.  The
;;    administrators should update the main hierarchies, while the
;;    users should update their personal packages.  This probably
;;    involves checking for write permission and/or ownership on the
;;    package hierarchy and possibly some kind of "su.el"
;;    functionality.

;;; Code

(require 'edict)			; for dictionary list and path

;;; User customization

(defgroup edict-update nil
  "Customization of functions used to keep your EDICT current."
  :group 'edict)

(defcustom edict-update-file-list nil
  "List of files to update.

If nil, default to the value of `edict-dictionaries'."
  ;; #### should default to something else for package administrators,
  ;; like all known edict dictionaries.
  :type '(repeat file)
  :group 'edict-update)

(defcustom edict-update-staging "/tmp/edict"
  "Basename of temporary directory for staging EDICT dictionary archives.

Should not end in a slash, because it will be used to generate a unique
name for a directory to be created.  The directory is deleted after use.

If `edict-update-local-mirror' is non-nil, this variable is ignored."
  :type 'file				; not directory
  :group 'edict-update)

(defcustom edict-update-local-mirror nil
  "Path to a local mirror of the EDICT dictionary archives.

Files downloaded here are persistent.  This location takes precedence
over `edict-update-staging'."
  :type '(choice directory
		 (const :tag "none" nil))
  :group 'edict-update)

(defcustom edict-update-archive-url
  "ftp://ftp.cc.monash.edu.au/pub/nihongo/"
  "URL pointing to a host and directory serving EDICT dictionaries.

Should end with a slash.

Default is Jim Breen's Nihongo Archive at Monash University,
ftp://ftp.cc.monash.edu.au/pub/nihongo/."
  ;; WE DEMAND AN URL WIDGET!!
  :type 'string
  :group 'edict-update)

(defcustom edict-update-sources-alist
  '(("edict" "edict.gz")
    ("kanjidic" "kanjidic.gz")
    ("enamdict" "enamdict.gz"))
  "Map dictionaries to archive name to download.

This isn't really a user customization (should be constant over time and
for different mirrors), but made customizable for convenience."
  :type '(repeat (list string string))
  :group 'edict-update)

;; #### Evile temporary hack
(defvar edict-update-wget-options "-N")

;;; Implementation

;;;###autoload
(defun edict-update ()
  "Update edict dictionaries from archives on the 'Net.

Customize `edict-dictionary-path', `edict-dictionaries',
`edict-update-file-list', `edict-update-staging',
`edict-update-local-mirror', and `edict-update-archive-url' to
determine how and where to download and install.

#### Currently not at all robust, requires wget on the path." 

  (interactive)

  (let ((stage (edict-update-setup-stage))
	(destination (file-name-as-directory (car edict-dictionary-path)))
	(sources edict-update-sources-alist)
	(files (or edict-update-file-list edict-dictionaries)))
    ;; #### provide for alternative transports
    (mapc (lambda (source)
	    (when (member (first source) files)
	      ;; #### this is very fragile
	      (shell-command
	       (concat "cd " stage "; "
		       "wget " edict-update-wget-options " "
		       edict-update-archive-url (second source)))
	      (shell-command
	       (concat "cd " stage "; "
		       (if edict-update-local-mirror "cp " "mv ")
		       (second source) " " destination))
	      (when (string-match "\\.gz$" (second source))
		(shell-command
		 (concat "cd " destination "; " "gunzip " (second source))))))
	  sources)
    (edict-update-cleanup-stage)))

;; staging area utilities

(defun edict-update-setup-stage ()
  "Determine staging directory, and create it if needed."

  ;; #### do proper temporary creation
  (or edict-update-local-mirror
      (if (file-exists-p edict-update-staging)
	  (error "%s exists, move it out of the way, please"
		 edict-update-staging)
	(make-directory edict-update-staging t)
	edict-update-staging)))

(defun edict-update-cleanup-stage ()
  "Clean up downloaded files and remove temporary staging area."

  (unless edict-update-local-mirror
    (remove-directory edict-update-staging)))

(provide 'edict-update)

;;; edict-update.el ends here
