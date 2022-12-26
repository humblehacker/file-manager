# Synchronization of current working directory

FileManager relies on the loosely standardized terminal command sequence OSC 7 to keep the Terminal and Finder panes current directories in sync. Currently, the shell must be configured to emit this command sequence[^1]. Here's an example for zsh:

```zsh
autoload -U add-zsh-hook
function osc7 {
    local LC_ALL=C
    export LC_ALL

    setopt localoptions extendedglob
    input=( ${(s::)PWD} )
    uri=${(j::)input/(#b)([^A-Za-z0-9_.\!~*\'\(\)-\/])/%${(l:2::0:)$(([##16]#match))}}
    print -n "\e]7;file://${HOSTNAME}${uri}\e\\"
}
add-zsh-hook -Uz chpwd osc7
```
_source: https://codeberg.org/dnkl/foot/wiki#zsh_

[^1]: Terminal.app seems to handle this automatically. I'm not yet sure how they do it.
