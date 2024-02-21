@echo off
setlocal

:: Script'in bulunduğu dizini al
set "SCRIPT_DIR=%~dp0"

:: Hedef build dizini
set "BUILD_DIR=%SCRIPT_DIR%build"

:: Zip dosyasının adı
set "ZIP_FILE=libzippp-v7.0-1.10.1-windows-ready_to_compile.zip"

:: Build dizinini oluştur
if not exist "%BUILD_DIR%" mkdir "%BUILD_DIR%"

:: Zip dosyasını build dizinine çıkart
echo Zip dosyası çıkartılıyor: %ZIP_FILE% to %BUILD_DIR%
"C:\Program Files\7-Zip\7z.exe" x "%SCRIPT_DIR%\%ZIP_FILE%" -o"%BUILD_DIR%"

:: Çıkartma işlemi kontrolü
if errorlevel 1 (
    echo Zip çıkartma işlemi başarısız oldu.
    goto cleanup
) else (
    echo Zip başarıyla çıkartıldı.
)

:: Çalışma dizinini compile.bat'in bulunduğu dizine değiştir
cd /d "%BUILD_DIR%"

:: compile.bat dosyasını çalıştır
echo compile.bat dosyası çalıştırılıyor...
call "compile.bat"

:: Compile işlemi kontrolü
if errorlevel 1 (
    echo Compile işlemi başarısız oldu.
) else (
    echo Compile işlemi başarıyla tamamlandı.
)

:: Çalışma dizinini orijinal haline getir
cd /d "%SCRIPT_DIR%"

:cleanup
:: Build dizinini sil
echo Build dizini temizleniyor...
rmdir /s /q "%BUILD_DIR%"

echo İşlem tamamlandı.
:end
endlocal
