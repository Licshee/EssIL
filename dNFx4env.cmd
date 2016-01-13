@echo off
pushd %windir%\Microsoft.NET\Framework\v4.0.*
path %path%;%cd%
popd