-- ============================================
-- MEDİKAL / KLİNİK TEMASI — Kurulum SQL
-- (tema-master Kurumsal/Hizmet arketipinden türetildi)
-- Kullanım: phpMyAdmin > Import  (veya: mysql -u root < kurulum.sql)
-- ============================================
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

CREATE DATABASE IF NOT EXISTS `medikal_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `medikal_db`;

-- ============ AYARLAR ============
DROP TABLE IF EXISTS `ayarlar`;
CREATE TABLE `ayarlar` (
  `anahtar` VARCHAR(80) NOT NULL PRIMARY KEY,
  `deger` TEXT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `ayarlar` (`anahtar`,`deger`) VALUES
('site_adi','Vita Klinik'),
('site_baslik','Vita Klinik — Sağlığınız Bizim Önceliğimiz'),
('site_aciklama','Uzman hekim kadromuz ve modern tıbbi teknolojimizle, check-up''tan diş tedavilerine kadar tüm sağlık ihtiyaçlarınızda güvenilir çözüm sunuyoruz.'),
('telefon','+90 555 000 00 00'),
('telefon2','+90 532 000 00 00'),
('mail','info@vitaklinik.com'),
('adres','Sağlık Mah. Şifa Cad. No:12, Merkez / İstanbul'),
('calisma_saati','Pzt - Cmt: 08:30 - 19:30'),
('hakkimizda_kisa','Vita Klinik, alanında uzman hekim kadrosu ve son teknoloji tıbbi cihazlarıyla hastalarına güvenli, konforlu ve kişiye özel sağlık hizmeti sunan modern bir sağlık merkezidir.'),
('hakkimizda_uzun','Vita Klinik olarak, hastalarımızın sağlığını her şeyin üzerinde tutan bir anlayışla hizmet veriyoruz. Dahiliyeden kardiyolojiye, diş sağlığından fizik tedaviye uzanan geniş branş yelpazemizle tüm aileniz için tek çatı altında çözüm sunuyoruz. Modern görüntüleme merkezimiz, tam donanımlı laboratuvarımız ve steril muayene odalarımızla tanıdan tedaviye her aşamada uluslararası standartlarda hizmet alırsınız. Randevularınızı telefonla veya online olarak kolayca oluşturabilir, sonuçlarınıza hızla ulaşabilirsiniz. Güler yüzlü ekibimiz ve hasta odaklı yaklaşımımızla kendinizi evinizde hissedeceksiniz.'),
('misyon','Hastalarımıza etik değerlerden ödün vermeden, kanıta dayalı tıp ışığında, erişilebilir ve kaliteli sağlık hizmeti sunmak; tanıdan tedaviye her adımda hasta güvenliğini ve memnuniyetini önceliklendirmek.'),
('vizyon','Bölgesinde hasta memnuniyetinde öncü, tıbbi teknolojiyi yakından takip eden, güvenilirliğiyle referans gösterilen bir sağlık kuruluşu olmak.'),
('yil','15'),
('proje_sayi','50000'),
('musteri_sayi','12500'),
('personel_sayi','40'),
('facebook','#'),('instagram','#'),('twitter','#'),('linkedin','#'),('youtube','#');

-- ============ HİZMETLER (TEDAVİLER / BÖLÜMLER) ============
DROP TABLE IF EXISTS `hizmetler`;
CREATE TABLE `hizmetler` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `baslik` VARCHAR(150) NOT NULL,
  `slug` VARCHAR(180),
  `ozet` TEXT,
  `icerik` LONGTEXT,
  `ikon` VARCHAR(60) DEFAULT 'bi-heart-pulse',
  `gorsel` VARCHAR(255),
  `sira` INT DEFAULT 0,
  `durum` TINYINT DEFAULT 1,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `hizmetler` (`baslik`,`slug`,`ozet`,`icerik`,`ikon`,`gorsel`,`sira`) VALUES
('Genel Check-Up','genel-check-up','Yaşınıza ve risk faktörlerinize özel kapsamlı sağlık taramasıyla hastalıkları erken yakalayın.','Düzenli check-up, birçok hastalığın belirti vermeden erken evrede tespit edilmesini sağlar. Vita Klinik check-up paketleri; kan ve idrar tahlilleri, EKG, akciğer grafisi, batın ultrasonografisi ve uzman hekim muayenesini kapsar. Sonuçlarınız aynı gün içinde değerlendirilir ve size özel bir sağlık yol haritası çıkarılır. 40 yaş üstü bireylere yılda bir kapsamlı check-up öneriyoruz.','bi-clipboard2-pulse','https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=800&q=80',1),
('Dahiliye (İç Hastalıkları)','dahiliye','Tansiyondan diyabete, iç hastalıklarının tanı ve tedavisinde uzman hekim takibi.','Dahiliye bölümümüzde hipertansiyon, diyabet, tiroid hastalıkları, kolesterol yüksekliği, anemi ve sindirim sistemi rahatsızlıkları gibi geniş bir yelpazede tanı ve tedavi hizmeti veriyoruz. Kronik hastalık takibinde düzenli kontrol programları oluşturuyor, ilaç tedavinizi yaşam tarzı önerileriyle destekliyoruz.','bi-heart-pulse','https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=800&q=80',2),
('Kardiyoloji','kardiyoloji','EKG, ekokardiyografi ve efor testiyle kalp sağlığınız güvende.','Kardiyoloji bölümümüzde göğüs ağrısı, çarpıntı, nefes darlığı ve tansiyon şikayetlerinizde ileri tanı yöntemleri kullanıyoruz. EKG, ekokardiyografi, efor testi ve ritim holteri ile kalbinizin tüm fonksiyonlarını değerlendiriyor; koruyucu kardiyoloji yaklaşımıyla risk faktörlerinizi kontrol altına alıyoruz.','bi-activity','https://images.unsplash.com/photo-1628348068343-c6a848d2b6dd?w=800&q=80',3),
('Diş Sağlığı','dis-sagligi','Dolgudan implanta, estetik diş hekimliğinden ortodontiye tam kapsamlı ağız ve diş sağlığı.','Diş polikliniğimizde koruyucu hekimlik, dolgu, kanal tedavisi, diş eti tedavileri, implant, zirkonyum kaplama ve diş beyazlatma uygulamaları gerçekleştiriyoruz. Dijital röntgen ve ağrısız anestezi teknikleriyle konforlu bir tedavi süreci sunuyoruz. Çocuk diş hekimliği için ayrı ünitemiz mevcuttur.','bi-emoji-smile','https://images.unsplash.com/photo-1606811841689-23dfddce3e95?w=800&q=80',4),
('Dermatoloji & Estetik','dermatoloji-estetik','Cilt hastalıkları tedavisi ve medikal estetik uygulamalarında uzman dokunuş.','Dermatoloji bölümümüzde akne, egzama, sedef, saç dökülmesi ve cilt alerjilerinin tanı ve tedavisini yapıyoruz. Medikal estetik tarafında ise cilt gençleştirme, leke tedavisi, mezoterapi ve PRP uygulamalarını hekim kontrolünde, güvenle gerçekleştiriyoruz.','bi-droplet-half','https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?w=800&q=80',5),
('Fizik Tedavi & Rehabilitasyon','fizik-tedavi','Bel-boyun ağrılarından spor yaralanmalarına, kişiye özel rehabilitasyon programları.','Fizik tedavi ünitemizde bel ve boyun fıtığı, eklem ağrıları, spor yaralanmaları ve ameliyat sonrası rehabilitasyon süreçlerinde kişiye özel programlar uyguluyoruz. Fizyoterapistlerimiz eşliğinde manuel terapi, elektroterapi ve egzersiz tedavileriyle hareket kabiliyetinizi geri kazanmanızı sağlıyoruz.','bi-person-arms-up','https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800&q=80',6);

-- ============ PROJELER → KLİNİĞİMİZ (GALERİ) ============
DROP TABLE IF EXISTS `projeler`;
CREATE TABLE `projeler` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `baslik` VARCHAR(150) NOT NULL,
  `slug` VARCHAR(180),
  `kategori` VARCHAR(60),
  `gorsel` VARCHAR(255),
  `aciklama` TEXT,
  `tarih` VARCHAR(40),
  `sira` INT DEFAULT 0,
  `durum` TINYINT DEFAULT 1,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `projeler` (`baslik`,`slug`,`kategori`,`gorsel`,`aciklama`,`tarih`,`sira`) VALUES
('Modern Muayene Odaları','modern-muayene-odalari','Klinik','https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=800&q=80','Hasta mahremiyeti ve konforu gözetilerek tasarlanmış, tam donanımlı steril muayene odalarımız.','2026',1),
('Görüntüleme Merkezi','goruntuleme-merkezi','Teknoloji','https://images.unsplash.com/photo-1516069677018-378515003435?w=800&q=80','Dijital röntgen ve ultrasonografi cihazlarıyla hızlı ve net görüntüleme hizmeti.','2026',2),
('Tam Donanımlı Laboratuvar','laboratuvar','Teknoloji','https://images.unsplash.com/photo-1582719471384-894fbb16e074?w=800&q=80','Kan, idrar ve biyokimya tahlillerinde aynı gün sonuç veren modern laboratuvarımız.','2026',3),
('Diş Üniteleri','dis-uniteleri','Klinik','https://images.unsplash.com/photo-1629909613654-28e377c37b09?w=800&q=80','Son teknoloji diş üniteleri ve dijital görüntüleme ile konforlu diş tedavisi.','2025',4),
('Fizik Tedavi Salonu','fizik-tedavi-salonu','Klinik','https://images.unsplash.com/photo-1576765608535-5f04d1e3f289?w=800&q=80','Geniş egzersiz alanı ve modern cihazlarla donatılmış rehabilitasyon ünitemiz.','2025',5),
('Konforlu Bekleme Alanı','bekleme-alani','Konfor','https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=800&q=80','Ferah ve hijyenik bekleme salonumuzda randevunuzu konforla bekleyin.','2025',6);

-- ============ BLOG → SAĞLIK REHBERİ ============
DROP TABLE IF EXISTS `blog`;
CREATE TABLE `blog` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `baslik` VARCHAR(200) NOT NULL,
  `slug` VARCHAR(200),
  `kategori` VARCHAR(60),
  `ozet` TEXT,
  `icerik` LONGTEXT,
  `gorsel` VARCHAR(255),
  `tarih` DATE,
  `durum` TINYINT DEFAULT 1,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `blog` (`baslik`,`slug`,`kategori`,`ozet`,`icerik`,`gorsel`,`tarih`) VALUES
('Düzenli Check-Up Neden Hayat Kurtarır?','duzenli-check-up-neden-onemli','Koruyucu Sağlık','Birçok ciddi hastalık erken evrede hiçbir belirti vermez. Düzenli sağlık taraması, tedavi şansını kat kat artırır.','Hipertansiyon, diyabet ve birçok kanser türü erken evrelerinde sessiz ilerler. Düzenli check-up sayesinde bu hastalıklar henüz belirti vermeden tespit edilebilir ve tedavi başarısı önemli ölçüde artar. 40 yaş üstü bireylerin yılda bir, kronik hastalık riski taşıyanların ise hekimin önerdiği aralıklarla kapsamlı tarama yaptırması önerilir. Check-up paketinizin yaşınıza, cinsiyetinize ve aile öykünüze göre kişiselleştirilmesi en doğru yaklaşımdır.','https://images.unsplash.com/photo-1505751172876-fa1923c5c528?w=800&q=80','2026-05-20'),
('Kalp Sağlığınızı Korumanın 7 Altın Kuralı','kalp-sagligini-korumanin-7-yolu','Kardiyoloji','Kalp damar hastalıkları önlenebilir. Beslenmeden uykuya, günlük hayatta uygulayabileceğiniz 7 etkili öneri.','Kalp sağlığını korumak için: 1) Haftada en az 150 dakika tempolu yürüyüş yapın. 2) Akdeniz tipi beslenmeyi benimseyin; sebze, zeytinyağı ve balık tüketin. 3) Tuzu günde 5 gramın altına indirin. 4) Sigarayı bırakın — risk ilk yılda yarı yarıya azalır. 5) Tansiyonunuzu ve kolesterolünüzü düzenli ölçtürün. 6) Stresi yönetin; nefes egzersizleri ve düzenli uyku kalbinizi korur. 7) İdeal kilonuzu koruyun. Ailesinde kalp hastalığı öyküsü olanların düzenli kardiyoloji kontrolü ihmal etmemesi gerekir.','https://images.unsplash.com/photo-1559757175-0eb30cd8c063?w=800&q=80','2026-04-28'),
('Mevsim Geçişlerinde Bağışıklığınızı Güçlendirin','mevsim-gecislerinde-bagisiklik','Genel Sağlık','Mevsim geçişleri enfeksiyonlara davetiye çıkarır. Bağışıklık sisteminizi doğal yollarla destekleyin.','Mevsim geçişlerinde vücut direnci düşer ve üst solunum yolu enfeksiyonları artar. Bağışıklığınızı güçlendirmek için: günde 7-8 saat kaliteli uyku uyuyun, C vitamini yönünden zengin taze sebze-meyve tüketin, bol su için ve düzenli egzersiz yapın. D vitamini eksikliği bağışıklık zafiyetinin en sık nedenlerindendir — kan değerlerinizi kontrol ettirip gerekiyorsa hekim önerisiyle takviye alın. Şikayetleriniz 1 haftadan uzun sürerse mutlaka bir sağlık kuruluşuna başvurun.','https://images.unsplash.com/photo-1490645935967-10de6ba17061?w=800&q=80','2026-03-15');

-- ============ REFERANSLAR (HASTA YORUMLARI) ============
DROP TABLE IF EXISTS `referanslar`;
CREATE TABLE `referanslar` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `ad` VARCHAR(100) NOT NULL,
  `unvan` VARCHAR(120),
  `yorum` TEXT,
  `foto` VARCHAR(255),
  `yildiz` TINYINT DEFAULT 5,
  `durum` TINYINT DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `referanslar` (`ad`,`unvan`,`yorum`,`foto`,`yildiz`) VALUES
('Ayşe K.','Check-Up Hastası','Randevu saatime tam zamanında alındım, tüm tetkiklerim aynı gün bitti ve sonuçlarım detaylıca anlatıldı. Bu kadar düzenli bir klinik görmedim.','https://i.pravatar.cc/100?img=47',5),
('Mehmet D.','Diş Tedavisi Hastası','İmplant tedavim boyunca her aşamada bilgilendirildim. Hekimim son derece ilgiliydi, hiç ağrı hissetmedim. Gönül rahatlığıyla tavsiye ederim.','https://i.pravatar.cc/100?img=12',5),
('Zeynep A.','Fizik Tedavi Hastası','Bel fıtığım için aldığım fizik tedavi sonrası ağrılarım büyük ölçüde geçti. Fizyoterapist ekip çok profesyonel ve güler yüzlü.','https://i.pravatar.cc/100?img=32',5);

-- ============ MESAJLAR ============
DROP TABLE IF EXISTS `mesajlar`;
CREATE TABLE `mesajlar` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `ad` VARCHAR(100),
  `mail` VARCHAR(150),
  `tel` VARCHAR(40),
  `konu` VARCHAR(200),
  `mesaj` TEXT,
  `okundu` TINYINT DEFAULT 0,
  `tarih` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============ TEKLİFLER (RANDEVU TALEPLERİ) ============
DROP TABLE IF EXISTS `teklifler`;
CREATE TABLE `teklifler` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `ad` VARCHAR(100),
  `mail` VARCHAR(150),
  `tel` VARCHAR(40),
  `hizmet` VARCHAR(120),
  `il` VARCHAR(60),
  `adres` VARCHAR(255),
  `alan` VARCHAR(60),
  `butce` VARCHAR(60),
  `baslangic` VARCHAR(60),
  `detay` TEXT,
  `durum` ENUM('yeni','degerlendiriliyor','teklif_verildi','kazanildi','kaybedildi') DEFAULT 'yeni',
  `notlar` TEXT,
  `tarih` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============ ADMIN ============
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `kullanici` VARCHAR(60) NOT NULL UNIQUE,
  `sifre_hash` VARCHAR(255) NOT NULL,
  `ad_soyad` VARCHAR(120),
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Şifre: admin123  (password_hash bcrypt) — CANLIDA MUTLAKA DEĞİŞTİR
INSERT INTO `admin` (`kullanici`,`sifre_hash`,`ad_soyad`) VALUES
('admin','$2y$10$6gNrpOXRLof.Toy.Ugy.yu4DrKP23OcnJa7UBhKOH1iMxbtH8GK0.','Yönetici');

SET FOREIGN_KEY_CHECKS = 1;
