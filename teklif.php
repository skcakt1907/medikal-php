<?php
require_once __DIR__ . '/inc/helpers.php';
$mesaj=''; $hata='';
$hizmetler = getList('hizmetler','durum=1','sira ASC');
if($_SERVER['REQUEST_METHOD']==='POST'){
    csrf_check();
    $f = [
        'ad'        => trim($_POST['ad'] ?? ''),
        'mail'      => trim($_POST['mail'] ?? ''),
        'tel'       => trim($_POST['tel'] ?? ''),
        'hizmet'    => trim($_POST['hizmet'] ?? ''),
        'il'        => trim($_POST['il'] ?? ''),
        'adres'     => trim($_POST['adres'] ?? ''),
        'alan'      => trim($_POST['alan'] ?? ''),
        'butce'     => trim($_POST['butce'] ?? ''),
        'baslangic' => trim($_POST['baslangic'] ?? ''),
        'detay'     => trim($_POST['detay'] ?? ''),
    ];
    if(!$f['ad'] || !$f['tel'] || !$f['hizmet']){
        $hata = 'Ad, telefon ve bölüm alanları zorunludur.';
    } elseif($f['mail'] && !filter_var($f['mail'], FILTER_VALIDATE_EMAIL)){
        $hata = 'Geçerli bir e-posta adresi giriniz.';
    } else {
        $stmt = $db->prepare("INSERT INTO teklifler(ad,mail,tel,hizmet,il,adres,alan,butce,baslangic,detay) VALUES(:ad,:mail,:tel,:hizmet,:il,:adres,:alan,:butce,:baslangic,:detay)");
        $stmt->execute($f);
        $mesaj = 'Randevu talebiniz alındı. Ekibimiz en kısa sürede sizi arayarak randevunuzu kesinleştirecek.';
    }
}
require_once __DIR__ . '/inc/header.php';
?>
<section class="page-head">
  <div class="container">
    <h1>Online Randevu</h1>
    <nav><ol class="breadcrumb"><li class="breadcrumb-item"><a href="<?= SITE_URL ?>/">Anasayfa</a></li><li class="breadcrumb-item active">Randevu Al</li></ol></nav>
  </div>
</section>

<section>
  <div class="container">
    <div class="row g-5">
      <div class="col-lg-7">
        <span class="badge-mini">Online Randevu</span>
        <h2>Size Uygun <span style="color:var(--primary)">Randevuyu</span> Planlayalım</h2>
        <p class="text-muted mb-4">Formu doldurun, ekibimiz sizi arayıp size en uygun gün ve saate randevunuzu oluştursun.</p>

        <?php if($mesaj): ?><div class="alert alert-success"><i class="bi bi-check-circle-fill me-2"></i><?= e($mesaj) ?></div><?php endif; ?>
        <?php if($hata):  ?><div class="alert alert-danger"><i class="bi bi-exclamation-triangle-fill me-2"></i><?= e($hata) ?></div><?php endif; ?>

        <form method="post" class="contact-form">
          <input type="hidden" name="csrf" value="<?= csrf_token() ?>">
          <h5 class="mb-3 mt-2" style="color:var(--primary)"><i class="bi bi-person me-2"></i>İletişim Bilgileri</h5>
          <div class="row g-3">
            <div class="col-md-6"><label class="form-label">Ad Soyad *</label><input class="form-control" name="ad" required></div>
            <div class="col-md-6"><label class="form-label">Telefon *</label><input class="form-control" name="tel" required></div>
            <div class="col-md-12"><label class="form-label">E-posta</label><input type="email" class="form-control" name="mail"></div>
          </div>

          <h5 class="mb-3 mt-4" style="color:var(--primary)"><i class="bi bi-clipboard2-pulse me-2"></i>Randevu Detayları</h5>
          <div class="row g-3">
            <div class="col-md-6">
              <label class="form-label">Bölüm / Tedavi *</label>
              <select class="form-select" name="hizmet" required>
                <option value="">— Seçiniz —</option>
                <?php foreach($hizmetler as $h): ?>
                  <option value="<?= e($h['baslik']) ?>" <?= (isset($_GET['hizmet']) && $_GET['hizmet']===$h['slug'])?'selected':'' ?>><?= e($h['baslik']) ?></option>
                <?php endforeach; ?>
                <option value="Diğer">Diğer</option>
              </select>
            </div>
            <div class="col-md-6"><label class="form-label">İl / İlçe</label><input class="form-control" name="il" placeholder="örn. İstanbul / Şişli"></div>
            <div class="col-12"><label class="form-label">Adres (opsiyonel)</label><input class="form-control" name="adres"></div>
            <div class="col-md-4"><label class="form-label">Tercih Ettiğiniz Saat</label><input class="form-control" name="alan" placeholder="örn. 14:00"></div>
            <div class="col-md-4">
              <label class="form-label">Randevu Tipi</label>
              <select class="form-select" name="butce">
                <option value="">— Seçiniz —</option>
                <option>İlk Muayene</option>
                <option>Kontrol</option>
                <option>Tahlil / Tetkik</option>
                <option>Check-Up</option>
                <option>Bilmiyorum</option>
              </select>
            </div>
            <div class="col-md-4">
              <label class="form-label">Ne Zaman?</label>
              <select class="form-select" name="baslangic">
                <option value="">— Seçiniz —</option>
                <option>Acil (bugün / yarın)</option>
                <option>Bu hafta içinde</option>
                <option>Gelecek hafta</option>
                <option>1 ay içinde</option>
                <option>Fark etmez</option>
              </select>
            </div>
            <div class="col-12"><label class="form-label">Şikayetiniz / Notlar</label><textarea class="form-control" name="detay" rows="5" placeholder="Şikayetinizi veya talebinizi kısaca anlatın..."></textarea></div>
            <div class="col-12 d-flex gap-2 align-items-center flex-wrap mt-2">
              <button class="btn btn-primary-c"><i class="bi bi-send"></i> Randevu Talebi Gönder</button>
              <span class="text-muted small ms-2"><i class="bi bi-shield-check me-1"></i>Bilgileriniz gizli tutulur, asla 3. kişilerle paylaşılmaz.</span>
            </div>
          </div>
        </form>
      </div>

      <div class="col-lg-5">
        <div class="quote-call">
          <div class="quote-call-icon"><i class="bi bi-telephone-fill"></i></div>
          <div>
            <small>Hemen Arayın</small>
            <a href="tel:<?= e(ayar('telefon')) ?>"><?= e(ayar('telefon')) ?></a>
          </div>
        </div>
        <ul class="quote-perks">
          <li><i class="bi bi-calendar2-check"></i><div><strong>Kolay Randevu</strong><span>Telefonla arayıp teyit ediyoruz.</span></div></li>
          <li><i class="bi bi-clock-history"></i><div><strong>Hızlı Dönüş</strong><span>En geç 1 iş gününde.</span></div></li>
          <li><i class="bi bi-shield-check"></i><div><strong>Gizlilik</strong><span>Bilgileriniz KVKK kapsamında korunur.</span></div></li>
        </ul>
      </div>
    </div>
  </div>
</section>
<?php require_once __DIR__ . '/inc/footer.php'; ?>
