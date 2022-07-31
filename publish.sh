#!/bin/sh

gitbook build
cp -R _book/* .
git clean -fx _book
git add .
git commit -m "docs update"
git push origin main
