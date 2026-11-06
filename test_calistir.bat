@echo off
setlocal

echo =========================================================
echo             MPL DILI OTOMATIK TEST BASLATIYOR
echo =========================================================
echo.

echo [TEST 1] Gecerli program test ediliyor (ornek_gecerli.mpl):
.\mpl.exe < ornek_gecerli.mpl
if %ERRORLEVEL% EQU 0 (
    echo   --^> SONUC: BASARILI [Gecerli program dogrulandi: OK]
) else (
    echo   --^> SONUC: BASARISIZ
)

echo.
echo ---------------------------------------------------------
echo.

echo [TEST 2] Gecersiz program test ediliyor (ornek_gecersiz.mpl):
.\mpl.exe < ornek_gecersiz.mpl
if %ERRORLEVEL% NEQ 0 (
    echo   --^> SONUC: BASARILI [Beklendigi gibi hata yakalandi]
) else (
    echo   --^> SONUC: BASARISIZ [Hata yakalanamadi]
)

echo.
echo ---------------------------------------------------------
echo.

echo [TEST 3] Gecersiz program 2 test ediliyor (ornek_gecersiz2.mpl):
.\mpl.exe < ornek_gecersiz2.mpl
if %ERRORLEVEL% NEQ 0 (
    echo   --^> SONUC: BASARILI [Beklendigi gibi hata yakalandi]
) else (
    echo   --^> SONUC: BASARISIZ [Hata yakalanamadi]
)

echo.
echo =========================================================
pause
