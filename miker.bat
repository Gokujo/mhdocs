@echo off

set version=%1

echo mike deploy --push --update-aliases %version% latest
echo mike set-default --push latest