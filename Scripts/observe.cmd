timer start
var OBSERVE_TIME 0
var PREDICT_TIME %t
math PREDICT_TIME add 600
var INDOORS 0
action var INDOORS 1 when You can't see the sky clearly enough

action var constellation sun when eval $Time.isDay = 1
action var constellation $AstrologyTrainer.Constellation when eval $Time.isDay = 0
if $Time.isDay = 1 then var constellation sun
else var constellation $AstrologyTrainer.Constellation
 
action put predict event when You are unable to sense additional 

start:
if ($Astrology.LearningRate > 33 && %t < %OBSERVE_TIME) then goto wait
if ("$spellPG" != "ON") then gosub castPG 
match start You see nothing regarding
match observed you still learned a little bit
match observed You learned something useful
match observed you grasp more of its patter
match stupid You are unable to make use
match fullpool Too many futures cloud your mind - you learn nothing.
match clouds Clouds obscure the sky
put observe %constellation in sky
matchwait 10
goto start
 
castPG: 
put #script pause all except observe
put yes
wait
put prep pg 8
waitfor You feel fully prepared 
put cast
put #script resume all
return 

clouds:
gosub castPG
goto start
fullpool:
stupid:
observed:
var OBSERVE_TIME %t
math OBSERVE_TIME add 120

if ($Time.isDay = 1) then
{
  var skillset1 offense
  var skillset2 survival
  var skillset3
  var skillset4
}
else
{
  var skillset1 $AstrologyTrainer.Skillset.1
  var skillset2 $AstrologyTrainer.Skillset.2
  var skillset3 $AstrologyTrainer.Skillset.3
  var skillset4 $AstrologyTrainer.Skillset.4
}
var LOCAL

predict:
if (%t >= %PREDICT_TIME && $Astrology.LearningRate < 24) then
{
  if (length("%LOCAL") = 0) then var LOCAL %skillset1
  else {
    if (%LOCAL = %skillset1 && length("%skillset2") > 0) then var LOCAL %skillset2
    else {
      if (%LOCAL = %skillset2 && length("%skillset3") > 0) then var LOCAL %skillset3
      else {
        if (%LOCAL = %skillset3 && length("%skillset4") > 0) then var LOCAL %skillset4
        else
        {
          var LOCAL
          goto wait
        }
      }
    }
  }
  matchre predict no|feeble|weak
  matchre predictFuture fledgling|modest|decent|significant|potent|insightful|powerful|complete
  send predict state %LOCAL
  matchwait 5
  goto predict

  predictFuture:

  var PREDICT_TIME %t
  math PREDICT_TIME add 600
  send predict future $charactername %LOCAL
  waitfor the mists of time begin to part
  put predict analyze
}

wait:
if ($Astrology.LearningRate < 33 && %t >= %OBSERVE_TIME) then goto start
pause 10
put study sky
pause 10
if (%INDOORS = 0) then put predict weather
pause 10
goto wait