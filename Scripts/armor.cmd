if_1 goto processArgs
if (toupper("$Armor.Wearing") = "ON") then goto removeArmor

wearArmor:
gosub remove jacket
gosub wear breastplate
gosub wear gauntlets
gosub wear helm
put #var Armor.Wearing ON
exit

removeArmor:
gosub remove helm
gosub remove gauntlets
gosub remove breastplate
gosub wear jacket
put #var Armor.Wearing OFF
exit

wear:
put get my $1
put wear my $1
pause
return

remove:
put remove my $1
put stow my $1
pause
return

processArgs:
gosub %1 %2
exit