use v6.d;

unit module Markup::Calendar;

use Text::Calendar;
use Data::Translators;

#===========================================================

sub process-highlight-specs(UInt $year, $highlight) {
    my @highPairs = do given $highlight {

        when Empty {
            Empty
        }

        when $_.all ~~ UInt:D {
            (1 ... 12).Array X=> $_.Array
        }

        when UInt:D {
            (1 ... 12).Array X=> $_.Array
        }

        when $_ ~~ Str:D {
            # For each given weekday find its
            die "Handling of highlight specifications with weekday names or month names is not implemented yet.";
        }

        when Hash:D {
            process-highlight-specs($year, $_.pairs)
        }

        when $_.all ~~ Date:D {
            $_.map({ $_.year == $year ?? ($_.month => $_.day) !! Empty })
        }

        when $_.all ~~ Pair:D {
            ## Should check validity and convert month names to integers
            $_.flat.map({ $_.value ~~ Iterable ?? ($_.key X=> $_.value.Array) !! $_ }).flat.Array
        }

        default {
            die "Do not know how to handle the given highlight specifiction."
        }
    }

    return @highPairs;
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
                             Str:D :s(:$highlight-style) = 'color:orange; font-size:12pt',
                             UInt :$per-row = 3,
                             Bool :doc(:$document) = False) {
    return calendar-year-html(:$year, :$highlight, :$highlight-style, :$per-row, :$document);
}

multi sub calendar-year-html(:$year is copy = Whatever,
                             :h(:$highlight) = [],
                             Str:D :s(:$highlight-style) = 'color:orange; font-size:12pt',
                             UInt :$per-row = 3,
                             Bool :doc(:$document) = False) {

    # Process year
    if $year.isa(Whatever) { $year = Date.today.year; }

    die 'The argument $year expected to be a non-negative integer.'
    unless $year ~~ UInt:D;

    # Process highlight
    my @highPairs = process-highlight-specs($year, $highlight);

    die 'The argument $highlights is expected to be a list of month-day pairs, positive integers, or Date objects.'
    unless (@highPairs.all ~~ Pair:D) &&
            ([&&] @highPairs>>.key.map({ ($_ ~~ UInt:D) && 1 ≤ $_ ≤ 12 })) &&
            (@highPairs>>.value.all ~~ UInt:D);

    # Process year
    if $year.isa(Whatever) { $year = Date.today.year; }

    # Make a table of month names
    my @colnames = (1 ... $per-row).map({ $_.Str }).Array;
    my $tbl = data-translation(calendar-month-names.rotor($per-row, :partial).map({ @colnames Z=> $_ })>>.Hash, field-names => @colnames);

    # Month datasets
    my %mbs = calendar-month-names.map({ $_ => calendar-month-dataset($year, $_) });

    # Max number of rows of the datasets
    my $maxRows = %mbs.map({ $_.value.elems }).max;

    # Empty row to fill in
    my %emptyRow = calendar-weekday-names() X=> "";

    # Make the HTML tables for each month
    # The following "manual" correction is not needed if style is used
    #%mbs = %mbs.map({ $_.key => to-html($_.value.elems < $maxRows ?? $_.value.push(%emptyRow) !! $_.value, field-names => calendar-weekday-names) });
    %mbs = %mbs.map({ $_.key => to-html($_.value, field-names => calendar-weekday-names) });

    # Place highlights
    for @highPairs -> $p {
        if 1 ≤ $p.key ≤ 12 {
            %mbs{calendar-month-names()[$p.key - 1]} .=
                    subst('<td>' ~ $p.value ~ '</td>',
                            '<td><span style="' ~ $highlight-style ~ '">' ~ $p.value ~ '</span></td>');
        }
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