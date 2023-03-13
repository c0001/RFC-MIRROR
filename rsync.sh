#!/usr/bin/env bash
set -e
# rsync service provided by https://www.rfc-editor.org/retrieve/rsync/
#
# Where module supported as follow rules:
# Module Names    Comments
# -------------------------------------------------------------------------------------
# everything-ftp    Everything FTP
# rfcs              Contents of in-notes/ and subdirectories bcp/, fyi/, ien/, and std/
# rfcs-text-only    Text files from [rfcs]
# rfc-ed-all        Entire repository (excluding Internet-Drafts)
# internet-drafts   Internet-Drafts
# ids-text-only     Text files from the Internet-Drafts mirror
# rfcs-pdf-only     PDF versions of ASCII RFCs to ensure correct page breaks, etc.
# refs              XML references for RFCs (for use with xml2rfc)
# rfcs-exclude-json Contents of [rfcs] excluding JSON files
# rfcs-json-only    Only the JSON files from the directories in [rfcs]

# (The --delete option is useful for removing local copies of files
# that have been deleted from the repository. This is helpful to
# remove expired Internet-Drafts.)
rsync -avz --delete ftp.rfc-editor.org::everything-ftp ./rsync
