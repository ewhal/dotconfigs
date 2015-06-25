#!/bin/bash

if [[ $1 = ""  ]]; then
    echo "Please run with website name"
    exit 1
fi
echo "mkdir "$1""
mkdir "$1"

echo "cd "$1""
cd "$1"

echo "openssl genrsa -des3 -out "$1"_secure.key 4096"
openssl genrsa -des3 -out "$1"_secure.key 4096

echo "openssl req -new -sha256 -key "$1"_secure.key -out "$1".csr"
openssl req -new -sha256 -key "$1"_secure.key -out "$1".csr

echo "openssl rsa -in "$1"_secure.key -out "$1".key"
openssl rsa -in "$1"_secure.key -out "$1".key
if [[ -f sub.class1.server.sha2.ca.pem ]];then
    echo "Please dowload the signed cert then run this command"
    echo "cat "$1".pem sub.class1.server.sha2.ca.pem > "$1"_chain.pem"
else
    wget https://www.startssl.com/certs/class1/sha2/pem/sub.class1.server.sha2.ca.pem
fi


