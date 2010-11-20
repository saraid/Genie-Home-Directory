wait
put remove my $MagicTrainer.Cambrinth.Item

train:
if ($Primary_Magic.LearningRate > 33 && $Harness_Ability.LearningRate > 33 || $mana < 50) then gosub wait
put prep $MagicTrainer.Spell $MagicTrainer.Amount
put charge my $MagicTrainer.Cambrinth.Item $MagicTrainer.Cambrinth.Amount
pause
send focus my $MagicTrainer.Cambrinth.Item
pause
waitfor fully prepared
send cast $MagicTrainer.Target
pause
goto train

wait:
if ($Primary_Magic.LearningRate > 33 && $Harness_Ability.LearningRate > 33 || $mana < 50) then
{
  pause 20
  goto wait
}
return
