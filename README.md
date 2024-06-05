This was built based on the [ script of ThePrimeagen ](https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer)
. However, this version is aware of path that are git work tree and append the
branch name to the session name

At first I have tried writing using alternatives to bash, as the syntax is not
great and documentation available online is terrible. Ocaml, Perl, Python was put
on the test, but there were no result, and that I was seriously upset.

A Perl script is included but I can only make it work outside of tmux, even though
this seem to be the most promising of the bunch.
