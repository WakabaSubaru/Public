:@echo off

SET SourceDir=%~dp0
IF %SourceDir:~-1%==\ (
	SET SourceDir=%SourceDir:~0,-1%
)

"%SourceDir%\AdobeAcroCleaner_DC2021.exe" /silent /product=0 /cleanlevel=1 /scanforothers=1

"%SourceDir%\AdobeAcroCleaner_DC2021.exe" /silent /product=1 /cleanlevel=1 /scanforothers=1

"%SourceDir%\AdobeAcroCleaner_DC2015.exe" /silent /product=0 /cleanlevel=1 /scanforothers=1

"%SourceDir%\AdobeAcroCleaner_DC2015.exe" /silent /product=1 /cleanlevel=1 /scanforothers=1