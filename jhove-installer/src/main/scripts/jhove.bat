@ECHO OFF
REM JHOVE - JSTOR/Harvard Object Validation Environment
REM Copyright 2003-2005 by JSTOR and the President and Fellows of Harvard College
REM JHOVE is made available under the GNU General Public License (see the
REM file LICENSE for details)
REM
REM Usage: jhove [-c config] [-m module] [-h handler] [-e encoding]
REM              [-H handler] [-o output] [-x saxclass] [-t tempdir]
REM              [-b bufsize] [-l loglevel] [[-krs] dir-file-or-uri [...]]
REM
REM For Windows systems, copy jhove_bat.tmpl to jhove.bat and change
REM the value of JHOVE_HOME to the path to your jhove directory.
REM
REM where -c config   Configuration file pathname
REM       -m module   Module name
REM       -h handler  Output handler name (defaults to TEXT)
REM       -e encoding Character encoding of output handler (defaults to UTF-8)
REM       -H handler  About handler name
REM       -o output   Output file pathname (defaults to standard output)
REM       -x saxclass SAX parser class (defaults to J2SE 1.4 default)
REM       -t tempdir  Temporary directory in which to create temporary files
REM       -b bufsize  Buffer size for buffered I/O (defaults to J2SE default)
REM       -l loglevel Logging level
REM       -k          Calculate CRC32, MD5, and SHA-1 checksums
REM       -r          Display raw data flags, not textual equivalents
REM       -s          Format identification based on internal signatures only
REM       dir-file-or-uri Directory, file pathname, or URI of formatted content
REM
REM Configuration constants:
REM JHOVE_HOME Jhove installation directory
REM JAVA_HOME  Java JRE directory
REM JAVA       Java interpreter
REM EXTRA_JARS Extra jar files to add to CLASSPATH

REM SET JHOVE_HOME="C:\Program Files\jhove"

REM *************************************************************************
REM The $INSTALL_PATH variable is substituted by the izpack installer at
REM install time.
REM *************************************************************************
SET JHOVE_HOME="$INSTALL_PATH"
SET JHOVE_VERSION="$APP_VER"
SET EXTRA_JARS=

REM NOTE: Nothing below this line should be edited
REM #########################################################################


SET CP=%JHOVE_HOME%\bin\jhove-apps-%JHOVE_VERSION%.jar
IF "%EXTRA_JARS%"=="" GOTO FI
  SET CP=%CP%:%EXTRA_JARS
:FI

REM Retrieve a copy of all command line arguments to pass to the application

SET ARGS=-c %JHOVE_HOME%\conf\jhove.conf
:WHILE
IF "%1"=="" GOTO LOOP
  SET ARGS=%ARGS% %1
  SHIFT
  GOTO WHILE
:LOOP

REM Set the CLASSPATH and invoke the Java loader
JAVA -classpath %CP% Jhove %ARGS%
