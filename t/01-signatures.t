use v6.d;

use Markup::Calendar;
use Text::Calendar;
use Test;

plan *;

## 1
is
        Markup::Calendar::calendar-html(2024, (1..4).Array),
        Markup::Calendar::calendar-html([2024 => 1, 2024 => 2, 2024 => 3, 2024 => 4]),
        "Equivalence for different signatures 1";

## 2
is
        Markup::Calendar::calendar-html((1..4).Array),
        Markup::Calendar::calendar-html([2024 => 1, 2024 => 2, 2024 => 3, 2024 => 4]),
        "Equivalence for different signatures 2";

## 3
ok Markup::Calendar::calendar-year-html(2022,
        highlight => [Date.new(2022, 3, 3) => 'font-size:14pt; color:green',
                      Date.new(2022, 5, 24) => Whatever],
        tooltip => [Date.new(2022, 3, 3) => 'Freedom from Ottoman slavery',
                    Date.new(2022, 5, 24) => 'Bulgarian culture'],
        hyperlink => [Date.new(2022, 3, 3) => 'https://en.wikipedia.org/wiki/Liberation_Day_(Bulgaria)',
                      Date.new(2022, 5, 24) => 'https://en.wikipedia.org/wiki/Day_of_Slavonic_Alphabet,_Bulgarian_Enlightenment_and_Culture'],
        s => 'color:red',
        :doc);

## 4
is
        calendar(1..4):html,
        calendar(1..4, format => 'html'),
        "Equivalence for different signatures, adverb :html, 1";


## 4
is
        calendar-year():html,
        calendar-year(format => 'html'),
        "Equivalence for different signatures, adverb :html, 2";


done-testing;
