# ============================================================
# Gecersiz MPL Kaynak Kodu Ornegi
# Bu dosyada kasitli sozluksel/sozdizimsel hatalar bulunmaktadir.
# Beklenen cikti: Syntax error (satir bilgisiyle birlikte)
# ============================================================

program HataliProgram
basla
    degisken x: sayi

    # HATA 1: Yukaridaki satirda noktalı virgül (;) unutuldu.

    x = 10;

    # HATA 2: eyer ifadesinde 'ise' anahtar kelimesi eksik ve son_eyer yok.
    eyer (x > 5)
        x = x + 1;
bitir
