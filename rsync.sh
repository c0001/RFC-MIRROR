#!/usr/bin/env bash
set -e

_msg ()
{
    printf "$@" >&2
}

_date_show ()
{
    date -u +"%Y%m%d%H%M%S"
}

_cmd_exec ()
{
    # show commands
    local command="$1"
    local -a args=("${@:2}")
    local _date="$(trap '' SIGINT; _date_show)"
    _msg "\e[33m%s\e[0m [\e[33m%s\e[0m]: " "[${_date}]" "SHOW"
    _msg "\e[1m%s\e[0m" "${command}"
    local item
    local count=1
    for item in "${args[@]}"
    do
        _msg " \e[34m%s\e[0m:\e[4m%s\e[0m" "[$count]" "${item}"
        let count++ ; : ;
    done
    _msg '\n'
    # run commands
    "$@"
}

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
_cmd_exec rsync -avz --delete ftp.rfc-editor.org::everything-ftp ./rsync
