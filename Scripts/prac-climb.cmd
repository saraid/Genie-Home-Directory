start:
if ($Climbing.LearningRate > 33) then gosub wait
send climb practice %1
waitfor You finish practicing your climbing skill and take a well-earned break.
goto start

wait:
if ($Climbing.LearningRate > 33) then
{
  pause 20
  goto wait
}
return