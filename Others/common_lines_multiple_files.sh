#!/bin/bash    

intersect() { f="$1"; if shift; then grep -Fxf "$f" | intersect "$@"; else cat; fi; }
common() { f="$1"; shift; intersect "$@" < "$f"; }
common *