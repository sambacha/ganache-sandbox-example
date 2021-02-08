set -e # exit when any command fails

mkdir db
ganache-cli -d --db db -i 50 -l 10000000 &
PID=$!

gsc-run config.json addresses.json

# stop ganache
kill $PID