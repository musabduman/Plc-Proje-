# MPL User and Language Guide

This COM2043 Programming Languages Concepts project implements a syntax analyzer for MPL (My Programming Language). Flex reads the source file and recognizes its tokens. Bison checks their sequence against the MPL grammar. The analyzer prints OK when the input passes the syntax check.

## 1. Project files

| File | Purpose |
| --- | --- |
| `anahtar_kelimeler.h` | Defines the spelling of reserved keywords, 
  including the type names `sayi`, `ondalik`, and `yazi`. |
| `mpl.l` | Contains the Flex rules for identifiers, literals, 
  keywords, operators, punctuation, and comments. |
| `mpl.y` | Contains the Bison grammar, operator precedence, 
  and syntax error reporting. |
| `derle.bat` | Runs Bison, Flex, and GCC to build `mpl.exe`. |
| `test_calistir.bat` | Checks the four example programs and 
  reports whether each result matches the expectation. |

## 2. Build and test on Windows

### Build with the batch file

Open PowerShell in the project directory. The batch file calls `bison`, `flex`, and `gcc`. It adds `C:\msys64\ucrt64\bin` to its own `PATH`. Tools installed elsewhere must be available on the terminal's `PATH`.

```powershell
.\derle.bat
```

For a manual build with those same command names, run the following commands in order.

```powershell
bison -d -y mpl.y
flex mpl.l
gcc y.tab.c lex.yy.c -o mpl.exe
```

Bison generates `y.tab.c` and `y.tab.h`. Flex generates `lex.yy.c`. GCC compiles the two C files into `mpl.exe`.

### Build with WinFlexBison

The portable Windows package uses the executable names `win_bison.exe` and `win_flex.exe`. If you use that package, extract it to `.tools\winflexbison` in the project directory, with the two executables directly inside that folder. Run the following from the project directory with `gcc` available on `PATH`.

```powershell
.\.tools\winflexbison\win_bison.exe -d -y mpl.y
.\.tools\winflexbison\win_flex.exe mpl.l
gcc y.tab.c lex.yy.c -o mpl.exe
```

If you use MSYS2 MinGW64 and PowerShell cannot find `gcc`, add its `bin` directory to the current PowerShell session before building.

```powershell
$env:Path = "C:\msys64\mingw64\bin;$env:Path"
```

### Check an MPL file

Pass a filename to the analyzer, or use the batch file to check all four examples.

```powershell
.\mpl.exe .\ornek_gecerli.mpl
.\test_calistir.bat
```

To check a file from another folder, pass its full path in quotes if the path contains spaces. In Command Prompt, you can also pass a file through standard input with `mpl.exe < ornek_gecerli.mpl`.

| Example | Expected analyzer result | Exit code |
| --- | --- | --- |
| `ornek_gecerli.mpl` | `OK` for a program with declarations, expressions, and nested control flow | `0` |
| `test.mpl` | `OK` for declarations that use `ondalik` | `0` |
| `ornek_gecersiz.mpl` | `Syntax error at line 13: unexpected 'x'` because the preceding declaration lacks a semicolon | `1` |
| `ornek_gecersiz2.mpl` | `Syntax error at line 16: unexpected ''` because the program ends without `bitir` | `1` |

When a syntax error is detected, the analyzer reports the line and token it encountered. The test script treats a syntax error as the expected result for the two invalid examples.

## 3. Change a keyword

The keyword spellings are the quoted values in `anahtar_kelimeler.h`. To use `eger` as the conditional keyword, edit its definition as shown below.

```c
#define KELIME_EYER "eger"
```

Use a unique spelling that starts with an ASCII letter. Subsequent characters can be ASCII letters, digits, or underscores. Keywords are case-sensitive. Rebuild the analyzer after editing the header, and apply the new spelling to any MPL programs that use that keyword.

## 4. Language reference

An MPL program has a name and a body delimited by `basla` and `bitir`. The body can contain declarations, assignments, conditionals, loops, or empty statements. A declaration can list several variables of the same type, each with an optional initializer. The type names are `sayi` for integers, `ondalik` for decimal numbers, and `yazi` for characters or strings.

Use a decimal point in decimal literals such as `2.5`. Character literals use single quotes and string literals use double quotes. Both forms support escape sequences. A comment starting with `#` or `//` extends to the end of the line.

```mpl
program Hesaplayici
basla
    degisken sayac = 1, toplam = 0: sayi;
    degisken oran = 2.5: ondalik;
    degisken etiket = "sonuc": yazi;

    dongu (sayac < 3) yap
        eyer (oran >= 2.0 && sayac != 0) ise
            toplam = toplam + sayac;
        son_eyer;
        sayac = sayac + 1;
    son_dongu;
bitir
```

### Context-free grammar

The BNF below uses quotes for literal spellings, uppercase names for tokens supplied by Flex, and ε for an empty sequence. Program, conditional, and loop bodies all use the same statement list, which may be empty.

```bnf
<program>       ::= "program" IDENTIFIER "basla" <statements> "bitir"
<statements>    ::= ε | <statements> <statement>
<statement>     ::= <declaration> | <assignment> | <conditional> | <loop> | ";"

<declaration>   ::= "degisken" <var-list> ":" <type> ";"
<var-list>      ::= <var-item> | <var-list> "," <var-item>
<var-item>      ::= IDENTIFIER | IDENTIFIER "=" <expression>
<type>          ::= "sayi" | "ondalik" | "yazi"
<assignment>    ::= IDENTIFIER "=" <expression> ";"

<conditional>   ::= "eyer" "(" <expression> ")" "ise" <statements> <else-part> "son_eyer" ";"
<else-part>     ::= ε | "degilse" <statements>
<loop>          ::= "dongu" "(" <expression> ")" "yap" <statements> "son_dongu" ";"

<expression>    ::= <logical-or>
<logical-or>    ::= <logical-and> | <logical-or> "||" <logical-and>
<logical-and>   ::= <equality> | <logical-and> "&&" <equality>
<equality>      ::= <comparison> | <equality> "==" <comparison> | <equality> "!=" <comparison>
<comparison>    ::= <sum> | <comparison> "<" <sum> | <comparison> ">" <sum>
                  | <comparison> "<=" <sum> | <comparison> ">=" <sum>
<sum>           ::= <product> | <sum> "+" <product> | <sum> "-" <product>
<product>       ::= <unary> | <product> "*" <unary> | <product> "/" <unary> | <product> "%" <unary>
<unary>         ::= <primary> | "!" <unary> | "-" <unary>
<primary>       ::= IDENTIFIER | INT_CONST | FLOAT_CONST | CHAR_CONST | STRING_CONST
                  | "(" <expression> ")"
```

The expression rules reflect the precedence declared in `mpl.y`. Unary operators group from the right. Binary operators at the same precedence level group from the left, so `a - b - c` groups as `(a - b) - c`. Multiplication has higher precedence than addition, so `a + b * c` groups as `a + (b * c)`. Parentheses can override that grouping.
