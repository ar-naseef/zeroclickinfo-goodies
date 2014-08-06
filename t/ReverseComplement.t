#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use DDG::Test::Goodie;

zci answer_type => 'reversecomplement';
zci is_cached => 1;

ddg_goodie_test(
	[qw(
		DDG::Goodie::ReverseComplement
	)],

  #Basic DNA reverse complements, various trigger combinations
	'AAAACCCGGT reverse complement' => test_zci("ACCGGGTTTT", html => qr/ACCGGGTTTT/),
	'reverse complement of TTTGATCATGGCTCAGGACGAACGCTGGCGGCGT' => test_zci("ACGCCGCCAGCGTTCGTCCTGAGCCATGATCAAA", html => qr/ACGCCGCCAGCGTTCGTCCTGAGCCATGATCAAA/),
	'AAAACCCGGT revcomp' => test_zci("ACCGGGTTTT", html => qr/ACCGGGTTTT/),
	'revcomp AAAACCCGGT' => test_zci("ACCGGGTTTT", html => qr/ACCGGGTTTT/),
	'revcomp of AAAACCCGGT' => test_zci("ACCGGGTTTT", html => qr/ACCGGGTTTT/),
	'DNA revcomp of sequence AAAACCCGGT' => test_zci("ACCGGGTTTT", html => qr/ACCGGGTTTT/),
	'reverse complement of RNA sequence AAAACCCGGU' => test_zci("ACCGGGTTTT", html => qr/ACCGGGTTTT/),

  #RNA reverse complement with acceptable spacing characters
	'reverse complement uca gac gga' => test_zci("TCCGTCTGA", html => qr/TCCGTCTGA/),
	'reverse complement of nucleotide sequence uca-gac-gga' => test_zci("TCCGTCTGA", html => qr/TCCGTCTGA/),

  #With ambiguous bases (both DNA and RNA)
	'reverse complement TCAAAWWDGGATTAMATACCCTGGTAGTCCACRCCATAAACGATGTATGCTTGGTGRGVGTGAGTAATCACTCAGTMCGAAGGCAACCTGATAAGCATACCKCCTVGAGTACGATCSCAAGGTTGAAACTCA DNA sequence' => test_zci("TGAGTTTCAACCTTGSGATCGTACTCBAGGMGGTATGCTTATCAGGTTGCCTTCGKACTGAGTGATTACTCACBCYCACCAAGCATACATCGTTTATGGYGTGGACTACCAGGGTATKTAATCCHWWTTTGA", html => qr/TGAGTTTCAACCTTGSGATCGTACTCBAGGMGGTATGCTTATCAGGTTGCCTTCGKACTGAGTGATTACTCACBCYCACCAAGCATACATCGTTTATGGYGTGGACTACCAGGGTATKTAATCCHWWTTTGA/),
	'reverse complement CUAKCCAAGCCGACGASUCGGUAGCUGGUCUGAGAGKGACGAACAGCCACACUGGAACUGAGACAYCGGUCCAGACUCCUACGGGAGGCAGCAGUGAGGAAUAUUGGUCAAKUGGACRGCAAGUCUGAACCAYGCGACGRCGCGUGCGGGAUGAAGGGGCUUAGCCUCGUAAACDCGCURGUCAAGAGGGACGAGAGGHGCGAUUUUGUMCGUCCGGGWWACGV' => test_zci("BCGTWWCCCGGACGKACAAAATCGCDCCTCTCGTCCCTCTTGACYAGCGHGTTTACGAGGCTAAGCCCCTTCATCCCGCACGCGYCGTCGCRTGGTTCAGACTTGCYGTCCAMTTGACCAATATTCCTCACTGCTGCCTCCCGTAGGAGTCTGGACCGRTGTCTCAGTTCCAGTGTGGCTGTTCGTCMCTCTCAGACCAGCTACCGASTCGTCGGCTTGGMTAG", html => qr/BCGTWWCCCGGACGKACAAAATCGCDCCTCTCGTCCCTCTTGACYAGCGHGTTTACGAGGCTAAGCCCCTTCATCCCGCACGCGYCGTCGCRTGGTTCAGACTTGCYGTCCAMTTGACCAATATTCCTCACTGCTGCCTCCCGTAGGAGTCTGGACCGRTGTCTCAGTTCCAGTGTGGCTGTTCGTCMCTCTCAGACCAGCTACCGASTCGTCGGCTTGGMTAG/),

  #Mix of DNA and RNA bases (should return empty, as it is more likely that this
  # is an error than one of the edge cases of uracil-containing DNA)
	'reverse complement AAATTTCCCGGGUUU' => undef,
  
  #Non-nucleic acid query strings (should return empty, no idea what they wanted)
	'reverse complement hello-this-is-DNA' => undef,
        'DNA reverse complement' => undef,

);

done_testing;

