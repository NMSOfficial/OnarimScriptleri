@echo off
:: BAT dosyasının başlığı
title Windows Sorun Giderici ve Onarım Aracı

:: Yönetici haklarıyla çalıştığından emin ol
echo Yönetici haklarıyla çalıştığınızdan emin olun...

:: Kullanıcıya bilgi verme
echo Windows sistem dosyalarını onarıyor...
echo Lütfen bekleyin, bu işlem biraz zaman alabilir...

:: Sistem dosyası denetleyicisi (SFC) çalıştırma
echo Sistem Dosyası Denetleyicisi (SFC) çalıştırılıyor...
sfc /scannow
echo SFC taraması tamamlandı.

:: Dağıtım Görüntüsü Hizmeti ve Yönetimi Aracı (DISM) ile onarım
echo DISM aracı ile onarım yapılıyor...
DISM /Online /Cleanup-Image /CheckHealth
DISM /Online /Cleanup-Image /ScanHealth
DISM /Online /Cleanup-Image /RestoreHealth
echo DISM onarımı tamamlandı.

:: Windows Update bileşenlerini sıfırlama
echo Windows Update bileşenleri sıfırlanıyor...
net stop wuauserv
net stop cryptSvc
net stop bits
net stop msiserver
ren C:\Windows\SoftwareDistribution SoftwareDistribution.old
ren C:\Windows\System32\catroot2 catroot2.old
net start wuauserv
net start cryptSvc
net start bits
net start msiserver
echo Windows Update bileşenleri sıfırlama işlemi tamamlandı.

:: Disk kontrolü (CHKDSK) çalıştırma
echo Disk kontrolü (CHKDSK) yapılıyor...
chkdsk C: > chkdsk_result.txt
find /i "Windows has scanned the file system and found no problems" chkdsk_result.txt > nul
if %errorlevel%==0 (
    echo CHKDSK taraması tamamlandı, herhangi bir sorun bulunamadı.
) else (
    echo CHKDSK sorunlar tespit etti. Onarmak ister misiniz? (E/H)
    set /p user_input=
    if /i "%user_input%"=="E" (
        echo CHKDSK onarım işlemi başlatılıyor. Bilgisayar yeniden başlatıldığında bu işlem tamamlanacaktır.
        echo Y|chkdsk C: /f /r
        echo Bilgisayarı yeniden başlatmak istiyor musunuz? (E/H)
        set /p restart_input=
        if /i "%restart_input%"=="E" (
            echo Bilgisayar yeniden başlatılıyor...
            shutdown /r /t 0
        ) else (
            echo Bilgisayarı daha sonra yeniden başlatabilirsiniz. Onarım işlemi yeniden başlatıldığında tamamlanacaktır.
        )
    ) else (
        echo CHKDSK onarım işlemi iptal edildi.
    )
)
del chkdsk_result.txt

:: Sistem Geri Yükleme noktasını kontrol etme
echo Sistem Geri Yükleme noktaları kontrol ediliyor...
rstrui.exe
echo Sistem Geri Yükleme işlemi tamamlandı.

:: Kullanıcıya bilgi verme
echo Tüm onarımlar tamamlandı. Bilgisayarınızı yeniden başlatmanız önerilir.
pause

:: BAT dosyasını sonlandırma
exit
