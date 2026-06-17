<?php require_once __DIR__ . '/inc/header.php'; $hizmetler = getList('hizmetler','durum=1','sira ASC'); ?>
<section class="page-head">
  <div class="container">
    <h1>Tedavilerimiz</h1>
    <nav><ol class="breadcrumb"><li class="breadcrumb-item"><a href="<?= SITE_URL ?>/">Anasayfa</a></li><li class="breadcrumb-item active">Tedaviler</li></ol></nav>
  </div>
</section>

<section>
  <div class="container">
    <div class="section-head center">
      <span class="badge-mini">Bölümlerimiz</span>
      <h2>Sunduğumuz <span>Sağlık Hizmetleri</span></h2>
      <p>Uzman hekim kadromuzla tanıdan tedaviye tüm sağlık ihtiyaçlarınızda yanınızdayız.</p>
    </div>
    <div class="row g-4">
      <?php foreach($hizmetler as $h): ?>
      <div class="col-lg-4 col-md-6">
        <div class="service-card">
          <div class="service-icon"><i class="bi <?= e($h['ikon']) ?>"></i></div>
          <h4><?= e($h['baslik']) ?></h4>
          <p><?= e($h['ozet']) ?></p>
          <a href="<?= SITE_URL ?>/hizmet-detay?slug=<?= e($h['slug']) ?>">Detay <i class="bi bi-arrow-right"></i></a>
        </div>
      </div>
      <?php endforeach; ?>
    </div>
  </div>
</section>

<section class="cta">
  <div class="container d-flex justify-content-between align-items-center flex-wrap">
    <h3>Muayene için hemen randevu oluşturun</h3>
    <a href="<?= SITE_URL ?>/teklif" class="btn">Randevu Al</a>
  </div>
</section>
<?php require_once __DIR__ . '/inc/footer.php'; ?>
