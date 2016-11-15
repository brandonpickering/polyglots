#!/usr/bin/env bash

FILENAME=$1
if [ "$FILENAME" = '' ]; then
    echo 'Missing filename'
    exit 1
fi

LANGUAGE=$2
if [ "$LANGUAGE" = '' ]; then LANGUAGE=all; fi

if [ "$LANGUAGE" = 'c' ] || [ "$LANGUAGE" = 'all' ]; then
    echo 'c'
    gcc -pedantic -ansi -o build_c -x c "$FILENAME" && ./build_c
    rm -f build_c
    echo
fi

if [ "$LANGUAGE" = 'c++' ] || [ "$LANGUAGE" = 'all' ]; then
    echo 'c++'
    g++ -pedantic -ansi -o build_cpp -x c "$FILENAME" && ./build_cpp
    rm -f build_cpp
    echo
fi

if [ "$LANGUAGE" = 'haskell' ] || [ "$LANGUAGE" = 'all' ]; then
    echo 'haskell'
    cp "$FILENAME" "$FILENAME.hs"
    ghc -v0 -o build_hs "$FILENAME.hs" && ./build_hs
    rm -f build_hs "$FILENAME.hs"
    rm -f *.hi *.o
    echo
fi

if [ "$LANGUAGE" = 'nim' ] || [ "$LANGUAGE" = 'all' ]; then
    echo 'nim'
    cp "$FILENAME" build_nim.nim
    nim c --verbosity:0 --hints:off -r build_nim
    rm -f build_nim build_nim.nim
    rm -rf nimcache
    echo
fi

for LANG in 'python2' 'python3' 'ruby' 'bash'; do
    if [ "$LANGUAGE" = "$LANG" ] || [ "$LANGUAGE" = 'all' ]; then
        echo "$LANG"
        "$LANG" "$FILENAME"
        echo
    fi
done
