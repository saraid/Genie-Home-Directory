# %1 - pause
# %2 - spell
# %3 - amount
# %4 - cambrinth
# %5 - target

var pause 0
if (toupper("%1") = "PAUSE") then var pause 1

if pause = 1 then put #script pause all except script-cast
put prepare %2 %3
if (%4 > 0) then
{
  var cambrinth $MagicTrainer.Cambrinth.Item
  put remove my %cambrinth
  put charge my %cambrinth %4
  pause 3
  send focus my %cambrinth
  pause 5
}
put cast %5
if pause = 1 then put #script resume all