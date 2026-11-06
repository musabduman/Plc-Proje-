@echo off
setlocal
set "PATH=C:\msys64\usr\bin;C:\msys64\ucrt64\bin;%PATH%"

echo [1/3] Bison calistiriliyor (mpl.y -^> y.tab.c, y.tab.h)...
bison -d -y mpl.y
if %ERRORLEVEL% NEQ 0 (
    echo Hata: Bison calisirken bir sorun olustu!
    exit /b %ERRORLEVEL%
)

echo [2/3] Flex calistiriliyor (mpl.l -^> lex.yy.c)...
flex mpl.l
if %ERRORLEVEL% NEQ 0 (
    echo Hata: Flex calisirken bir sorun olustu!
    exit /b %ERRORLEVEL%
)

echo [3/3] GCC ile derleniyor (y.tab.c + lex.yy.c -^> mpl.exe)...
gcc y.tab.c lex.yy.c -o mpl.exe
if %ERRORLEVEL% NEQ 0 (
    echo Hata: GCC derleme hatasi!
    exit /b %ERRORLEVEL%
)

echo.
echo ==============================================
echo  TEBRIKLER! mpl.exe basariyla olusturuldu.
echo ==============================================
