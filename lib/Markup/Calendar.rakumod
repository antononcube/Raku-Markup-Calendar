use v6.d;

unit module Markup::Calendar;

use Text::Calendar;
use Data::Translators;

#===========================================================

sub process-decoration-specs($spec,
                             UInt :$year,
                             Str :$default-style) {
    my @stylePairs = do given $spec {

        when Empty {
            Empty
        }

        when $_.all ~~ UInt:D {
            ((1 ... 12).Array X=> $_.Array).flat.map({ Date.new($year, $_.key, $_.value) => $default-style })
        }

        when UInt:D {
            ((1 ... 12).Array X=> $_).map({ Date.new($year, $_.key, $_.value) => $default-style })
        }

        when $_ ~~ Str:D {
            # For each given weekday find its
            die "Handling of highlight specifications with weekday names or month names is not implemented yet."
        }

        when Hash:D {
            process-decoration-specs($_.pairs, :$year, :$default-style)
        }

        when $_.all ~~ Date:D {
            $_.map({ $_ => $default-style})
        }

        when $_.all ~~ Pair:D &&
                ([&&] $_.map({ $_.key ~~ UInt:D })) &&
                ([&&] $_.map({ ($_.value ~~ UInt:D) || ($_.value ~~ Iterable) })) {
            ## Should check validity and convert month names to integers
            my @specNew = $_.flat.map({ $_.value ~~ Iterable ?? ($_.key X=> $_.value.Array) !! $_ }).flat.Array;
            @specNew.map({ Date.new($year, $_.key, $_.value) => $default-style })
        }

        when $_.all ~~ Pair:D &&
                ([&&] $_.map({ $_.key ~~ Date:D })) &&
                ([&&] $_.map({ $_.value.isa(Whatever) || ($_.value ~~ Str:D) })) {
            $_.flat.map({ $_.key => ($_.value ~~ Whatever ?? $default-style !! $_.value) }).flat.Array
        }

        default {
            die "Do not know how to handle the given style specifiction."
        }
    }

    return @stylePairs.grep({ so $_.value }).Array;
}

#===========================================================
sub style-verification(@specs -->Bool) {
    return (@specs.all ~~ Pair:D) &&
            ([&&] @specs>>.key.map({ ($_ ~~ Date:D) })) &&
            (@specs>>.value.all ~~ Str:D);
}

#===========================================================

my $htmlDocStencil = q:to/END/;
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Calendar</title>
</head>
<body>
$BODY
</body>
</html>
END

#===========================================================
our proto calendar-html(|) {*}

multi sub calendar-html($year is copy,
                        $months is copy,
                        :h(:$highlight) = [],
                        :t(:$tooltip) = [],
                        :l(:$hyperlink) = [],
                        Str:D :s(:$highlight-style) = 'color:orange; font-size:12pt',
                        UInt :$per-row = 3,
                        Bool :doc(:$document) = False) {
    # Process months specs
    $months = Text::Calendar::process-month-specs($months, $year);

    return calendar-html($months, :$highlight, :$tooltip, :$hyperlink, :$highlight-style, :$per-row, :$document);
}

multi sub calendar-html($months is copy = Whatever,
                        :h(:$highlight) = [],
                        :t(:$tooltip) = [],
                        :l(:$hyperlink) = [],
                        Str:D :s(:$highlight-style) = 'color:orange; font-size:12pt',
                        UInt :$per-row = 3,
                        Bool :doc(:$document) = False) {
    # Process months specs
    $months = Text::Calendar::process-month-specs($months);

    die "The months argument is expected to be Whatever, a list of month names or integers between 1 and 12, or a list of year-month pairs."
    unless $months>>.value.all ~~ UInt:D && ([&&] $months>>.value.map({ 1 ≤ $_ ≤ 12 }));

    return calendar-html($months, :$highlight, :$tooltip, :$hyperlink, :$highlight-style, :$per-row, :$document);
}

multi sub calendar-html(@months is copy where @months.all ~~ Pair:D,
                        :h(:$highlight) = [],
                        :t(:$tooltip) = [],
                        :l(:$hyperlink) = [],
                        Str:D :s(:$highlight-style) = 'color:orange; font-size:12pt',
                        UInt :$per-row = 3,
                        Bool :doc(:$document) = False) {

    # Extract years
    my $year = @months>>.key.unique.first;

    # Process highlight
    my @highlightPairs = process-decoration-specs($highlight, :$year, default-style => $highlight-style);

    die 'The argument $highlight is expected to be a list of Date-string pairs, Date objects, month-day pairs, or positive integers.'
    unless style-verification(@highlightPairs);

    # Process tooltip
    my @tooltipPairs = process-decoration-specs($tooltip, :$year, default-style => '');

    die 'The argument $tooltip is expected to be a list of Date-string pairs, Date objects, month-day pairs, or positive integers.'
    unless style-verification(@tooltipPairs);

    # Process hyperlink
    my @hyperlinkPairs = process-decoration-specs($hyperlink, :$year, default-style => '');

    die 'The argument $hyperlink is expected to be a list of Date-string pairs, Date objects, month-day pairs, or positive integers.'
    unless style-verification(@hyperlinkPairs);

    # Year-month key making function
    my &ym-key = -> Pair:D $p { calendar-month-names()[$p.value-1] ~ ' ' ~ $p.key };

    # Make a table of month names
    my @colnames = (1 ... $per-row).map({ $_.Str }).Array;
    my $tbl = data-translation(@months.map({ &ym-key($_) }).rotor($per-row, :partial).map({ @colnames Z=> $_ })>>.Hash, field-names => @colnames);

    # Month datasets
    my %mbs = @months.map({ &ym-key($_) => calendar-month-dataset($_.key, $_.value) });

    # Make the HTML tables for each month
    %mbs = %mbs.map({ $_.key => to-html($_.value, field-names => calendar-weekday-names) });

    my %decorations = @highlightPairs.Hash.map({ $_.key => (style => $_.value) }).Hash;
    %decorations .= push(@tooltipPairs.Hash.map({ $_.key => (tooltip => $_.value) }));
    %decorations .= push(@hyperlinkPairs.Hash.map({ $_.key => (hyperlink => $_.value) }));

    # Place highlights
    for %decorations.kv -> $k, $s {
        my $d = Date.new($k);
        my %s = $s;

        my $t = %s<tooltip>.defined ?? 'title="' ~ %s<tooltip> ~ '" ' !! '';

        my $v = $d.day;
        with %s<hyperlink> {
            $v = '<a href="' ~ %s<hyperlink> ~ '">' ~ $v ~ '</a>';
        }

        if %mbs{&ym-key($d.year => $d.month)}:exists {
            %mbs{&ym-key($d.year => $d.month)} .=
                    subst('<td>' ~ $d.day ~ '</td>',
                            '<td><span ' ~ $t ~ 'style="' ~ %s<style> ~ '">' ~ $v ~ '</span></td>');
        }
    }

    # Fill in the table of month names
    my $tbl2 = $tbl;
    for %mbs.kv -> $k, $v {
        $tbl2 .= subst($k, '<h3>' ~ $k ~ '</h3>' ~ $v)
    }
    $tbl2 .= subst(/ '<thead>' .*? '</thead>'/);
    $tbl2 = '<style>td { vertical-align: top;a}</style>' ~ $tbl2;

    # Result
    if $document {
        return $htmlDocStencil.subst('$BODY', $tbl2);
    }
    return $tbl2;
}

#===========================================================

multi sub calendar(**@args, *%args where (%args<format> // 'None') eq 'html') {
    return calendar-html(|@args, |%args.grep({ $_.key ne 'format' }).Hash);
}

#===========================================================
our proto calendar-year-html(|) {*}

multi sub calendar-year-html($year is copy = Whatever,
                             :h(:$highlight) = [],
                             :t(:$tooltip) = [],
                             :l(:$hyperlink) = [],
                             Str:D :s(:$highlight-style) = 'color:orange; font-size:12pt',
                             UInt :$per-row = 3,
                             Bool :doc(:$document) = False) {
    if $year.isa(Whatever) { $year = Date.today.year; }
    return calendar-year-html(:$year, :$highlight, :$tooltip, :$hyperlink, :$highlight-style, :$per-row, :$document);
}

multi sub calendar-year-html(:$year is copy = Whatever,
                             :h(:$highlight) = [],
                             :t(:$tooltip) = [],
                             :l(:$hyperlink) = [],
                             Str:D :s(:$highlight-style) = 'color:orange; font-size:12pt',
                             UInt :$per-row = 3,
                             Bool :doc(:$document) = False) {

    if $year.isa(Whatever) { $year = Date.today.year; }

    # Delegate
    my $tbl = calendar-html($year, 1 .. 12, :$highlight, :$tooltip, :$hyperlink, :$highlight-style, :$per-row, :!document);
    $tbl .= subst($year):g;
    $tbl = '<h2>' ~ $year ~ '</h2>' ~ $tbl;

    # Result
    if $document {
        return $htmlDocStencil.subst('$BODY', $tbl);
    }
    return $tbl;
}

#===========================================================

multi sub calendar-year(**@args, *%args where (%args<format> // 'None') eq 'html') {
    return calendar-year-html(|@args, |%args.grep({ $_.key ne 'format' }).Hash);
}