# MPL (My Programming Language)

COM2043 Programming Languages Concepts dersi için Flex (Lex) ve Bison (Yacc) ile geliştirilmiş sözdizimsel analiz (syntax analyzer) projesi.

## Özellikler

* **Özgün Sözdizimi:** C/Java kopyası olmayan, Türkçe anahtar kelimelere sahip özgün dil yapısı.
* **Kolay Değiştirilebilir:** `anahtar_kelimeler.h` dosyası üzerinden tüm dil kelimeleri anında özelleştirilebilir.
* **Gramer Kapsamı:**
  * Program çatısı (`program <isim> basla ... bitir`)
  * 3 Veri Tipi: `sayi` (int), `virgul` (float), `yazi` (char)
  * Değişken tanımlama (`degisken x, y: sayi;`)
  * Aritmetik operatörler (`+`, `-`, `*`, `/`, `%`)
  * Karşılaştırma operatörleri (`==`, `!=`, `<`, `>`, `<=`, `>=`)
  * Mantıksal operatörler (`&&`, `||`, `!`)
  * Öncelik ve parantez kuralları
  * Koşul yapısı (`eyer (koşul) ise ... degilse ... son_eyer;`)
  * Döngü yapısı (`dongu (koşul) yap ... son_dongu;`)
  * Yorum satırları (`# yorum` veya `// yorum`)

## Derleme ve Çalıştırma

### 1. Derleme
Windows üzerinde `derle.bat` dosyasını çalıştırın:
```cmd
.\derle.bat
```

### 2. Test Etme
Otomatik testleri çalıştırmak için:
```cmd
.\test_calistir.bat
```

Veya elle çalıştırmak için:
```cmd
.\mpl.exe < ornek_gecerli.mpl
# Çıktı: OK

.\mpl.exe < ornek_gecersiz.mpl
# Çıktı: Syntax error at line 13: unexpected 'x'
```

Detaylı BNF / CFG kuralları ve ödev rapor şablonu için `KULLANIM_KILAVUZU.md` dosyasını inceleyebilirsiniz.
