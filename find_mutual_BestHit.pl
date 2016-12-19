#! /bin/env perl

use strict;

my $usage = <<USAGE;

    Usage: $0 a_v_b.blast b_v_a.blast output.tab
    
USAGE

if ($#ARGV < 2) {
    die $usage;
}

my %avb;
my %bva;

open (AVB, "$ARGV[0]") or die $!;
my $line = <AVB>;
while ($line = <AVB>) {
    chomp($line);
    my ($q_id, $d_id) = split(/\t/, $line);
	if (not exists $avb{$q_id}) {
	    $avb{$q_id} = $d_id;
	}
}
close(AVB);

open (BVA, "$ARGV[1]") or die $!;
while ($line = <BVA>) {
    chomp($line);
    my ($q_id, $d_id) = split(/\t/, $line);
	if (not exists $bva{$q_id}) {
	    $bva{$q_id} = $d_id;
	}
}
close(AVB);

open (OUF, ">$ARGV[2]") or die $!;
print OUF $ARGV[0],"\t",$ARGV[1],"\n";
foreach my $seqid (keys %avb) {
    if ($bva{$avb{$seqid}} eq $seqid) {
        print OUF $avb{$seqid},"\t",$seqid,"\n";
    }
}
