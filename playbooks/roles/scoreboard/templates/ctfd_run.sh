if pgrep -x "screen" > /dev/null
then
  exit 0
else
  screen -d -m docker run -p 8000:8000 -it ctfd/ctfd
fi