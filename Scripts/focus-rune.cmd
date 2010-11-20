focus:
if ($Arcana.LearningRate > 33 || $concentration < 20) then gosub wait
put focus my rune
pause
goto focus

wait:
if ($Arcana.LearningRate > 33 || $concentration < 20) then
{
  pause 20
  goto wait
}
return