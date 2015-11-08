#!/usr/bin/perl -w
#-------------------------------------------------------------------------------------------------------------------
#
#	This script is designed to pull Weather Data off of the web and parse it into a a format that is more
#	readable by the TemperaturePredictor program. 
#
#	Author:  Sam Benas
#	Last Updated: 11/08/2015
#
#	Note:  Still need to add the actual URL where we are getting out data from and add the code to parse each
#	line to make it more readable by our main program.  Should only take ~15 minutes once I knwo what the data
#	looks like.
#
#-------------------------------------------------------------------------------------------------------------------
use warnings;
use strict;

#Used in loops
my $num_days = 0;
my @months = ("Dummy 0th Month", "January", "February", "March", "April", "May", "June", 
	   "July", "August", "Septemter", "October", "November", "December");

#The base URL where we are getting our Data.  I don't actually know it yet.
my $data_url = "http://www.GiveMeTheWebsitePleaseAlex.com/";

#For data input/output
my $storage_directory = "RawData/";
my $host_location = "/afs/umbc.edu/users/s/b/sbenas1/home/CS455/Project/455Project/";
my $write_file = "TemperatureData.data";

#Output file where the parsed, year-long data will go.
open(OUTFILE, '>', "$host_location/$write_file") or die "FATAL: Could not open $write_file for writing.\n";


#Getting all of the stuff from the web.
#Loop through each month,
for(my $m = 1; $m <= 12; $m++){

	my $current_month = $months[$m];

	if ($m == 1 || $m == 3 || $m == 5 || $m == 7 || $m == 8 || $m == 10 || $m == 12){
		$num_days = 31;
	} elsif ($m == 2){
		$num_days = 28;
	} else {
		$num_days = 30;
	}

	#Loop through every day in current month
	for (my $d = 1; $d <= $num_days; $d++){

		#Doesn't currently work because I don't know what the URL is supposed to be.  Waiting on Alex to get back tom
		#system("wget -q $data_url -O $host_location/$storage_directory/$current_month" . "_" . "$d.data");
				
	}


}


#Now that data is retrieved, we want to parse it in order get one nice file that can be easily read by the main program.
opendir(DIR, "$host_location/$storage_directory") or die "FATAL: Could not open $storage_directory for reading.\n";
my @files = readdir(DIR);
foreach my $f (@files){

	next if (!($f =~ /\.data/));
	open(READ, "<", "$host_location/$storage_directory/$f") or die "FATAL: Could not open $f for reading.\n";
	while (my $l = <READ>){

		#This should parse the line first so it is something like "Number Of Minutes since Midnight, Jan 01st:Temperature in Fahrenheight"
		print OUTFILE $l;

	}
	close(READ) or warn "Warning: Could not close $f after reading.\n;

}


exit 0;
	
	

