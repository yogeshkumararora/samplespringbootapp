#!/bin/bash

# Stop on error
set -e

main() {
    decryptAndImportPrivateKeys
}

# From gist - https://gist.github.com/Bost/54291d824149f0c4157b40329fceb02c
tstp() {
    date +"%Y-%m-%d %H:%M:%S,%3N"
}
# From gist - https://gist.github.com/Bost/54291d824149f0c4157b40329fceb02c
exeinf() {
    echo "INFO " $(tstp) "$ "$@
}
# From gist - https://gist.github.com/Bost/54291d824149f0c4157b40329fceb02c
exeerr() {
    echo "ERROR" $(tstp) "$ "$@
}

decryptAndImportPrivateKeys() {
    exeinf "Unzipping archive"
    unzip -o .travis/secret-private-key.zip
    exeinf "Extracting private gpg key"
    openssl aes-256-cbc -d -in .travis/secret-private-key -out .travis/gpg-private-key.asc -k "${PRIVATE_KEY}"
    exeinf "Importing gpg key"
    gpg --import .travis/gpg-private-key.asc
    exeinf "List Keys"
    gpg --list-secret-keys
    gpg --list-public-keys
}

main "$@"