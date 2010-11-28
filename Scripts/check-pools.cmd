if ("$ObservationPool.DataStale" = "false") then goto report

gosub check offense
gosub check defense
gosub check magic
gosub check survival
gosub check lore
put #var ObservationPool.DataStale false

report:
echo ** Observation Pool State
echo * Offense: $ObservationPool.Offense
echo * Defense: $ObservationPool.Defense
echo * Magic: $ObservationPool.Magic
echo * Survival: $ObservationPool.Survival
echo * Lore: $ObservationPool.Lore
exit

check:
pause
send predict state $1
pause 3
return
