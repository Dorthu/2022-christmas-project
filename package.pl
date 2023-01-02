#!/usr/bin/perl

$GAME_NAME = "untitled-2";

print "Clear export dir? [y/N]? ";
$answer = <STDIN>;
chomp $answer;

unless($answer =~ /^[yY]$/) {
    print "Aborting\n";
    exit 0;
}

print "Cleaning export directory..\n";
`rm export/*`;

$export_dir = `pwd`;
chomp $export_dir;
$export_dir .= "/export";

print "Please run export in Godot.  Make sure your export dir is '$export_dir'\n";
print "Press enter to continue.";

$answer = <STDIN>;

print "Creating zip file for itch.io..\n";

$original_name = `ls export | grep '.html'`;
chomp $original_name;
`mv export/$original_name export/index.html`;
`zip export/upload.zip export/*`;

print "Zip file created at $export_dir/upload.zip!\n";

print "Ready to upload? [y/N]? ";
$answer2 = <STDIN>;
chomp $answer2;

if($answer2 =~ /^[yY]$/) {
    `butler push export/upload.zip dorthu/$GAME_NAME:html5`;
    print "Upload complete!\n";
} else {
    print "That's fine.  To upload it later, run ' butler push export/upload.zip dorthu/$GAME_NAME:html5'\n";
}
