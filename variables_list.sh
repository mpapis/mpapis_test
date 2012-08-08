
## Reading variables in current BASH / ZSH shell,
## displays arrays, in different formats, but still good enough for parsing
## ex.
##   BASH: array2=([0]="four" [1]="five" [2]="six" [10]="ten")
##   ZSH:  array2=(four five six '' '' '' '' '' '' ten)
##
## BASH does not interpret new lines in strings, ZSH does
##
## they both escape strings in '' if contains spaces, ' is escaped as '\''

variable1=play\'me
variable2="play with
 me"
array2=( four five six )
array2[10]="ten"


for v in $( set | grep -Eao "^[^=]*=[\('\"]?" )
do
  x="${v##*=}"
  if [[ -n "$x" ]]
  then
    y="${x/\(/\)}"
    v="${v%\(}"
    v="${v//\*/\*}"
    set | awk 'BEGIN {m=0} /'^"${v}"'/{m=1} m {print} /'"$y$"'/{m=0}'
  else
    set | grep -a "^$v"
  fi
done
