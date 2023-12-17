#!/usr/bin/perl -w

use strict;

use File::stat;

assert_produces_correct_output('in.tex', 'correct.txt');
assert_produces_correct_output('in.tex', 'correct.txt', '-l');
assert_produces_correct_output('noinclude.tex', 'noinclude-correct.txt', '-n');
assert_produces_correct_output('words.tex', 'words-correct.txt', '-w');
assert_produces_correct_output('words.tex', 'words-correct.txt', '-w -l');
assert_produces_correct_output('nouns.tex', 'nouns-correct.txt', '-r');
assert_produces_correct_output('with-srcloc.tex', 'with-srcloc-correct.txt', '-1');
assert_produces_correct_output('comments.tex', 'comments-correct.txt');

run_for_wrong_input("non-existent-file");
run_for_wrong_input("non-existent-file.tex");
run_for_wrong_input("non-existent-file.txt");
run_for_wrong_input("test/unterminated.tex");
run_for_wrong_input("test/unterminated-verb-pipe.tex");

run_for_input_with_error("test/unterminated-verb.tex");
run_for_input_with_error("test/unterminated-verb-eol.tex");

fuzz();

print "Tests ok\n";

sub assert_produces_correct_output {
	my ($input, $correct, $options) = @_;
	$options ||= '';
	my $options_desc = $options ? " ($options)" : '';
	print "Checking correct output is produced for $input->$correct$options_desc...\n";
	chdir 'test';
	execute_cmd("../delatex $options $input > /tmp/testDelatex.txt");
	my $compared = "$correct /tmp/testDelatex.txt";
	my $diffResult = `diff $compared 2>&1`;

	if ($diffResult ne '') {
		print "Test failed:\n";
		if (`which kdiff3`) {
			system("kdiff3 $compared");
		} elsif (!$ENV{CI} && `which vimdiff`) {
			system("vimdiff $compared");
		} else {
			system("diff -u $compared");
		}
		exit(11);
	}
	chdir '..'
}

sub run_for_wrong_input {
	my ($input) = @_;
	print "Checking response for $input...\n";
	execute_cmd("./delatex $input");
}

sub run_for_input_with_error {
	my ($input) = @_;
	print "Checking response for $input...\n";
	# https://www.perlmonks.org/?node_id=81640
	my $res = system(get_cmd("./delatex $input")) >> 8;
	die "exit code $res" if ($res != 1);
}

sub fuzz {
	chdir 'test';
	my $input = 'in.tex';
	my $sb = stat($input);
	for (my $i=0; $i<25; ++$i) {
		my $bytes = int(rand($sb->size));
		printf("Fuzz: bytes %5d/%5d of %s. ", $bytes, $sb->size, $input);
		system("head -c $bytes $input > /tmp/trunc.tex");
		my $res = system(get_cmd("../delatex /tmp/trunc.tex > /tmp/trunc.log")) >> 8;
		print "Exit code $res\n";
		if ($res != 0 && $res != 1) {
			die;
		}
	}
}

sub execute_cmd {
	my ($cmd) = @_;
	my $res = system(get_cmd($cmd));
	die "exit code $res" if ($res != 0);
}

sub get_cmd {
	my ($cmd) = @_;
	if ($ARGV[0] && $ARGV[0] eq '--valgrind') {
		$cmd = "valgrind --leak-check=yes --leak-check=full --error-exitcode=1 $cmd";
	}
	return $cmd;
}
