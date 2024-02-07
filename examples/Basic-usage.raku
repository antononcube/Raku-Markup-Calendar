#!/usr/bin/env raku
use v6.d;

use lib '.';

use Text::Calendar;
use Markup::Calendar;

say calendar-year(method=>'html', per-row=>5,);

spurt "example.html", Markup::Calendar::calendar-year-html(2022, [2, 24,], s => 'color:red'):doc;
