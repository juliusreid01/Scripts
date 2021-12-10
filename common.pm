################################################################################
# 
# Author: jreid
# Created: 08/23/2021
# 
# Description:
#     Common functions that may be used in various perl scripts
#
# Notes:
#
################################################################################

#package common;

#use Data::Dumper;

my %config = (prompt_retry  => 3,        # integer value for the number of times a prompt will allow bad responses
	      prompt_out    => 'STDOUT', # either STDOUT or STDERR
	      prompt_attr   => '1;93m'   # attributes to use when printing the prompt
             );

## PrintColorArray();
## print YesNo("Did we see all colors?");

################################################################################
# sub UImsg
# prints a message to the screen using the above config settings
################################################################################
sub UImsg {
    if( $config{prompt_out} eq 'STDERR' ) {
        print STDERR "\e[$config{prompt_attr}$_[0]\e[0m";
    }
    else {
        print "\e[$config{prompt_attr}$_[0]\e[0m";
    }
} # sub UImsg

################################################################################
# sub YesNo
# prompt the user the input message and wait for a yesno response
################################################################################
sub YesNo {
    my $msg  = shift;
    my $cnt  = $config{prompt_retry};
    my $resp = ''; 

    UImsg("$msg (yes/no) ");
    do {
        $resp = lc <STDIN>;
        if( $resp =~ /^ye?s?$/ ) { 
	    return 1; 
	}
	elsif( $resp =~ /^no?$/ ) { 
	    return 0; 
	}
	else {
	    UImsg("Please enter yes or no ");
	    $cnt -= 1;
        }
    } while ($cnt > 0);

    UImsg("After $config{prompt_retry} I give up, smh\n");
    return -1;
} # sub YesNo

################################################################################
# determine the author
################################################################################
sub getAuthor { 
    chomp(my $author = `whoami`); 
    # user name mapping
    return 'J Reid' if $author eq 'jreid';
    return $author; 
} # sub getAuthor

################################################################################
# determine the date (TODO. move to common script)
################################################################################
sub getDate {
    my ($day, $month, $year) = (localtime)[3..5];
    return sprintf("%02d/%02d/%04d", $month + 1, $day, $year + 1900);
} # sub getDate

################################################################################
# sub PrintColorArray
# This sub routine will print the color array 
# assumes an 80 character width window, will print to STDERR
################################################################################
sub PrintColorArray {
    # text appearance modifiers - for reference 
    ## my %modifiers = ( bold       => 1,
    ##                   dim        => 2,
    ## 		         italic     => 3,
    ## 		         underline  => 4,
    ## 		         blink      => 5, # 6 also worked on my ubuntu machine
    ##                   inverse    => 7, # as in swap foreground background
    ## 		         hidden     => 8, # i.e. for passwords
    ## 		         strikeout  => 9 );
    # the resets are 
    # 0 - for all, +20 for an individual thing
    # active modifier
    my $active_modifer = '';

    # 8/16 colors
    print '+' x 80;
    print "\n    Printing 8/16 color sets\n";
    for my $i (30..37) {
        printf "\e[%s%sm %3d\e[0m", $active_modifier, $i, $i;
    }
    print "\n";
    for my $i (90..97) {
        printf "\e[%s%sm %3d\e[0m", $active_modifier, $i, $i;
    }
    print "\n";
    for my $i (40..47) {
        printf "\e[%s%sm %3d\e[0m", $active_modifier, $i, $i;
    }
    print "\n";
    for my $i (100..107) {
        printf "\e[%s%sm %3d\e[0m", $active_modifier, $i, $i;
    }
    print "\n";

    # assuming we can display 256 colors for this
    print '+' x 80;
    print "\n    Printing 88/256 color sets\n";
    for my $i ( 0..255 ) {
        printf "\e[%s38;5;%sm %3d\e[%0m", $active_modifier, $i, $i;
	printf "\n" if ($i+1) % 16 == 0;
    }
    for my $i ( 0..255 ) {
        printf "\e[%s48;5;%sm %3d\e[%49m", $active_modifier, $i, $i;
	printf "\e[0m\n" if ($i+1) % 16 == 0;
    }
} # PrintColorArray

#print "\n";
#return 1
