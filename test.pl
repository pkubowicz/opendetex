#!/usr/bin/perl -w

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
run_for_wrong_input("test/unterminated.txt");

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

sub execute_cmd {
	my ($cmd) = @_;
	system(get_cmd($cmd)) == 0 or die;
}

sub get_cmd {
	my ($cmd) = @_;
	if ($ARGV[0] && $ARGV[0] eq '--valgrind') {
		$cmd = "valgrind --leak-check=yes --leak-check=full --error-exitcode=1 $cmd";
	}
	return $cmd;
}
