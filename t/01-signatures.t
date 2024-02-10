use v6.d;

use Markup::Calendar;
use Test;

plan *;

## 1
is
        Markup::Calendar::calendar-year-html(2024, [1, 11, 22]),
        Markup::Calendar::calendar-year-html(year => 2024, highlight => [1, 11, 22]),
        "Equivalence for different signatures 1";

## 2
is
        Markup::Calendar::calendar-year-html(2024, [1, 11, 22]),
        Markup::Calendar::calendar-year-html(year => 2024, highlight => [1, 11, 22]),
        "Equivalence for different signatures 2";

## 3
is
        Markup::Calendar::calendar-year-html(2024, [1, 11, 22]),
        Markup::Calendar::calendar-year-html(year => 2024, highlight => [1, 11, 22]),
        "Equivalence for different signatures 3";

## 4
ok Markup::Calendar::calendar-year-html(2022,
        highlight => [Date.new(2022, 3, 3) => 'font-size:14pt; color:green',
                      Date.new(2022, 5, 24) => Whatever],
        tooltip => [Date.new(2022, 3, 3) => 'Freedom from Ottoman slavery',
                    Date.new(2022, 5, 24) => 'Bulgarian culture'],
        hyperlink => [Date.new(2022, 3, 3) => 'https://en.wikipedia.org/wiki/Liberation_Day_(Bulgaria)',
                      Date.new(2022, 5, 24) => 'https://en.wikipedia.org/wiki/Day_of_Slavonic_Alphabet,_Bulgarian_Enlightenment_and_Culture'],
        s => 'color:red',
        :doc);

done-testing;
