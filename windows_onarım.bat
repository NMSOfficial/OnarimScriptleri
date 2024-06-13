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
chkdsk C: /f /r
echo CHKDSK taraması tamamlandı.

:: Sistem Geri Yükleme noktasını kontrol etme
echo Sistem Geri Yükleme noktaları kontrol ediliyor...
rstrui.exe
echo Sistem Geri Yükleme işlemi tamamlandı.

:: Kullanıcıya bilgi verme
echo Tüm onarımlar tamamlandı. Bilgisayarınızı yeniden başlatmanız önerilir.
pause

:: BAT dosyasını sonlandırma
exit
