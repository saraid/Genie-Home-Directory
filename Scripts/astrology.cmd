var skillset %1
var OBSERVE_TIME 0
timer start

if $Time.isDay = 1 then var constellation sun
else var constellation %2

observation:
if %t >= %OBSERVE_TIME then
{
  echo %t
  echo %OBSERVE_TIME
  if ("$spellPG" != "ON") then gosub castPG
  match failure You see nothing regarding
  match observed you still learned a little bit
  match observed You learned something useful
  match observed you grasp more of its pattern
  put observe %constellation
  matchwait 10
}
pause 30
goto observation

failure:
goto observation

castPG:
put prep pg 8
waitfor You feel fully prepared
put cast
return

observed:
var OBSERVE_TIME %t
match OBSERVE_TIME add 240
matchre observation no|feeble|weak|fledgling|modest|decent
matchre predictFuture significant|potent|insightful|powerful|complete
put predict state %skillset
matchwait 10
goto observation

predictFuture:
put predict future $charactername %skillset
goto observation
