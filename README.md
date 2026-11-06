# MPL (My Programming Language)

Bu proje, **COM2043 Programming Languages Concepts** dersi için **Flex (Lex)** ve **Bison (Yacc)** araçları kullanılarak geliştirilmiş, özgün sözdizimine (syntax) sahip bir programlama dili ve sözdizimsel analiz (syntax analyzer) projesidir.

---

## 📍 Proje Konumu ve Dosyalar Nerede?

Tüm proje dosyaları bilgisayarınızda şu klasördedir:
📂 **Masaüstü -> `plc proje`**  
*(Tam dosya yolu: `C:\Users\dum4n\Desktop\plc proje`)*

### Klasördeki Dosyalar ve Görevleri:

| Dosya Adı | Ne İşe Yarar? |
| :--- | :--- |
| **`anahtar_kelimeler.h`** | **Dilin Sözlüğü:** `eyer`, `degisken`, `sayi`, `dongu` gibi tüm anahtar kelimeler burada tanımlıdır. Kelimeleri değiştirmek istediğinizde tek açmanız gereken dosya budur. |
| **`mpl.l`** | **Lex / Flex Kaynak Kodu:** Kelimeleri, sayıları, operatörleri ve yorum satırlarını (`# ...`) tanıyan sözcüksel analiz (lexer) kuralları. |
| **`mpl.y`** | **Yacc / Bison Kaynak Kodu:** Dilin gramer kurallarını (CFG), operatör önceliklerini (`*` ve `/` önceliği) ve sözdizim denetimini barındıran dosya. |
| **`derle.bat`** | **Derleme Dosyası:** Çift tıklandığında `flex`, `bison` ve `gcc` komutlarını sırayla çalıştırıp `mpl.exe` derleyicisini üretir. |
| **`test_calistir.bat`** | **Otomatik Test Dosyası:** Çift tıklandığında geçerli ve hatalı kodları otomatik olarak test edip sonucu ekrana basar. |
| **`ornek_gecerli.mpl`** | **Geçerli Kod Örneği:** Dilin tüm kurallarını (tipler, atamalar, eyer, döngü) eksiksiz kullanan test programı. Ekrana `OK` basar. |
| **`ornek_gecersiz.mpl`** | **Hatalı Kod Örneği 1:** Kasıtlı noktalı virgül ve sözdizim hatası içeren test programı. Ekrana `Syntax error` basar. |
| **`ornek_gecersiz2.mpl`** | **Hatalı Kod Örneği 2:** Programın `bitir` kelimesi unutulmuş test programı. Ekrana `Syntax error` basar. |
| **`KULLANIM_KILAVUZU.md`** | **Rapor Kılavuzu:** Ödevin 1. teslim maddesi olan teknik rapora kopyalayabileceğiniz tam BNF/CFG gramer kuralları. |
| **`pdfler/`** | Ödev yönergesi (`COM2043_Project1.pdf`) ve Lex/Yacc ders materyallerinin bulunduğu klasör. |

---

## 🧪 Nasıl Test Edilir?

Projeyi test etmenin **iki kolay yolu** vardır:

### 1. Yol: En Kolay Yol (Tek Tıkla Otomatik Test)
1. Masaüstündeki **`plc proje`** klasörünü açın.
2. **`test_calistir.bat`** dosyasına **çift tıklayın**.
3. Açılan siyah pencerede testler otomatik koşacak ve şu çıktıları göreceksiniz:
   * Geçerli kod için: `OK`
   * Hatalı kodlar için: `Syntax error at line ...`
4. Kapatmak için klavyeden bir tuşa basmanız yeterlidir.

### 2. Yol: Terminal / Komut Satırından Manuel Test
1. **`plc proje`** klasöründeyken üst adres çubuğuna `cmd` yazıp **Enter**'a basın.
2. Aşağıdaki komutları çalıştırarak test edebilirsiniz:

* **Geçerli program testi:**
  ```cmd
  mpl.exe < ornek_gecerli.mpl
  ```
  *(Sonuç: `OK` basar ve hatasız biter.)*

* **Hatalı program testi:**
  ```cmd
  mpl.exe < ornek_gecersiz.mpl
  ```
  *(Sonuç: `Syntax error at line 13: unexpected 'x'` basar.)*

### 💡 Kendi Yazacağınız Yeni Kodları Test Etmek:
Klasör içinde `benim_kodum.mpl` adında yeni bir dosya oluşturup içine MPL dilinde kodunuzu yazın. Ardından terminalde:
```cmd
mpl.exe < benim_kodum.mpl
```
yazarak kodunuzun sözdizimini kontrol edebilirsiniz.

---

## ⚙️ Anahtar Kelimeleri Değiştirme (İsteğe Bağlı)

Dilin anahtar kelimelerini (örneğin `eyer` yerine `eger` veya `if`, `sayi` yerine `int`) değiştirmek isterseniz:

1. **`anahtar_kelimeler.h`** dosyasını Not Defteri veya VS Code ile açın.
2. İstediğiniz kelimenin tırnak içini değiştirip kaydedin:
   ```c
   #define KELIME_EYER       "eger"     /* "eyer" yerine "eger" yaptık */
   ```
3. Klasördeki **`derle.bat`** dosyasına çift tıklayın (kodları otomatik yeniden derler).
4. Artık yeni anahtar kelimeniz geçerlidir!

---

## 📋 Dilin Özellikleri ve Örnek Kod

```mpl
program DenemeProgrami
basla
    # 1. Degisken tanimlama (sayi, virgul, yazi tipleri)
    degisken sayac, toplam: sayi;
    degisken oran: virgul;
    degisken harf: yazi;

    # 2. Atamalar ve Aritmetik Islemler (+, -, *, /, %)
    sayac = 0;
    toplam = (sayac + 5) * 2;

    # 3. Kosul Yapisi (eyer - ise - degilse - son_eyer)
    eyer (sayac > 10 && toplam <= 100) ise
        toplam = toplam + 1;
    degilse
        toplam = toplam - 1;
    son_eyer;

    # 4. Dongu Yapisi (dongu - yap - son_dongu)
    dongu (sayac < 10) yap
        sayac = sayac + 1;
    son_dongu;
bitir
```
