# Markup::Calendar

Raku package with Markup (HTML, Markdown) calendar functions for displaying monthly, yearly, and custom calendars.

### Motivation

The package 
["Text::Calendar"](https://raku.land/zef:antononcube/Text::Calendar), [AAp1], 
provides the core functions for making the calendars in this package.
The packages 
["Data::Translators"](https://raku.land/zef:antononcube/Data::Translators), [AAp2], and 
["Pretty::Table"](https://raku.land/cpan:ANTONOV/Pretty::Table), [ULp1],
provide additional formatting functionalities.

I want to keep "Text::Calendar" lightweight, without any dependencies. Hence I made this separate 
package, "Markup::Calendar", that has more involved dependencies and use-cases.

An "involved use case" is calendar in which some of the days have tooltips and hyperlinks. 

-----

## Installation

From [Zef ecosystem](https://raku.land):

```
zef install Markup::Calendar
```

From GitHub:

```
zef install https://github.com/antononcube/Raku-Markup-Calendar.git
```

-----

## Examples

### Basic HTML calendar

```raku, results=asis
use Markup::Calendar;
use Text::Calendar;

calendar():html
```

### HTML yearly calendar with highlights 

Here is an HTML calendar that weekend days are highlighted and with larger font:

```raku, results=asis
calendar-year( 
    per-row => 4, 
    highlight => (Date.new(2024,1,1)...Date.new(2024,12,31)).grep({ $_.day-of-week ≥ 6 }),
    highlight-style => 'color:orange; font-size:14pt'
):html
```

### Standalone calendar file

Here we make a standalone calendar file:

```raku
spurt('example.html', calendar-year(year => 2024, highlight => [3=>3, 5=>24, 9=>9], highlight-style=>'color:red', format=>'html'))
```

------

## TODO

- [ ] TODO Features
  - [X] DONE HTML
    - [X] DONE Full HTML calendar 
    - [X] DONE Partial HTML calendar (e.g. equivalent of `cal -3`)
    - [X] DONE Highlighted days
    - [X] DONE Tooltips for days
    - [X] DONE Hyperlinks for days
  - [ ] TODO Markdown
    - [ ] TODO Full Markdown calendar
    - [ ] TODO Partial Markdown calendar
    - [ ] TODO Highlighted days
    - [ ] TODO Tooltips for days
    - [ ] TODO Hyperlinks for days
- [ ] Unit tests
  - [ ] DONE Basic usage
  - [ ] DONE Equivalence using different signatures
  - [ ] TODO Correctness
- [ ] Documentation
  - [X] DONE Basic README
  - [ ] TODO Diagrams
  - [ ] TODO Comparisons

------

## References 

[AAp1] Anton Antonov,
[Text::Calendar Raku package](https://github.com/antononcube/Raku-Text-Calendar),
(2024),
[GitHub/antononcube](https://github.com/antononcube).

[AAp2] Anton Antonov,
[Data::Translators Raku package](https://github.com/antononcube/Raku-Data-Translators),
(2023),
[GitHub/antononcube](https://github.com/antononcube).

[LUp1] Luis F. Uceta,
[Pretty::Table Raku package](https://gitlab.com/uzluisf/raku-pretty-table/),
(2020),
[GitLab/uzluisf](https://gitlab.com/uzluisf/).


