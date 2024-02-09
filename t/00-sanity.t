use v6.d;

use Markup::Calendar;
use Text::Calendar;
use Test;

plan *;

## 1
ok Markup::Calendar::calendar-year-html();

## 2
ok calendar-year(format => 'html');

## 3
ok calendar-year(2024, [3 => 3, 5 => 24, 9 => 9], format => 'html');

## 4
ok calendar-year(2024, [1, 11, 22], format => 'html');

## 5
ok calendar-year(Whatever, [Date.today.earlier(days => 1), Date.today, Date.today.later(days => 1)], format => 'html');

## 6
my @p6 = Date.today.earlier(days => 1) => 'color:red',
         Date.today => Whatever,
         Date.today.later(days => 1) => 'color:blue';

ok calendar-year(Whatever, @p6, format => 'html');

done-testing;
