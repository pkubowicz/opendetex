#!/usr/bin/perl -w

assert_produces_correct_output();
run_for_wrong_input("non-existent-file");
run_for_wrong_input("non-existent-file.tex");
run_for_wrong_input("non-existent-file.txt");
run_for_wrong_input("test/unterminated.txt");

print "Tests ok\n";

sub assert_produces_correct_output {
	print "Checking correct output is produced...\n";
	chdir 'test';
	execute_cmd("../delatex in > /tmp/testDelatex.txt");
	my $diffResult = `diff correct.txt /tmp/testDelatex.txt`;

	if ($diffResult ne '') {
		print "Test failed:\n";
		my $compared = "correct.txt /tmp/testDelatex.txt";
		if (`which kdiff3`) {
			system("kdiff3 $compared");
		} elsif (`which vimdiff`) {
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
