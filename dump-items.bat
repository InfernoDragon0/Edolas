@echo off
@title Dump Items
set CLASSPATH=.;dist\*
java -Dwzpath=wz\ tools.wztosql.DumpItems
pause