#!/usr/bin/perl

sub select_path {
    return `find ~/projects ~/work -mindepth 1 -maxdepth 3 -type d | fzf`
}

sub goto_session {
    my $name = $_[0];
    exec "tmux switch-client -t \"$name\"";
}

sub new_session  {
    my ($path, $name) = @_;
    system "tmux new-session -s $name -c $path";
}

sub append_project {
    my ( $path,  $name ) = @_;
    my @list =  split( '/', $path );
    my $length = grep !/branches|${name}/, @list;
    my @new_list = @list[0..$length - 1];
    return "${new_list[-1]}/$name";
}

my $path = select_path();
my $name = ( split('/', $path))[-1];
$name = substr($name, 0 , -1);

if ($path =~ /\/branches\/$name/) {
    $name = append_project($path, $name);
}

if (not `tmux ls 2>&1` =~ /^$name:\s/m) {
    new_session($path, $name);
}

goto_session($name);
exit 0;


