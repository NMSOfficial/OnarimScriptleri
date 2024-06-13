#!/bin/bash

# Script başlığı
echo "Linux Sorun Giderici ve Onarım Aracı"

# Yönetici haklarıyla çalıştığından emin olma
if [ "$EUID" -ne 0 ]
  then echo "Lütfen bu scripti root olarak çalıştırın."
  exit
fi

# Kullanıcıya bilgi verme
echo "Sistem dosyalarını onarıyor..."
echo "Lütfen bekleyin, bu işlem biraz zaman alabilir..."

# Paket listelerini güncelleme ve yükseltme
echo "Paket listeleri güncelleniyor..."
apt update
echo "Paketler yükseltiliyor..."
apt upgrade -y
echo "Paket güncelleme işlemi tamamlandı."

# Sistemdeki kırık paketleri düzeltme
echo "Kırık paketler kontrol ediliyor ve düzeltiliyor..."
apt --fix-broken install -y
echo "Kırık paketler düzeltildi."

# Dosya sistemini kontrol etme ve onarma
echo "Dosya sistemi kontrol ediliyor..."
fsck -A -y
echo "Dosya sistemi kontrolü tamamlandı."

# Disk kullanımını kontrol etme
echo "Disk kullanımı kontrol ediliyor..."
df -h
echo "Disk kullanımı kontrolü tamamlandı."

# Log dosyalarını temizleme
echo "Eski log dosyaları temizleniyor..."
journalctl --vacuum-time=2weeks
echo "Log dosyaları temizlendi."

# Sistem yeniden başlatma önerisi
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
