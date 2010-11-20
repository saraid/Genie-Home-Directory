start:
if ($Vocals.LearningRate > 33) then gosub wait
send hum $song
waitfor You finish humming 
goto start

wait:
if ($Vocals.LearningRate > 33) then
{
  pause 20
  goto wait
}
return