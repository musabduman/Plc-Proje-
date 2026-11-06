# MPL (My Programming Language) - Kullanım ve Tasarım Kılavuzu

Bu proje, **COM2043 Programming Languages Concepts** dersi için Flex (Lex) ve Bison (Yacc) kullanılarak geliştirilmiş sözdizimsel analiz (syntax analyzer) projesidir.

---

## 1. Dosya Yapısı

* **`anahtar_kelimeler.h`**: **(EN ÖNEMLİ DOSYA)** Dilin tüm kelimeleri (`eyer`, `degisken`, `sayi`, `dongu` vb.) burada tanımlıdır. Buradaki kelimeleri değiştirdiğinizde başka hiçbir dosyaya dokunmadan `derle.bat` çalıştırmanız yeterlidir.
* **`mpl.l`**: Sözcüksel analiz (Lexer). Token kuralları, regex kalıpları, sayılar, karakterler ve yorum satırlarını yakalar.
* **`mpl.y`**: Sözdizimsel analiz (Grammar/Parser). CFG kuralları ve operatör önceliklerini içerir.
* **`derle.bat`**: Flex, Bison ve GCC'yi sırasıyla çalıştırıp `mpl.exe` dosyasını oluşturan derleme betiği.
* **`test_calistir.bat`**: Geçerli ve geçersiz örnek kodları otomatik test edip sonuçları ekrana basan betik.
* **`ornek_gecerli.mpl`**: Dilin tüm özelliklerini (tipler, atamalar, eyer, dongu, operatörler) kullanan geçerli kaynak kod. Çıktı: `OK`.
* **`ornek_gecersiz.mpl`**: Kasıtlı noktalı virgül ve blok hataları içeren kaynak kod. Çıktı: `Syntax error`.
* **`ornek_gecersiz2.mpl`**: `bitir` kelimesi unutulmuş hatalı kaynak kod. Çıktı: `Syntax error`.

---

## 2. Anahtar Kelimeleri Değiştirme (İstediğiniz An!)

`anahtar_kelimeler.h` dosyasını açıp dilediğiniz kelimenin tırnak içini değiştirin:

```c
#define KELIME_PROGRAM       "program"
#define KELIME_BASLA         "basla"
#define KELIME_BITIR         "bitir"
#define KELIME_DEGISKEN      "degisken"
#define KELIME_SAYI          "sayi"      /* Örn: "tamsayi" veya "int" yapabilirsiniz */
#define KELIME_VIRGUL        "virgul"    /* Örn: "ondalik" veya "float" yapabilirsiniz */
#define KELIME_YAZI          "yazi"      /* Örn: "metin" veya "char" yapabilirsiniz */
#define KELIME_EYER          "eyer"      /* Örn: "eger" veya "if" yapabilirsiniz */
#define KELIME_ISE           "ise"       /* Örn: "then" yapabilirsiniz */
#define KELIME_DEGILSE       "degilse"   /* Örn: "else" yapabilirsiniz */
#define KELIME_SON_EYER      "son_eyer"  /* Örn: "endif" yapabilirsiniz */
#define KELIME_DONGU         "dongu"     /* Örn: "while" yapabilirsiniz */
#define KELIME_YAP           "yap"       /* Örn: "do" yapabilirsiniz */
#define KELIME_SON_DONGU     "son_dongu" /* Örn: "endwhile" yapabilirsiniz */
```

Değiştirdikten sonra tek yapmanız gereken **`derle.bat`** dosyasını çift tıklamak veya terminalde çalıştırmaktır.

---

## 3. Derleme ve Çalıştırma

### Otomatik Derleme:
```cmd
.\derle.bat
```

### Manuel Derleme (Ödev Yönergesi Formatında):
```cmd
bison -d -y mpl.y
flex mpl.l
gcc y.tab.c lex.yy.c -o mpl.exe
```

### Kod Test Etme:
```cmd
.\mpl.exe < ornek_gecerli.mpl
# Başarılı ise ekrana: OK basar.

.\mpl.exe < ornek_gecersiz.mpl
# Hatalı ise ekrana: Syntax error at line X: unexpected '...' basar.
```

---

## 4. Ödev Raporu (Technical Report) İçin BNF / CFG Kuralları

Ödevin 1. teslim maddesi olan teknik raporda kullanabilmeniz için dilin tam Context-Free Grammar (CFG) gösterimi:

```bnf
<program>           ::= "program" <identifier> "basla" <statement_list> "bitir"
                      | "program" <identifier> "basla" "bitir"

<statement_list>    ::= <statement_list> <statement>
                      | <statement>

<statement>         ::= <var_declaration>
                      | <assignment_stmt>
                      | <conditional_stmt>
                      | <loop_stmt>
                      | ";"

<var_declaration>   ::= "degisken" <var_init_list> ":" <data_type> ";"

<data_type>         ::= "sayi" | "virgul" | "yazi"

<var_init_list>     ::= <var_init_list> "," <var_init_item>
                      | <var_init_item>

<var_init_item>     ::= <identifier>
                      | <identifier> "=" <expression>

<assignment_stmt>   ::= <identifier> "=" <expression> ";"

<conditional_stmt>  ::= "eyer" "(" <expression> ")" "ise" <statement_list> "son_eyer" ";"
                      | "eyer" "(" <expression> ")" "ise" <statement_list> "degilse" <statement_list> "son_eyer" ";"

<loop_stmt>         ::= "dongu" "(" <expression> ")" "yap" <statement_list> "son_dongu" ";"

<expression>        ::= <expression> "+" <expression>
                      | <expression> "-" <expression>
                      | <expression> "*" <expression>
                      | <expression> "/" <expression>
                      | <expression> "%" <expression>
                      | <expression> "==" <expression>
                      | <expression> "!=" <expression>
                      | <expression> "<" <expression>
                      | <expression> ">" <expression>
                      | <expression> "<=" <expression>
                      | <expression> ">=" <expression>
                      | <expression> "&&" <expression>
                      | <expression> "||" <expression>
                      | "!" <expression>
                      | "-" <expression>
                      | "(" <expression> ")"
                      | <primary_expr>

<primary_expr>      ::= <identifier> | <int_const> | <float_const> | <char_const> | <string_const>
```
