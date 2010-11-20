#
# automapper.cmd version 3.10
# last changed: 04/19/2010
# Added handler for attempting to enter closed shops from Shroomism
# Added web retry support from Dasffion
# Added caravan support from Jailwatch
# Added swimming retry from Jailwatch
# Added search and objsearch handling from BakedMage
# Added enhanced climbing and muck support from BakedMage
#
# Related macros
# ---------------
# Add the following macro for toggling powerwalking:
# #macro {P, Control} {#if {$powerwalk = 1}{#var powerwalk 0;#echo *** Powerwalking off}{#var powerwalk 1;#echo *** Powerwalking on}}
#
# Add the following macro for toggling Caravans:
# #macro {c, Control} {#if {$caravan = 1}{#var caravan 0;#echo *** Caravan Following off}{#var caravan 1;#echo *** Caravan Following on}}
#
# Related aliases
# ---------------
# Add the following aliases for toggling dragging:
# #alias {dragoff} {#var drag 0;#var drag.target}
# #alias {dragon} {#var drag 1;#var drag.target $0}
# Standard Account = 1, Premium Account = 2, LTB Premium = 3
# will use a global to set it by character.  This helps when you have both premium and standard accounts.
if endswith("$automapper.typeahead", ".typeahead") then 
	var typeahead 1 
else 
	var typeahead $automapper.typeahead

var depth 0
var movewait 0
var closed 0

var move_OK ^Obvious|^It's pitch dark
var move_FAIL ^You can't go there|^What were you referring to|^I could not find what you were referring to\.|^You can't sneak in that direction
var move_RETRY ^\.\.\.wait|^Sorry, you may only|^Sorry, system is slow
var move_RETREAT ^You are engaged to|^You try to move, but you're engaged|^While in combat
var move_WEB ^You can't do that while entangled in a web
var move_WAIT ^You continue climbing|^You begin climbing|^You really should concentrate on your journey|^You step onto a massive stairway
var move_END_DELAY ^You reach|you reach\.\.\.$ 
var move_STAND ^You must be standing to do that|^You can't do that while (lying down|kneeling|sitting)|^Running heedlessly over the rough terrain, you trip over an exposed root and land face first in the dirt\.|^Stand up first\.
var move_NO_SNEAK ^You can't do that here|^In which direction are you trying to sneak|^Sneaking is an inherently stealthy|^You can't sneak that way|^You can't sneak in that direction
var move_GO ^Please rephrase that command
var move_MUCK ^You fall into the .+ with a loud \*SPLUT\*|^You slip in .+ and fall flat on your back\!|^The .+ holds you tightly, preventing you from making much headway\.
var climb_FAIL ^Trying to judge the climb, you peer over the edge\.  A wave of dizziness hits you, and you back away from .+\.|^You start down .+, but you find it hard going\.  Rather than risking a fall, you make your way back up\.|^You attempt to climb down .+, but you can't seem to find purchase\.|^You pick your way up .+, but reach a point where your footing is questionable\.  Reluctantly, you climb back down\.|^You make your way up .+\.  Partway up, you make the mistake of looking down\.  Struck by vertigo, you cling to .+ for a few moments, then slowly climb back down\.|^You approach .+, but the steepness is intimidating\.|^You start up .+, but slip after a few feet and fall to the ground\!  You are unharmed but feel foolish\.
var move_CLOSED ^The door is locked up tightly for the night|^You stop as you realize that the|shop is closed for the night
var swim_FAIL ^You struggle|^You work|^You slap|^You flounder

gosub actions
goto loop

actions:
	action (mapper) if %movewait = 0 then shift;if %movewait = 0 then math depth subtract 1;if len("%2") > 0 then echo Next move: %2 when %move_OK
	action (mapper) goto move.failed when %move_FAIL
	action (mapper) goto move.retry when %move_RETRY|%move_WEB
	action (mapper) goto move.stand when %move_STAND
	action (mapper) var movewait 1;goto move.wait when %move_WAIT
	action (mapper) goto move.retreat when %move_RETREAT
	action (mapper) var movewait 0 when %move_END_DELAY
	action (mapper) var closed 1;goto move.closed when %move_CLOSED
	action (mapper) goto move.nosneak when %move_NO_SNEAK
	action (mapper) goto move.go when %move_GO
	action (mapper) goto move.muck when %move_MUCK
	action (mapper) echo Will re-attempt climb in 5 seconds...;send 5 $lastcommand when ^All this climbing back and forth is getting a bit tiresome\.  You need to rest a bit before you continue\.$
	action (mapper) goto move.retry when %swim_FAIL
	return

loop:
	gosub wave
	pause 0.1
	goto loop

wave:
	if %depth > 0 then return
	if_1 goto wave_do
	goto done

wave_do:
	var depth 0
	if_1 gosub move %1
	if %typeahead < 1 then return
	if_2 gosub move %2
	if %typeahead < 2 then return
	if_3 gosub move %3
	if %typeahead < 3 then return
	if_4 gosub move %4
	if %typeahead < 4 then return
	if_5 gosub move %5
	return

done:
	pause
	put #parse YOU HAVE ARRIVED
	exit

move:
	math depth add 1
	var movement $0
	var type real
	if $drag = 1 then
	{
		var type drag
		if matchre("%movement", "(swim|climb|web|muck|rt|wait|stairs|slow|go|script) ([\S ]+)") then
		{
			var movement drag $drag.target $2
		}
		else
		{
			var movement drag $drag.target %movement
		}
	}
	else
	{
		if $hidden = 1 then
		{
			var type sneak
			if !matchre("%movement", "climb|go gate") then
			{
				if matchre("%movement", "go ([\S ]+)") then
				{
					var movement sneak $1
				}
				else
				{
					var movement sneak %movement
				}
			}
		} 
		else 
		{
			if "%type" = "real" then
			{
				if matchre("%movement", "^(search|swim|climb|web|muck|rt|wait|slow|drag|script) ") then
				{
					var type $1
					eval movement replacere("%movement", "^(search|swim|web|muck|rt|wait|slow|script) ", "")
				}
				if matchre("%movement", "^(objsearch) (\S+) (.+)") then
				{
					var type objsearch
					var searchObj $2
					var movement $3
				}
			}
		}
	}
	goto move.%type
move.real:
	put %movement
	goto return
move.power:
	put %movement
	pause 0.2
	put perc
	waitforre ^Roundtime
	goto move.done
move.drag:
move.sneak:
move.swim:
move.rt:
move.web:
	put %movement
	pause
	goto move.done
move.muck:
	pause
	if !$standing then put stand
	matchre move.muck ^You struggle to dig|^Maybe you can reach better that way, but you'll need to stand up for that to really do you any good\.
	matchre return.clear ^You manage to dig|^You will have to kneel closer
	put dig
	matchwait
move.slow:
	pause 3
	goto move.real
move.climb:
	matchre move.done %move_OK
	matchre move.climb.with.rope %climb_FAIL
	put %movement
	matchwait
move.climb.with.rope:
	if !contains("$righthand $lefthand", "heavy rope") then
	{
		pause
		action (mapper) off
		put get my heavy rope
		put uncoil my heavy rope
		wait
		pause .5
		action (mapper) on
	}
	if !contains("$righthand $lefthand", "heavy rope") then goto move.climb.with.app.and.rope
	matchre stow.rope %move_OK
	matchre move.climb.with.app.and.rope %climb_FAIL
	put %movement with my rope
	matchwait
move.climb.with.app.and.rope:
	eval climbobject replacere("%movement", "climb ", "")
	put appraise %climbobject quick
	waitforre ^Roundtime:
	matchre stow.rope %move_OK
	matchre move.climb.with.app.and.rope %climb_FAIL
	put %movement with my rope
	matchwait
stow.rope:
	if contains("$righthand $lefthand", "heavy rope") then
	{
		put coil my heavy rope
		put stow my heavy rope
		wait
		pause .5
	}
	goto move.done
move.search:
	put search
	wait
	pause .5
	put %movement
	pause .2
	goto move.done
move.objsearch:
	put search %searchObj
	wait
	pause .5
	put %movement
	pause .2
	goto move.done
move.script:
	action (mapper) off
	match move.script.done MOVE SUCCESSFUL
	match move.failed MOVE FAILED
		put .%movement
	matchwait
move.script.done:
	shift
	math depth subtract 1
	if len("%2") > 0 then echo Next move: %2
	action (mapper) on
	goto move.done
move.pause:
	put %movement
	pause
	goto move.done
move.stairs:
move.wait:
	pause 0.2
	if %movewait = 1 then 
	{
		waitforre ^You reach|you reach
	}
	goto move.done
move.stand:
	matchre move.stand %move_RETRY|^Roundtime
	matchre return.clear ^You stand back up
		put stand
	matchwait
move.retreat:
	action (mapper) off
	matchre move.retreat %move_RETRY|^Roundtime
	matchre move.retreat.done ^You retreat from combat
	matchre move.retreat.done ^You are already as far away as you can get
		put retreat
		put retreat
	matchwait
move.retreat.done:
	action (mapper) on
	goto return.clear
move.go:
	put go %movement
	goto move.done
move.nosneak:
	if %closed = 1 then goto move.closed
	eval movement replacere("%movement", "sneak ", "")
	put %movement
	goto move.done
move.retry:
	echo
	echo *** Retry movement
	echo
	pause 0.5
	goto return.clear
move.closed:
	echo
	echo ********************************
	echo SHOP IS CLOSED FOR THE NIGHT!
	echo ********************************
	echo
	put #parse SHOP CLOSED
	exit
move.failed:
	echo
	echo ********************************
	echo MOVE FAILED
	echo Remaining Path: %0
	echo ********************************
	echo
	put #parse MOVE FAILED
	exit
caravan:
	waitforre following you\.$
	gosub clear
	goto loop
powerwalk:
	pause 0.2
	put perc
	waitforre ^Roundtime
	gosub clear
	goto loop
return.clear:
	var depth 0
	gosub clear
	goto loop
move.done:
	if $caravan = 1 then {
		goto caravan
	}
	if $powerwalk = 1 then {
		goto powerwalk
	}
	gosub clear
	goto loop
return:
	if $caravan = 1 then {
		goto caravan
	}
	if $powerwalk = 1 then {
		goto powerwalk
	}
	var movewait 0
	return
