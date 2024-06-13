#!/bin/bash

# Script başlığı
echo "MacOS Sorun Giderici ve Onarım Aracı"

# Yönetici haklarıyla çalıştığından emin olma
if [ "$EUID" -ne 0 ]
  then echo "Lütfen bu scripti root olarak çalıştırın."
  exit
fi

# Kullanıcıya bilgi verme
echo "Sistem dosyalarını onarıyor..."
echo "Lütfen bekleyin, bu işlem biraz zaman alabilir..."

# Yazılım güncellemelerini kontrol etme ve yükleme
echo "Yazılım güncellemeleri kontrol ediliyor..."
softwareupdate -l
echo "Yazılım güncellemeleri yükleniyor..."
softwareupdate -ia --verbose
echo "Yazılım güncelleme işlemi tamamlandı."

# Disk izinlerini onarma (macOS Sierra ve sonrası için geçerli değil)
echo "Disk izinleri onarılıyor (macOS Sierra ve sonrası için gerekli değil)..."
diskutil repairPermissions /
echo "Disk izinleri onarımı tamamlandı."

# Dosya sistemini kontrol etme ve onarma
echo "Dosya sistemi kontrol ediliyor ve onarılıyor..."
diskutil verifyVolume /
diskutil repairVolume /
echo "Dosya sistemi kontrolü ve onarımı tamamlandı."

# Kötü amaçlı yazılım taraması (Malware Removal Tool ile)
echo "Kötü amaçlı yazılım taraması yapılıyor..."
/usr/libexec/MRT
echo "Kötü amaçlı yazılım taraması tamamlandı."

# Kullanıcıya bilgi verme
echo "Tüm onarımlar tamamlandı. Bilgisayarınızı yeniden başlatmanız önerilir."
read -p "Şimdi yeniden başlatmak ister misiniz? (e/h): " -n 1 -r
echo
if [[ $REPLY =~ ^[Ee]$ ]]
then
    echo "Sistem yeniden başlatılıyor..."
    reboot
else
    echo "Sistem yeniden başlatılmadı."
fi

# Script sonlandırma
echo "Script tamamlandı."
exit 0
