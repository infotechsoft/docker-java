#!/usr/bin/env sh

USAGE="Usage: apache_install <path-to-archive> <path-to-keys>"

# Attempt to download Apache project from mirror, otherwise fallback to Apache archive. places 
# downloaded file in the `/tmp` directory
#
# Arguments:
#   URL path to project archive
apache_dl() {
    DL_URL="https://dlcdn.apache.org/$1"
    APACHE_FN=$(basename "$1")
    if ! curl -fSL "$DL_URL" -o /tmp/"$APACHE_FN"; then
        # Not in mirror, download from archive
        curl -fSL "https://archive.apache.org/dist/$1" -o /tmp/"$APACHE_FN"
        SIG_URL=https://archive.apache.org/dist/"$1".asc
    else
        # Downloaded from mirror, grab keys from release repo
        SIG_URL="https://dist.apache.org/repos/dist/release/$1.asc"
    fi
    curl -fSL "$SIG_URL" -o "/tmp/$APACHE_FN.asc"
    echo "/tmp/$APACHE_FN"
}

# Verifies Apache signature using package keys
#
# Arguments:
#   Path to package to verify, signature should be in same path with .asc appended to name
#   URL path to KEYS file for Apache project
apache_verify() {
    mkdir /tmp/gpg
    curl -fSL "https://dist.apache.org/repos/dist/release/$2" -o /tmp/KEYS
    gpg --homedir /tmp/gpg --no-default-keyring --keyring /tmp/gpg/keys.gpg --import /tmp/KEYS
    if gpgv --keyring /tmp/gpg/keys.gpg "$1.asc" "$1"; then
        rm -rf /tmp/gpg /tmp/KEYS
        return 0
    else
        echo "Validation of signature failed for $1"
        return 1
    fi
}

# Downloads and installs Apache project in `/opt` directory.
#
# Arguments:
#   URL path to Apache project archive to download
#   URL path to KEYS file for Apache project
apache_install() {
    APACHE_FN=$(apache_dl "$1")
    if apache_verify "$APACHE_FN" "$2"; then
        tar -xf "$APACHE_FN" -C /opt/
        rm -rf "$APACHE_FN"*
        return 0
    else
        echo "Install failed: $1"
        return 1
    fi
}

if ! command -v curl >/dev/null 2>&1; then
  echo "Curl is required but not installed."
  exit 1
fi

if ! command -v gpg >/dev/null 2>&1; then
  echo "GNUPG is required but not installed."
  exit 1
fi

if [ "$#" -ne 2 ]; then
  echo "$USAGE"
  exit 1
fi

apache_install "$1" "$2"
