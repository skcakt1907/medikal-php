============================================================
MEDİKAL / KLİNİK TEMASI — KURUMSAL WEB SİTESİ
PHP + MySQL + Bootstrap 5   (Demo marka: Vita Klinik)
============================================================

KURULUM (yerel WAMP / canlı sunucu)
------------------------------------------------------------
1. Dosyaları sunucuya yükleyin
   - Tüm klasörü web kök dizinine kopyalayın (örn: public_html/)

2. Veritabanı oluşturun
   - cPanel / phpMyAdmin'de yeni bir DB oluşturun (örn: medikal_db)
   - kurulum.sql dosyasını import edin
   - 7 tablo + örnek veriler otomatik yüklenir

3. Veritabanı bağlantı bilgilerini düzenleyin
   - inc/config.php dosyasını açın
   - DB_HOST, DB_NAME, DB_USER, DB_PASS değerlerini doldurun
   - SITE_URL değerini gerçek domaininizle değiştirin
     Örn: define('SITE_URL', 'https://klinikadi.com');
   - Canlı sunucuda DEBUG'i false yapın

4. uploads/ klasörüne yazma izni verin
   - chmod 755 uploads/    (Linux)
   - uploads/.htaccess PHP çalıştırmayı engelliyor (güvenlik)

5. Admin paneline giriş yapın
   - URL: https://siteniz.com/admin/
   - Kullanıcı: admin
   - Şifre:    admin123
   - !!! Giriş yaptıktan sonra şifrenizi MUTLAKA değiştirin !!!
     (phpMyAdmin'den admin tablosunda password_hash() ile yeniden hash'leyin)

------------------------------------------------------------
SEKTÖRE ÖZEL ETİKETLER
------------------------------------------------------------
Bu temada motor "kurumsal/hizmet" altyapısıdır; etiketler medikale
uyarlanmıştır:
  Hizmetler  → Tedavilerimiz (bölümler)
  Projeler   → Kliniğimiz (galeri)
  Blog       → Sağlık Rehberi
  Teklif Al  → Randevu Al (online randevu formu)
Admin panelindeki "Randevular" bölümü randevu taleplerini listeler.

------------------------------------------------------------
DOSYA YAPISI
------------------------------------------------------------
medikal-php/
├── index.php             Anasayfa
├── hakkimizda.php        Hakkımızda
├── hizmetler.php         Tedavi listesi
├── hizmet-detay.php      Tek tedavi sayfası (?slug=...)
├── projeler.php          Klinik galerisi (filtreli)
├── proje-detay.php       Tek galeri öğesi (?slug=...)
├── blog.php              Sağlık rehberi listesi
├── blog-detay.php        Tek yazı (?slug=...)
├── iletisim.php          İletişim formu + harita
├── teklif.php            Online randevu formu
│
├── inc/                  config, db, helpers, header, footer
├── admin/                Yönetim paneli (login, CRUD'lar, ayarlar)
├── css/style.css         Tema CSS (mavi/turkuaz palet)
├── js/main.js            Navbar scroll efekti
├── uploads/              Yüklenen görseller (PHP engelli)
└── kurulum.sql           DB şema + örnek veri

------------------------------------------------------------
TEKNİK DETAYLAR
------------------------------------------------------------
- PHP 7.4+ (önerilen 8.x)
- MySQL 5.7+ / MariaDB
- PDO prepared statements (SQL injection koruması)
- CSRF token (form güvenliği)
- password_hash() bcrypt (admin şifre)
- XSS koruması (e() htmlspecialchars)
- Bootstrap 5.3.2 + Bootstrap Icons 1.11 (CDN)
- Responsive (mobil uyumlu)

------------------------------------------------------------
RENK PALETİ
------------------------------------------------------------
Birincil  : #0ea5e9 (medikal mavi)
Vurgu     : #06b6d4 (turkuaz)
Koyu      : #0c2433 (lacivert)
Açık      : #f0f9ff (buz mavisi)
- css/style.css → :root değişkenlerinden değiştirebilirsiniz

------------------------------------------------------------
DESTEK / NOTLAR
------------------------------------------------------------
- Yerel test:   http://localhost/medikal-php/
- Admin:        /admin/  (admin / admin123)
- DB import:    phpMyAdmin → Import → kurulum.sql

İyi çalışmalar!
