#!/bin/perl

my %tags;

$state = 0;
for $line (<>) {
    if ($state == 0 and $line =~ /^Reference name$/) {
        $state = 1;
    } elsif ($state == 1 and $line =~ /^<(.*?)\/?>/) {
        $longName = $1;
        $state = 2;
    } elsif ($state == 2 and $line =~ /^<(.*?)\/?>/) {
        $shortName = $1;
        if ($shortName =~ /^(ONIX|[a-z])/) {
            $tags{$longName} = $shortName;
            $state = 0;
        }
    }
}

print <<END;
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE element [
    <!ELEMENT map (element+)>
    <!ELEMENT element EMPTY>
    <!ATTLIST element
        long NMTOKEN #REQUIRED
        short NMTOKEN #REQUIRED
    >
]>
<map>
END
for $longName (sort keys %tags) {
    $shortName = $tags{$longName};
    print <<END;
    <element long="$longName" short="$shortName"/>
END
}
print <<END;
</map>
END
