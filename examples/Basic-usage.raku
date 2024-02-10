#!/usr/bin/env raku
use v6.d;

use lib '.';

use Text::Calendar;
use Markup::Calendar;

spurt "example1.html",
        Markup::Calendar::calendar-html(per-row => 3, highlight => [2 => (2, 4 ... 28), 5 => 24,]):doc;

spurt "example2.html",
        calendar-year(format => 'html', per-row => 3, highlight => [2 => (2, 4 ... 28), 5 => 24,]):doc;

spurt "example3.html",
        Markup::Calendar::calendar-year-html(2022,
                highlight => [Date.new(2022, 3, 3) => 'font-size:14pt; color:green',
                              Date.new(2022, 5, 24) => Whatever],
                tooltip => [Date.new(2022, 3, 3) => 'Freedom from Ottoman slavery',
                            Date.new(2022, 5, 24) => 'Bulgarian culture'],
                hyperlink => [Date.new(2022, 3, 3) => 'https://en.wikipedia.org/wiki/Liberation_Day_(Bulgaria)',
                              Date.new(2022, 5, 24) => 'https://en.wikipedia.org/wiki/Day_of_Slavonic_Alphabet,_Bulgarian_Enlightenment_and_Culture'],
                s => 'color:red',
                :doc);
