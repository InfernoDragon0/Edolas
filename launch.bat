@echo off
@title Edolas v175
Color 0C
set CLASSPATH=.;dist\*
java -client -Dwzpath=wz server.Start
pause