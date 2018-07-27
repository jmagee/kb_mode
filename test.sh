#!/bin/sh

match() {
  if [ "$1" == "$2" ]; then
    echo "Pass: $1 == $2"
  else
    echo "Fail: $1 != $2"
    exit 1
  fi
}

echo "Layer: base" | ./kb_mode test_output.txt 2> /dev/null
match $(cat test_output.txt) "base"

echo "Layer: numpad" | ./kb_mode test_output.txt 2> /dev/null
match $(cat test_output.txt) "numpad"

echo "Layer: symbols" | ./kb_mode test_output.txt 2> /dev/null
match $(cat test_output.txt) "symbols"

echo "Layer: navi" | ./kb_mode test_output.txt 2> /dev/null
match $(cat test_output.txt) "navi"

echo "Layer: mouser" | ./kb_mode test_output.txt 2> /dev/null
match $(cat test_output.txt) "mouser"

echo "Layer: albhed" | ./kb_mode test_output.txt 2> /dev/null
match $(cat test_output.txt) "albhed"

echo -e "Layer: base\nLayer: mouser" | ./kb_mode test_output.txt 2> /dev/null
match $(cat test_output.txt) "mouser"
