@ECHO off

:: Set your list of source and target folders, 
:: per each tuple (src,trg) you will need a robocopy command below
SET SRC1=G:\
SET TRG1=E:\Backups\gianluca-win7\GL
:: Cygwin folder
SET SRC2=C:\cygwin64\home
SET TRG2=E:\Backups\gianluca-win7\Cygwin_Home
:: Outlook Data File 
SET SRC3=C:\Users\gbiccari\AppData\Local\Microsoft\Outlook
SET TRG3=E:\Backups\gianluca-win7\GL\Docs\email\outlook

:: Log file name, no need to be changed
SET BATCH_LOG=run_backup.log

:: Prompt an overview
echo -----------------------------------------------------------------------------
echo - Backup script is ready to run:                                            -
echo -----------------------------------------------------------------------------
echo - SOURCE DIR: %SRC1%, %SRC2%, %SRC3%
echo - TARGET DIR: %TRG1%, %TRG2%, %TRG3%
echo - LOG FILE: %BATCH_LOG%
echo -----------------------------------------------------------------------------
echo Press a key to run the backup of your source folders into the target folders
pause 

date /T
time /T

:: Robocopy command per each tuple (SRC,TRG). 
:: Use option /XD to exclude some folders if you don't want to backup them. 
robocopy %SRC1% %TRG1% /S /COPY:DAT /DCOPY:T /MIR /TEE /R:5 /NP /LOG+:%BATCH_LOG% /XD G:\Dropbox G:\Shared G:\Tmp "G:\$RECYCLE.BIN" "G:\System Volume Information"
robocopy %SRC2% %TRG2% /S /COPY:DAT /DCOPY:T /MIR /TEE /R:5 /NP /LOG+:%BATCH_LOG%
robocopy %SRC3% %TRG3% gbiccari.ost /S /COPY:DAT /DCOPY:T /MIR /TEE /R:5 /NP

:: To fix the fact that robocopy makes the destination folder hidden, you need to run this:
attrib -h -s %TRG1% 

echo Backup completed successfully
echo Log file: %BATCH_LOG%
time /T

pause 