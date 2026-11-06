# ============================================================
# Gecerli MPL Kaynak Kodu Ornegi
# Bu program dilin tum gereksinimlerini eksiksiz kullanir.
# ============================================================

program Hesaplayici
basla
    # 1. Degisken tanimlamalari (3 farkli veri tipi)
    degisken sayac, toplam: sayi;
    degisken ortalama, carpan = 2.5: virgul;
    degisken karakter: yazi;
    degisken durum: sayi;

    # 2. Atamalar ve Aritmetik Islemler (+, -, *, /, %)
    sayac = 1;
    toplam = 0;
    ortalama = (toplam + 50) / 2.0;
    toplam = toplam + (sayac * 10) - (4 / 2) % 3;

    # 3. Kosul Yapisi (eyer - ise - degilse - son_eyer)
    # Karsilastirma ve mantiksal operatorler (>, <=, &&, ||, !)
    eyer (sayac > 0 && !(sayac == 10) || toplam <= 100) ise
        toplam = toplam + 10;
        karakter = 'A';
    degilse
        toplam = toplam - 5;
        karakter = 'B';
    son_eyer;

    # 4. Dongu Yapisi (dongu - yap - son_dongu)
    dongu (sayac <= 10) yap
        toplam = toplam + sayac;
        sayac = sayac + 1;

        # Ic ice eyer yapisi
        eyer (toplam >= 50) ise
            durum = 1;
        son_eyer;
    son_dongu;
bitir
