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
our proto calendar-year-html(|) {*}

multi sub calendar-year-html($year is copy = Whatever,
                             $highlight = [],
                             :t(:$tooltip) = [],
                             :l(:$hyperlink) = [],
                             Str:D :s(:$highlight-style) = 'color:orange; font-size:12pt',
                             UInt :$per-row = 3,
                             Bool :doc(:$document) = False) {
    return calendar-year-html(:$year, :$highlight, :$tooltip, :$hyperlink, :$highlight-style, :$per-row, :$document);
}

multi sub calendar-year-html($year is copy = Whatever,
                             :h(:$highlight) = [],
                             :t(:$tooltip) = [],
                             :l(:$hyperlink) = [],
                             Str:D :s(:$highlight-style) = 'color:orange; font-size:12pt',
                             UInt :$per-row = 3,
                             Bool :doc(:$document) = False) {
    return calendar-year-html(:$year, :$highlight, :$tooltip, :$hyperlink, :$highlight-style, :$per-row, :$document);
}

multi sub calendar-year-html(:$year is copy = Whatever,
                             :h(:$highlight) = [],
                             :t(:$tooltip) = [],
                             :l(:$hyperlink) = [],
                             Str:D :s(:$highlight-style) = 'color:orange; font-size:12pt',
                             UInt :$per-row = 3,
                             Bool :doc(:$document) = False) {

    # Process year
    if $year.isa(Whatever) { $year = Date.today.year; }

    die 'The argument $year expected to be a non-negative integer.'
    unless $year ~~ UInt:D;

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

    # Process year
    if $year.isa(Whatever) { $year = Date.today.year; }

    # Make a table of month names
    my @colnames = (1 ... $per-row).map({ $_.Str }).Array;
    my $tbl = data-translation(calendar-month-names.rotor($per-row, :partial).map({ @colnames Z=> $_ })>>.Hash, field-names => @colnames);

    # Month datasets
    my %mbs = calendar-month-names.map({ $_ => calendar-month-dataset($year, $_) });

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

        %mbs{calendar-month-names()[$d.month - 1]} .=
                subst('<td>' ~ $d.day ~ '</td>',
                        '<td><span ' ~ $t ~ 'style="' ~ %s<style> ~ '">' ~ $v ~ '</span></td>');
    }

    # Fill in the table of month names
    my $tbl2 = $tbl;
    for %mbs.kv -> $k, $v {
        $tbl2 .= subst($k, '<h3>' ~ $k ~ '</h3>' ~ $v)
    }
    $tbl2 .= subst(/ '<thead>' .*? '</thead>'/, '<h2>' ~ $year ~ '</h2>');
    $tbl2 = '<style>td { vertical-align: top;a}</style>' ~ $tbl2;

    # Result
    if $document {
        return $htmlDocStencil.subst('$BODY', $tbl2);
    }
    return $tbl2;
}

#===========================================================

multi sub calendar-year(**@args, *%args where (%args<format> // 'None') eq 'html') {
    return calendar-year-html(|@args, |%args.grep({ $_.key ne 'format' }).Hash);
}