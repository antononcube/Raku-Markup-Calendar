#!/usr/bin/env raku
use v6.d;

use lib '.';

use Text::Calendar;
use Markup::Calendar;

spurt "example1.html",
        calendar-year(format => 'html', per-row => 3, highlight => [2 => (2, 4 ... 28), 5 => 24,]):doc;

spurt "example2.html",
        Markup::Calendar::calendar-year-html(2022,
                [Date.new(2022, 3, 3) => 'font-size:14pt; color:green', Date.new(2022, 5, 24) => Whatever ],
                s => 'color:red',
                :doc);
