start:
gosub perceive xibar
gosub perceive yavash
gosub perceive katamba
gosub perceive perception
gosub perceive psychic
gosub perceive moonlight
gosub perceive transduction
gosub perceive stellar
gosub perceive planets
goto start

perceive:
if ($Power_Perceive.LearningRate > 33) then gosub wait
put perceive $0
pause
return

wait:
if ($Power_Perceive.LearningRate > 33) then
{
  pause 20
  goto wait
}
return