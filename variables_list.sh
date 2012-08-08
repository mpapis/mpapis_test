
## Reading variables in current BASH / ZSH shell,
## displays arrays, in different formats, but still good enough for parsing
## ex.
##   BASH: array2=([0]="four" [1]="five" [2]="six" [10]="ten")
##   ZSH:  array2=(four five six '' '' '' '' '' '' ten)
##
## BASH does not interpret new lines in strings, ZSH does
##
## they both escape strings in '' if contains spaces, ' is escaped as '\''
## strings might be prefixed with $

variable1=play\'me
variable2='play
 with
 me
 now'
array2=( four five six )
array2[10]="ten"

for v in $( set | grep -Eao "^[^=]*=[\('\$]?" )
do
  x="${v##*=}"
  if [[ -n "$x" ]]
  then
    y="${x/\(/)}"
    y="${y/\$/\'}"
    v="${v%$x}"
    v="${v//\*/\*}"
    set | sed -n '/^'"$v"'/{: rep ; /'"$y$"'/!{N; b rep; }; p;}'
  else
    set | grep -a "^$v"
  fi
done
