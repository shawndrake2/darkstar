@ECHO OFF
REM =============================================================================
REM =============================================================================
REM ======                                                              =========
REM ====== THis script will drop the DB specificed, then create the DB  =========
REM ====== specified, and then load all .sql tables from its run dir to =========
REM ====== the the DB.                                                  =========
REM ======                                                              =========
REM ====== File needs to be run from within the \dsp\sql folder (same   =========
REM ====== folder with all the .sql files. Please edit as needed. By    =========
REM ====== default it WILL DROP the standard dspdb DB, losing all      =========
REM ====== accounts and characters. If this is not desired, then update =========
REM ====== the file to load the new DB into a new DB name.              =========
REM ======                                                              =========
REM ====== Update -p with MySQL password. If you password is 'foo',     =========
REM ====== then change '-pMYSQLPASS' to '-pfoo' (3 places).             =========
REM ======                                                              =========
REM ====== If you want to use a different database name, change 'dspdb' =========
REM ====== with a database name of your choosing.                       =========
REM ======                                                              =========
REM =============================================================================
REM =============================================================================
REM ======                                                              =========
REM ====== by Thrydwolf 9/8/2012                                        =========
REM ====== Updated with status by bluekirby0 3/30/2012                  =========
REM ====== Updated by Thrydwolf 9/18/2012                               =========
REM ======                                                              =========
REM =============================================================================
REM =============================================================================

SET MYSQL="C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -proot

ECHO Creating Database dspdb
%MYSQL% -e "DROP DATABASE IF EXISTS dspdb"

ECHO Creating Database dspdb
%MYSQL% -e "CREATE DATABASE IF NOT EXISTS dspdb"

ECHO Loading dspdb tables into the database
cd "C:\Users\drake\workspace\darkstar\sql"
FOR %%X IN (*.sql) DO ECHO Importing %%X & %MYSQL% dspdb < %%X

ECHO Finished!
