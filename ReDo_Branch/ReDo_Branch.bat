@echo off 
cd c:\
cd \ReDo_Branch
cls
:: 作者： namejm  出自：cn-dos 
:: 求N天前的日期 
:: 日期可以帶星期，但是，必須以年月日的順序排列 
:: 年份必須是四位，否則會出錯 
::EQU - 等於 
::NEQ - 不等於 
::LSS - 小於 
::LEQ - 小於或等於 
::GTR - 大於 
::GEQ - 大於或等於
::  forfiles /p "查找目錄" /M "*server.log*" /C "cmd /c del @path" /D -1  

:Main 
IF (%1)==() GOTO END
cls 
set day=%date% 
set days=0 
echo.&echo. 
echo       當前日期是：%day% 
::echo.&set /p input=      請指定要追溯的天數： 
setlocal enabledelayedexpansion 
:: 提取日期 
for /f "tokens=1-3 delims=-/. " %%i in ("%day%") do ( 
    set /a sy=%%i, sm=100%%j %% 100, sd=100%%k %% 100 
) 
set  input=%1

set /a sd-=input 
if %sd% leq 0 call :count 
:: sd <=0  call :count
cls&echo.&echo. 
echo       當前日期是：%day% 
echo. 
IF %sm% LSS 10 SET sm=0%sm% 
::set sm=%sm% 
IF %sd% LSS 10 SET sd=0%sd% 
::set sd=%sd% 
set /a chgdate=%sy%%sm:~0,2%%sd:~0,2%
::echo       %input% 天前的日期是：[%sy%%sm:~0,2%%sd:~0,2%]
echo       %input% 天前的日期是：[%chgdate%]
echo -
echo ~ ~ ~ ~ ~ 日期有錯時,請按Ctrl + C 中斷程式執行 ~ ~ ~ ~ ~
echo -
pause
echo --------------------[%1]------------------------
echo ------------------------------------------------0(Today)
if %1==0 goto :day0
echo ------------------------------------------------1
if %1==1 goto :day1
echo ------------------------------------------------2
if %1==2 goto :day2
echo ------------------------------------------------3
if %1==3 goto :day3
echo ------------------------------------------------4
if %1==4 goto :day4
echo ------------------------------------------------5
if %1==5 goto :day5
echo ------------------------------------------------6
if %1==6 goto :day6
echo ------------------------------------------------7
if %1==7 goto :day7
echo ------------------------------------------------Other
Echo ~ ~ ~ ~ ~ ~ ~ Date is Fail       ~ ~ ~ ~ ~ ~ ~
Echo ~ ~ ~ ~ ~ ~ ~ Please ReDo Branch ~ ~ ~ ~ ~ ~ ~
echo ------------------------------------------------End
::set  BKFL="c:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Backup\*_backup_%chgdate%*.bak"
::echo BKFL=%BKFL%
::DEL %BKFL%
::        pause>nul 
::goto Main 
goto :eof

:count 
set /a sm-=1 
if %sm% equ 0 set /a sm=12, sy-=1 

call :days 
set /a sd+=days 
if %sd% leq 0 goto count 
goto :eof 

:days 
:: 獲取指定月份的總天數 
set /a leap="^!(sy %% 4) & ^!(^!(sy %% 100)) | ^!(sy %% 400)" 
        ::echo call days  leap : %leap%
set /a max=28+leap 
        :: echo call days  max : %max%
for /f "tokens=%sm%" %%i in ("31 %max% 31 30 31 30 31 31 30 31 30 31") do set days=%%i 
goto :eof


:day0
echo "day0: " %1
del c:\temp\branch.txt
dtexec /f Export_Branch_Day-0.dtsx
dir c:\temp\branch.txt
pause
notepad c:\temp\branch.txt
goto :eof

:day1
echo "day1: " %1
del c:\temp\branch.txt
dtexec /f Export_Branch_Day-1.dtsx
dir c:\temp\branch.txt
pause
notepad c:\temp\branch.txt
goto :eof

:day2
echo "day2: " %1
del c:\temp\branch.txt
dtexec /f Export_Branch_Day-2.dtsx
dir c:\temp\branch.txt
pause
notepad c:\temp\branch.txt
goto :eof

:day3
echo "day3: " %1
del c:\temp\branch.txt
dtexec /f Export_Branch_Day-3.dtsx
dir c:\temp\branch.txt
pause
notepad c:\temp\branch.txt
goto :eof

:day4
echo "day4: " %1
del c:\temp\branch.txt
dtexec /f Export_Branch_Day-4.dtsx
dir c:\temp\branch.txt
pause
notepad c:\temp\branch.txt
goto :eof

:day5
echo "day5: " %1
del c:\temp\branch.txt
dtexec /f Export_Branch_Day-5.dtsx
dir c:\temp\branch.txt
pause
notepad c:\temp\branch.txt
goto :eof

:day6
echo "day6: " %1
del c:\temp\branch.txt
dtexec /f Export_Branch_Day-6.dtsx
dir c:\temp\branch.txt
pause
notepad c:\temp\branch.txt
goto :eof

:day7
echo "day7: " %1
del c:\temp\branch.txt
dtexec /f Export_Branch_Day-7.dtsx
dir c:\temp\branch.txt
pause
notepad c:\temp\branch.txt
goto :eof


:END
 @echo ----------------------------------------------
 @echo -syntax:
 @echo -command:  ReDo_Branch BeforeDAYNumber
 @echo -   EX  :  ReDo_Branch 3 (重新匯出 3 天前資料)
 @echo ----------------------------------------------
:eend
