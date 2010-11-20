#CHECK HERE
put #var save
#debuglevel 10
########################################################################
##                                                                    ##
##                         General combat script                      ##
##                 By: Warneck (with help from SFHunter)              ##
##                                                                    ##
##                          General Options:                          ##
## APPR: appraises monsters, will not appraise if appraisal is locked ##
## ARRANGE #: arranges skinnable creatures before skinning them       ##
##     The # designates the number of times you want to arrange (1-5) ##
##     If no # entered, will default to 1 time                        ##
## BLOCK: sets stance to shield stance                                ##
## BUFF: usese buffing subroutine			     				      ##
## BUNDLE: bundles skins if you have ropes.  Bundles are untied, and  ##
##		   dropped.  See TIE and WEAR for other options				  ##
## COLLECTIBLE: loots collectibles (diras and cards)                  ##
## COUNT/DANCE: dances with X number of creatues.  Stops dancing if   ##
##             you mind murks up                                      ##
## CUSTOM: sets stance to custom stance                               ##
## DANGER: part of the BUFF command, it sets BUFF and retreats during ##
##	casting							                                  ##
## DEFAULT: use the default setting, use DSET fist to set up defaults ##
##          can also use .geniehunter with no arguments to do this    ##
## DMSET: setup for multi-weapon with default settings                ##
##        use is .geniehunter dmset weapon1 weapon2 ...               ##
## DMULTI: Multi-weapon with default settings                         ##
## DODGE/EVADE: sets stance to evasion stance                         ##
## DSET: used to set up the default settings                          ##
##      run .geniehunter DSET <<all other options>> once to set the   ##
##      defaults, this will go through init like normal, and then     ##
##      save all the settings globally for use as default             ##
## EXP: checks weapon experience.  Will end script when skill is      ##
##      bewildered or above                                           ##
## HUNT: will use the HUNT verb to train perception and stalking, but ##
##       will not move around the hunting ground                      ##
## JUGGLE/YOYO: juggles when no more monsters in the room             ##
## JUNK: loots scrolls/runestones/cards, exclusive from LOOT          ##
## LOOTALL: loots every it can                                        ##
## LOOTBOXES: loots  boxes, redundant if used with LOOT               ##
## LOOTCOINS: loots coins, redundant if used with LOOT                ##
## LOOTGEMS: loots gems, redundant if used with LOOT                  ##
## MSET: setup for multi-weapon, break up multi setups with quotation ##
##     marks: .geniehunter "setup 1" "setup 2"..."setup 10"           ##
##     supports up to 10 setups currently                             ##
##     setups are saved as GH_MULTI_# for edittabillity               ##
## MULTI: multi-weapon training, will use a weapon until locked       ##
##       then switch to the next setup when locked                    ##
## NOEVASION: Will skip the evasion stance when stance switching      ##
## NOPARRY: Will skip the parry stance when stance switching          ##
## NOSHIELD: Will skip the shiel stance when stance switching         ##
## PARRY: sets stance to parry stance                                 ##
## POWERP: will power perceive once every 6 minutes.                  ##
## RETREAT: turns on retreating for ranged weapons / spells. This     ##
##          does not work with poaching yet                           ##
## ROAM: will roam around the hunting area if no more monsters in     ##
##       room to kill                                                 ##
##                           !!!CAUTION!!!                            ##
##         There is no safeguard for leaving a hunting area or        ##
##                wandering into a more dangerous area.               ##
## SCRAPE: scrape skins/pelts/hides after skinning, retreating works  ##
##         while doing this activity.  Use SKINRET for this           ##
## SKIN: skins monsters                                               ##
## SKINRETREAT: will turn on retreating while skinning                ##
## SLOW: will use your weapons slower, for weaklings or noobs         ##
##  Following this command with a # will pause for that many seconds  ##
##   before attacking                                                 ##
## STANCE: will cycle through stances once that skill is locked       ##
##         current cycle is evas -> shield -> parry and back          ##
## TEND: Will tend external wounds if bleeding - WILL NOT UNWRAP IF   ##
##		 WOUND STARTS BLEEDING WORSE								  ##
## TARGET: specifies a target to aim/target for attacks               ##
## TIE: Ties bundles when first created, saves inventory space        ##
## TIMER: will set a timer to abort the script after x seconds        ##
## TRAIN: will check experience after every combat cycle, ranged      ##
##        weapon firing/throwing, or spell cast                       ##
## WEAR: Wears bundles.  Uses STOW verb to put skin into bundle if it ##
##       this is used w/ the TIE option.                              ##
##                                                                    ##
##                         Weapon Options:                            ##
## AMBUSH: hides/stalks and attacks from hiding, checks stalking exp  ##
## BACKSTAB: backstabs with weapon                                    ##
## BRAWL: brawls, will brawl with a weapon out if so desired          ##
## EMPATH: non-lethal brawling                                        ##
## FEINT: use a feinting routine to keep balance up                   ##
## MAGIC: uses magic in the same syntax as TM/PM, but will only cast  ##
##        once per critter, then use the primary weapon to kill       ##
## OFFHAND: uses weapon in offhand, works with melee or thrown        ##
## POACH: poaches with a ranged weapon, checks stalking exp           ##
## SNAP: snap-fires ranged weapon and snapcasting for magic           ##
##  Following this command with a # will pause for that many seconds  ##
##   before casting/firing                                            ##
## SNIPE: snipes with a ranged weapon                                 ##
## STACK: throws stacks of weapons (throwing blades). If you use      ##
##        this, don't use THROW too                                   ##
## SWAP/BASTARD: swappable weapon support, equips the weapon and      ##
##               swaps it to the desired weapon "mode"                ##
##       Available mode options: 1 - one handed                       ##
##                               2 - two handed                       ##
##                               b - blunt                            ##
##                               e - edged                            ##
##                               ha - halberd                         ##
##                               pi - pike                            ##
##                               qs - quarter staff                   ##
##                               ss - short staff                     ##
## TSWAP: does the same as SWAP, but for throwing weapons             ##
## THROW: throws a thrown weapon                                      ##
## TM/PM: uses magic as the primary weapon, with brawling as the      ##
##        backup if no other weapon is specified (and you run out of  ##
##        mana). The extra harness is optional. TM for targeted exp   ##
##        check, PM for primary magic exp checks. SNAP will snapcast. ##
##        Use as follows:                                             ##
##     (SNAP) <TM|PM> <spell> <mana> (extra mana) <weapon> <shield>   ##
##                                                                    ##
## Use:                                                               ##
## .geniehunter (General options) (Weapon Options) weapon shield      ##
##                                                                    ##
## Note: You must have the EXP Tracker Plugin for this script to work ##
########################################################################

pause
#debuglevel 5

timer clear
timer start
## GAG_ECHO can be YES or NO
## YES - Will not show any of the informative echoes
## NO - Default, will show all informative echoes
var GAG_ECHO NO

action (geniehunter) put #queue clear; send 1 $lastcommand when ^\.\.\.wait|^Sorry, you may only type
action (geniehunter) put #queue clear; send 1 $lastcommand when ^You are still stunned
action put #beep;put #flash when ^(.+) (say|says|asks|exclaims|whispers)

##LOOT Variables
var gems1 agate|alexandrite|amber|amethyst|andalusite|aquamarine|bar|bead|beryl|bloodgem|bloodstone|carnelian|chrysoberyl|carnelian|chalcedony
var gems2 chrysoberyl|chrysoprase|citrine|coral|crystal|diamond|diopside|emerald|egg|eggcase|garnet|gem|goldstone|glossy malachite
var gems3 (chunk of|some|piece of).*granite|hematite|iolite|ivory|jade|jasper|kunzite|lapis lazuli|malachite stone|minerals|moonstone|morganite|nugget|onyx
var gems4 opal|pearl|pebble|peridot|quartz|ruby|sapphire|spinel|star-stone|sunstone|talon|tanzanite|tooth|topaz|tourmaline|tsavorite|turquoise|zircon
var gweths (lantholite|waermodi|jadeite|lasmodi|sjatmal) stones
var boxtype brass|copper|deobar|driftwood|iron|ironwood|mahogany|oaken|pine|steel|wooden
var boxes coffer|crate|strongbox|caddy|casket|skippet|trunk|chest|\bbox
##CHECK HERE
##var junkloot runestone|scroll|tablet|vellum|sheiska leaf|ostracon|hhr'lav'geluhh bark|papyrus roll|smudged parchment|lockpick|fragment|package
##
##var collectibles dira|card

var junkloot scroll|tablet|vellum|sheiska leaf|ostracon|hhr'lav'geluhh bark|papyrus roll|smudged parchment
var collectibles dira|card|soulstone|package|kirmhiro draught

##Monster Variables
var monsters1 river sprite|gidii|goblin shaman|fendryad|nyad|madman|sprite|wood troll|lipopod|kelpie|vykathi builder|vykathi excavator
var monsters2 fire maiden|creeper|vine|thug|ruffian|footpad|cutthroat|gypsy marauder|young ogre|swain|kra'hei hatchling
var monsters3 nipoh oshu|dyrachis|shadoweaver|crag|frostweaver|atik'et|dryad|orc scout|eviscerator|guardian|pile of rubble|pirate
var monsters4 geni|orc bandit|umbramagii|screamer|scout ogre|swamp troll|mountain giant
var monsters5 scavenger troll|sleazy lout|bucca|dragon fanatic|dusk ogre|tress|bloodvine
var monsters6 armored warklin|velver|orc reiver|kra'hei|dragon priest|lun'shele hunter|orc raider|folsi immola
var monsters7 faenrae assasin|telga moradu|trekhalo|orc clan chief|shadow master|malchata|sky giant|imp|dummy|clay mage|clay soldier|clay archer

var undead1 skeleton|soul|boggle|zombie|wind hound|fiend|spirit|ur hhrki'izh|spectral pirate|spectral sailor|shylvic
var undead2 skeleton kobold savage|skeleton kobold headhunter|skeletal sailor|olensari mihmanan
var undead3 emaciated umbramagus|zombie nomad|sinister maelshyvean heirophant|gargantuan bone golem|plague wraith|snaer hafwa|wir dinego
var undead4 skeletal peon|revivified mutt

var skinnablemonsters1 frog|silverfish|musk hog|grub|crayfish|burrower|crab|boar|skunk|badger|pothanit|trollkin|brocket deer
var skinnablemonsters2 kobold|s'lai scout|jackal|bobcat|cougar|grass eel|bear|ram|spider|wolf|boobrie|beisswurm|rock troll|sluagh
var skinnablemonsters3 serpent|firecat|vulture|arbelog|caiman|steed|larva|snowbeast|worm|unyn|gargoyle|crocodile
var skinnablemonsters4 merrows|viper|peccary|la'tami|barghest|angiswaerd hatchling|vykathi harvester|pard|moth|kartais
var skinnablemonsters5 la'heke|vykathi soldier|boa|warcat|moda|arzumo|carcal|blood warrior|goblin|cave troll|black ape
var skinnablemonsters6 rat|antelope|giant blight bat|leucro|wasp|mottled westanuryn|blight ogre|gryphon|caracal|basilisk
var skinnablemonsters7 dobek moruryn|sinuous elsralael|sleek hele'la|shadow mage|marbled angiswaerd|retan dolomar|faenrae stalker
var skinnablemonsters8 shadow beast|cinder beast|asaren celpeze|spirit dancer|scaly seordmaor|poloh'izh|armadillo|shalswar

var skinnableundead1 ghoul|squirrel|grendel|reaver|mey|shadow hound|lach|mastiff|gremlin
var skinnableundead2 zombie kobold savage|zombie kobold headhunter|ghoul crow|misshapen germish'din

var invasioncritters transmogrified oaf|flea-ridden beast|Prydaen|Rakash|bone warrior|shambling horror|skeletal peon|revivified mutt|putrefying shambler|bone amalgam

var skinnablecritters %skinnablemonsters1|%skinnablemonsters2|%skinnablemonsters3|%skinnablemonsters4|%skinnablemonsters5|%skinnablemonsters6|%skinnablemonsters7|%skinnablemonsters8|%skinnableundead1|%skinnableundead2
var nonskinnablecritters %monsters1|%monsters2|%monsters3|%monsters4|%monsters5|%monsters6|%monsters7|%undead1|%undead2|%undead3|%undead4

var critters %nonskinnablecritters|%skinnablecritters|%invasioncritter

var OPTIONVARS AMB.*?|APPR.*?|ARM.*?|ARRA.*?|BACK.*?|BAST.*?|BLO.*?|BRA.*?|BS|BUF.*?|BUN.*?|COLL.*?|COUNT|CUST.*?|DANCE|DANG.*?|DEF.*?|DMSET|DMULTI|DODGE|DSET|DYING|EMP.*?|EVA.*?|EXP|FEINT|HELP|HUNT|JUGG.*?|JUNK|LOOTA.*?|LOOTB.*?|LOOTC.*?|LOOTG.*?|MAGIC|MSET|MULTI|NOEV.*?|NOPA.*?|NOSH.*?|OFF.*?|PARRY|PM|POACH|POW.*?|PP|RET.*?|ROAM|SCRAPE.*?|SKIN.*?|SKINRET.*?|SLOW|SNAP|SNIP.*?|STACK|STANCE|SWAP|TARG.*?|TEND|THROW\b|TIE|TIME.*?|TM|TRAIN|TSWAP|WEAR|YOYO
var OPTION NONE

var lastmaneuver none


var LAST TOP
TOP:
## Initialize multi-weapon variable
## This part will be skipped when multi-weapons are implemented

#############################################################################
###                                                                       ###
###                                                                       ###
###       VARIABLE INIT: ONLY CHANGE VARIABES IN THIS SECTION             ###
###                                                                       ###
###                                                                       ###
#############################################################################

VARIABLE_INIT:
var BOW_AMMO $GH_CONTAINER_BOW_AMMO
var XB_AMMO $GH_CONTAINER_XB_AMMO
var SLING_AMMO $GH_CONTAINER_SLING_AMMO
var QUIVER $GH_CONTAINER_QUIVER
var LT_SHEATH $GH_CONTAINER_LT_SHEATH
var HT_SHEATH $GH_CONTAINER_HT_SHEATH
var BOX_CONTAINER $GH_CONTAINER_BOX_CONTAINER
var GEM_CONTAINER $GH_CONTAINER_GEM_CONTAINER
var JUNK_CONTAINER $GH_CONTAINER_JUNK_CONTAINER
var DEFAULT_CONTAINER $GH_CONTAINER_DEFAULT_CONTAINER

#var ARMOR1 $$charactername_ARMOR1
#var ARMOR2 $$charactername_ARMOR2

#############################################################################
###                                                                       ###
###                                                                       ###
###      END VARIABLE INIT: DO NOT CHANGE ANY MORE VARIABLES              ###
###                                                                       ###
###                                                                       ###
#############################################################################

put STORE GEMS %GEM_CONTAINER
waitforre You will now store|I could not find|You can't do that
put STORE BOXES %BOX_CONTAINER
waitforre You will now store|I could not find|You can't do that
put STORE SHIELDS %BOX_CONTAINER
waitforre You will now store|I could not find|You can't do that
put STORE DEFAULT %DEFAULT_CONTAINER
waitforre You will now use|I could not find|You can't do that

action remove ^You are still stunned

var JUGGLIE $JUGGLIE
var HUM_SONG $HUM_SONG
var HUM_DIFFICULTY $HUM_DIFFICULTY

## Has full aim been attained yet
var FULL_AIM NO

## Has full targetting been attained yet
var FULL_TARGET NO

## Has spell been fully prepped
var FULL_PREP NO

## Already searched the dead creature
var SEARCHED NO

var APPRAISED NO

## Arm-worn shield during ranged attempts
var REM_SHIELD NONE

## Stance variables
var PARRY_LEVEL 0
var EVAS_LEVEL 0
var SHIELD_LEVEL 0

## Initialize variable for roaming
var lastdirection none

## Variable for rest mode
var REST OFF

## Local variable for counting kills, loots, skins, etc
var LOCAL 0
var LOOTED NO
var CURR_WEAPON

## Special request
var DYING OFF

## Global variables for kills, loots, skins, etc
if matchre($GH_KILLS, \D+) then put #var GH_KILLS 0
if matchre($GH_LOOTS, \D+) then put #var GH_LOOTS 0
if matchre($GH_SKINS, \D+) then put #var GH_SKINS 0

#######################
## SCRIPT VARIALBLES ##
#######################

## variable LAST is used with the WEBBED and PAUSE subroutines
## LAST is set to the current subroutine you in within the script
if ("%1" != "MULTIWEAPON") then
{
	## MULTI can be OFF or ON
	## ON - Will switch weapons to the next multi setup when locked
	## OFF - Default, attacks with just this weapon
	put #var GH_MULTI OFF
} else
{
	shift
}

## Counter is used to send you back to combat from searching

######################################################
##                 GLOBAL VARIABLES                 ##
## These variables can be changed while GenieHunter ##
## is running to modify how the script works.       ##
## eg If you get tired of skinning, but have GH set ##
## to skin, just change GH_SKIN to OFF              ##
## All global variables are GH_<<name>> so they are ##
## all in the same spot in the variables window     ##
######################################################

## AMBUSH can be OFF or ON
## ON - Using ambushing attacks, hides and stalks before every attack
## OFF - Default, attacks normally
put #var GH_AMBUSH OFF

## APPR can be NO or YES
## YES - Kills first creature, then appraises one creature once before entering the combat loop
##      Will appraise once after each kill, will not appraise once skill is dazed or mind locked
## NO - Default, no appraising of creatures
put #var GH_APPR NO

## ARMOR can be OFF or ON
## ON - Will include the armor swapping routine and use it
## OFF - Default, no include
put #var GH_ARMOR OFF

## ARRANGE can be OFF or ON
## ON - Will attempt to arrange a skinnable creature before skinning it.
## OFF - Default, will just skin creatures
put #var GH_ARRANGE OFF

## BUFF can be OFF or ON
## ON - Will include the buffing routine and use it
## OFF - Default, no include
put #var GH_BUFF OFF

## BUN can be OFF or ON
## Note: Skinning must be enabled for bundling to work
## ON - Will bundle skinnings with rope
##      If no more bundling ropes are available, will be set to OFF
## OFF - Default, will just drop skins
put #var GH_BUN OFF

## COUNTING can be OFF or ON
## ON - Will dance with specified number of creatures.
##      Checks number of creatures after each pass through loop.
## OFF - Default, will kill everything as fast as possible
put #var GH_DANCING OFF

## DANGER can be OFF or ON
## ON - Will retreat while buffing, it will also set BUFF to on if it's not set already
## OFF - Default
put #var GH_BUFF_DANGER OFF

## EXP can be ON or OFF
## ON - Checks weapons experience after every kill
##      Also checks mindstate and any alternate experience
## OFF - No experience checks
if ("$GH_MULTI" = "OFF") then put #var GH_EXP OFF

## FEINT can be OFF or ON
## ON - Uses a feinting routine (feint slice, etc) to maintain balance
## OFF - Default, will use normal combat routine
## Note: Only usable with melee weapon fighting
put #var GH_FEINT OFF

## HUNT can be OFF or ON
## ON - Uses the HUNT verb every 90 seconds to train perception and stalking
## OFF - Default, will only use HUNT if roaming
put #var GH_HUNT OFF

## JUGGLE can be OFF or ON
## ON - Juggles when no monsters in the room
## OFF - Default, uses standard operations when no monsters in the room
put #var GH_JUGGLE OFF

## LOOT can be OFF or ON
## ON - Loots everything: boxes, gems coins; stores loot in LOOT_CONTAINER
##      If LOOT_CONTAINER fills up, stops looting boxes and gems
## OFF - Default, leaves loot on the ground
## Note: Turning on LOOT turns on LOOT_BOX, LOOT_GEM, LOOT_COIN
put #var GH_LOOT OFF

## LOOT_BOX can be OFF or ON
## ON - Loots boxes until LOOT_CONTAINER is full
## OFF - Default, leaves boxes on the ground
put #var GH_LOOT_BOX OFF

## LOOT_COIN can be OFF or ON
## ON - Loots coins
## OFF - Default, leaves coins on the ground
put #var GH_LOOT_COIN OFF

# LOOT_COLL can be OFF or ON
## ON - Will loot collectibles: Imperial diras and cards
## OFF - Default, will collectibles on the ground
put #var GH_LOOT_COLL OFF

## LOOT_GEM can be OFF or ON
## ON - Loots gems until LOOT_CONTAINER is full
## OFF - Default, leaves gems on the ground
put #var GH_LOOT_GEM OFF

## LOOT_JUNK can be OFF or ON
## ON - Loots junk items until LOOT_CONTAINER is full
## OFF - Default, leaves junk items on the ground
put #var GH_LOOT_JUNK OFF

## SPELL can be the shortname of any castable spell. It's what will be prepped.
put #var GH_SPELL eb

## MANA is the amount of initial mana to prep the spell at.
put #var GH_MANA 0

## HARN is the amount of extra mana to harness before casting the spell.
put #var GH_HARN 0

## PP can be OFF or ON
## ON - Perceives once every 6 minutes to train power perception
## OFF - Default, does nothing with perceive
put #var GH_PP OFF

## RETREAT can be OFF or ON
## ON - Uses the retreats for ranged combat, melee!
## OFF - Default, bypasses retreats for ranged combat
put #var GH_RETREAT OFF

## ROAM can be OFF or ON
## ON - Will roam around the hunting area  on main directions (n,nw,w,sw,s,se,e,ne,u,d)
##      if you kill all the creatures in your area
## OFF - Default, will stay in your own room no matter what
put #var GH_ROAM OFF

## SCRAPE can be OFF or ON
## ON - Scrapes skins/pelts/hides after skinning
## OFF - Default, just searches all creatures
## Note: This works with SKIN_RETREAT and BUNDLING
put #var GH_SCRAPE OFF

## SKIN can be OFF or ON
## ON - Skin creatures that can be skinned
##      Drops skins unless BUN is set to ON
## OFF - Default, just searches all creatures
put #var GH_SKIN OFF

## SKIN_RET can be OFF or ON
## ON - Turns on the retreat triggers while skinning
## OFF - Default, doesn't retreat for skinning
put #var GH_SKIN_RET OFF

## SLOW can be OFF or ON
## ON - Turns on pauses between weapon strikes
## OFF - Default, no pauses
put #var GH_SLOW OFF

## SNAP can be OFF or ON
## ON - Snap fires a ranged weapon
## OFF - Default, waits for a full aim to fire a ranged
put #var GH_SNAP OFF

## STANCE can be OFF or ON
## ON - Check stance exp after each kill, switch on dazed or mind lock
## OFF - Default, no stance exp checking
put #var GH_STANCE OFF

## TARGET (global) can be ""(null) or any valid body part spells should target
put #var GH_TARGET ""

## TEND can be OFF or ON
## ON - Will tend wounds
## OFF - Default, Will not tend wounds
put #var GH_TEND OFF

## TIE can be OFF or ON
## ON - Will tie bundle when created
## OFF - Default, leaves bundle untied
put #var GH_TIE OFF

## TIMER can be OFF or ON
## ON - If the timer is greater than MAX_TRAIN_TIME, end the script
## OFF - Default, run script endlessly
put #var GH_TIMER OFF

## TRAIN can be ON or OFF
## ON - Weapon or Alternate experience will be checked more often than just when critters die.
## OFF - Default, normal EXP check cycle.
if ("$GH_MULTI" = "OFF") then put #var GH_TRAIN OFF

## WEAR can be OFF or ON
## ON - Will wear a bundle
## OFF - Default, Will drop bundles
put #var GH_WEAR OFF


############################
##  End GLOBAL Variables  ##
############################

############################
## Local Script Variables ##
############################
## ALTEXP can be OFF or ON
## ON - Will check an alternate skill as well as weapon skill
## OFF - Just check weapon experience
var ALTEXP OFF

## BACKSTAB can be OFF or ON
## ON - Will backstab with a weapon
##      If weapon is not suitable for backstabbing, will enter normal combat with weapon
## OFF - Default, will attack normally with weapon
var BACKSTAB OFF

## BRAWLING can be OFF or ON
## ON - Brawling mode, uses bare hands to kill creatures (or non-lethal for Empaths)
## OFF - Default
var EMPTY_HANDED OFF

## CURR_STANCE can be Evasion, Parry_Ability or Shield_Usage
## Note: Used in stance switching
## Evasion - evasion stance is current one set, Default
## Parry_Ability - parry stance is current one set
## Shield_Usage - shield stance is current one set
var CURR_STANCE Evasion

## EXP2 can be Backstab, Hiding, NONE, Offhand_Weapon, Primay_Magic, Stalking, or Target_Magic
## Backstab - Used when backstabbing
## Hiding - Used when sniping
## Offhand_Weapon - Used when offhand attacks are done
## Primary_Magic - Used when performing magic and want to check PM
## Stalking - Used when ambushing and poaching
## Target_Magic - Used when performing magic and want to check TM
## NONE - Default
var EXP2 NONE

## FIRE_TYPE can be FIRE, POACH or SNIPE
## FIRE - Default, generic firing of ranged weapon
## POACH - Poaches creatures, hides and stalks before poaching
##         If creatures cannot be poached, fires normally
## SNIPE - Snipe creatures, hides and stalks before sniping
var FIRE_TYPE FIRE

## HAND can be <blank> or left
## <blank> - Default, attacks with the right hand
## left - Attacks with the left hand, used for one-handed weapons and throwing
var HAND

## HAND2 can be left or right
## Note: Used in stackables throwing to ensure you don't fill your hands
## left - Default
## right - Set when HAND = "left"
var HAND2 left

## MAGIC can be OFF or ON
## ON - Will cause a single cast of the specified spell before attacking with mundane weapons
## OFF - Default, won't trigger magic section
var MAGIC OFF

## MAGIC_TYPE can be TM or PM or OFF
## TM - Will cause the appropriate TM usage, with targeting, and checks against TM skill
## PM - Avoid targeting, and uses the PM skill for checks
## OFF - Default
var MAGIC_TYPE OFF

## MAGIC_COUNT can be 0 or anything greater. It tracks the original numeric combo for resetting the counter.
var MAGIC_COUNT 0

## MAX_TRAIN_TIME is how long, in seconds, you want the script to run before stopping
## Note: MAX_TRAIN_TIME defaults to 10 minutes
var MAX_TRAIN_TIME 600

## NOEVADE, NOPARRY, NOSHIELD are used with stance switching to indicate when you wish to skip a stance
## ON - Will skip the designated stance in the SWITCH_STANCE routine
## OFF - Default, will not skip this stance when switching
## Note: can only use one of these at a time.
var NOEVADE OFF
var NOPARRY OFF
var NOSHIELD OFF

## RANGED can be OFF or ON
## ON - For use with ranged weapons; bows, xbows and thrown
## OFF - Default, used with melee weapons
var RANGED OFF

## RETREATING can be OFF or ON. This variable is set internally.
## ON - Retreat triggers are ON
## OFF - Default, retreat triggers are OFF
var RETREATING OFF

## RUCK can be OFF or ON
## ON - Weapon was tied to a rucksack, used for sheathing while looting/skinning
## OFF - Default
## Note: Not yet implemented
var RUCK OFF

## SHIELD can be NONE or <shield type>
## NONE - Default, no shield used
## <shield type> - This is set either during the weapon check or ranged combat
##                 If set during the weapon check for a melee weapon, the shield is used during combat
##                 If set during ranged, the shield is removed and stowed, and reworn upon leaving the script
var SHIELD NONE

## STACK can be OFF or ON
## ON - Throwing weapon is a stackable
## OFF - Default
var STACK OFF

## THROWN can be OFF or ON
## ON - Throw a weapon
## OFF - Default
var THROWN OFF

## YOYO can be OFF or ON
## YOYO is a subset of JUGGLING, it uses a yoyo instead of a standard jugglie
## ON - "juggle" with a yoyo
## OFF - Default, normal jugglie
var YOYO OFF
################################
## End Local Script Variables ##
################################

counter set 0
gosub RETREAT_UNTRIGGERS
action var guild $1 when Guild: (\S+)
action var level $1 when Circle: (\d+)
put info 
waitfor Encumbrance
action remove Guild: (\S+)
action remove Circle: (\d+)
put awaken

if ("$GH_MULTI" = "DMULTI") then goto LOAD_DEFAULT_SETTINGS
if_1 goto VARIABLE_CHECK
if ("$GH_DEF_SET" = "YES") then goto LOAD_DEFAULT_SETTINGS

DEFAULT_NOT_SET:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** ERROR ***
		echo Your default setting are not set yet.
		echo Run .geniehuntera DSET <<default settings>> to set them
		echo
		echo Now exiting script
	}
	goto DONE

##############################
##                          ##
##  Start of actual script  ##
##                          ##
##############################
VARIABLE_CHECK:
	var LAST VARIABLE_CHECK
	gosub clear
	if matchre (toupper("%1"),"(\b%OPTIONVARS)") then
	{
		var OPTION %1
		pause 0.6
		shift
		gosub %OPTION
		goto VARIABLE_CHECK
	}

	gosub GENERAL_TRIGGERS

BEGIN:
	var LAST BEGIN
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** BEGIN: ***
		echo
	}
		matchre WEAPON_CHECK You draw|already holding|free to
		match BEGIN_HANDS free hand|need to have your right hand
		matchre BEGINA out of reach|remove|What were you|can't seem|Wield what\?
		match VARIABLE_CHECK You can only wield a weapon or a shield!
	put wield right my %1
	matchwait 15

BEGINA:		
	var LAST BEGINA
		matchre WEAPON_CHECK You sling|already holding|inventory|You remove
		matchre BEGIN_HANDS free hand|hands are full
		matchre BEGINB Remove what?|You aren't wearing
	put remove my %1
	matchwait 15

BEGINB:
	var LAST BEGINB
		matchre WEAPON_CHECK You get|you get|You are already holding
		match NO_VALUE Please rephrase that command
		match VARIABLE_ERROR What were you
		match UNTIE it is untied.
	put get my %1
	matchwait 30
	goto VARIABLE_ERROR

UNTIE:
	var RUCK ON
		match WEAPON_CHECK you get
		match NO_VALUE Please rephrase that command
		match VARIABLE_ERROR What were you
	put untie my %1 from ruck
	matchwait 30
	goto VARIABLE_ERROR

####################################
##                                ##
##  First input was not a weapon  ##
##  Checking for variables now    ##
##                                ##
####################################

### Ambushing creatures, using the stalking skill for experience checks
AMB:
AMBU:
AMBUS:
AMBUSH:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** AMBUSHING: ***
		echo
	}
	put #var GH_AMBUSH ON
	var ALTEXP ON
	var EXP2 Stalking
	return

## Appraising creatures until appraisal is locked
APPR:
APPRAISE:
APPRAISAL:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** APPRAISAL: ***
		echo
	}
	put #var GH_APPR YES
	return

## Will include buffing routine
ARM:
ARMO:
ARMOR:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** ARMORSWAPPING: ***
		echo
	}
	put #var GH_ARMOR ON
	put #var GH_ARMOR.INCLUDE 0
	put #var GH_ARMOR_COUNT 0
	put #var GH_ARMOR_TOTAL 0
	return
	
## Arranging skinnable creatures before skinning
## Turns skinning on if it is not already
ARRA:
ARRAN:
ARRANG:
ARRANGE:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** ARRANGE: ***
		echo
	}
	put #var GH_ARRANGE ON
	if ("$GH_SKIN" != "ON") then gosub SKIN
	if matchre("%1","^\d+$") then
	{
		put #var MAX_ARRANGE %1
		if ("%GAG_ECHO" != "YES") then echo *** Arranging %1 times ***
		shift
	} else put #var MAX_ARRANGE 1
	return

## Backstabbing with a weapon	
BS:
BACK:
BACKS:
BACKST:
BACKSTA:
BACKSTAB:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** BACKSTAB: ***
		echo
	}
	if ("%guild" != "Thief") then 
	{
		echo
		echo ***  Can only backstab if you are a thief!!  ***
		echo
		return
	}
	gosub clear
	gosub GENERAL_TRIGGERS
	if ("$GH_FEINT" = "ON") then put #var GH_FEINT OFF
	put #var GH_AMBUSH ON
	var BACKSTAB ON
	var ALTEXP ON
	var EXP2 Backstab
	var LAST_ATTACK none
	counter set 1300
	var CURR_WEAPON %1
	var LAST GET_BS_WEAPON	
	GET_BS_WEAPON:
			matchre APPRAISE_BS You draw|already holding|free to
			match BEGIN_HAND need to have your right hand
		put wield my %CURR_WEAPON
		matchwait 15
		goto VARIABLE_ERROR
	APPRAISE_BS:
		var LAST APPRAISE_BS
			matchre LE_BS (a|and) light edged 
			matchre ME_BS (a|and) medium edged
			matchre WEAPON_APPR_ERROR Roundtime|It's hard to appraise
		put appr my %CURR_WEAPON quick
		matchwait 15
		goto WEAPON_APPR_ERROR		
	LE_BS:
		var WEAPON_EXP Light_Edged
		var RANGED OFF
		var COMBO1 parry
		var COMBO2 feint
		var COMBO3 lunge
		var COMBO4 thrust
		var COMBO5 jab
		var COMBO6 unused
		var COMBO7 unused
		var COMBO8 unused
		goto 1_HANDED_WEAPON
	ME_BS:
		var WEAPON_EXP Medium_Edged
		var RANGED OFF
		var COMBO1 parry
		var COMBO2 feint
		var COMBO3 draw
		var COMBO4 sweep
		var COMBO5 thrust
		var COMBO6 unused
		var COMBO7 unused
		var COMBO8 unused
		goto 1_HANDED_WEAPON

## Setting the stance to shield/blocking
BLO:
BLOC:
BLOCK:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** BLOCK: ***
		echo
	}
	var CURR_STANCE Shield_Usage
	SET_SHIELD_STANCE:
		var LAST SET_SHIELD_STANCE
			match RETURN You are now set to
		put stance shield
		matchwait 15
	return

## Will include buffing routine
BUF:
BUFF:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** BUFF: ***
		echo
	}
	put #var GH_BUFF ON
	put #var GH_BUFF_INCLUDE 0
	return
	
## Will bundle anything skinned.  If skinning not enabled this does nothing.
BUN:
BUND:
BUNDL:
BUNDLE:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** BUNDLE: ***
		echo
	}
	put #var GH_BUN ON
	if ("$GH_SKIN" != "ON") then gosub SKIN
	return

## Implements brawling attacks
BRA:
BRAW:
BRAWL:
BRAWLI:
BRAWLIN:
BRAWLING:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** BRAWLING: ***
		echo
	}
	gosub clear
	gosub GENERAL_TRIGGERS
	var WEAPON_EXP Brawling
	if_1 then goto BRAWL_CHECK
	BRAWL_EMPTY:
		var EMPTY_HANDED ON
		var COMBO1 dodge
		var COMBO2 gouge
		var COMBO3 claw
		var COMBO4 elbow
		var COMBO5 punch
		var COMBO6 slam
		var COMBO7 unused
		var COMBO8 unused
		counter add 600
		goto BRAWL_SETUP
	BRAWL_CHECK:
		if matchre ("%1","shield|buckler|pavise|heater|kwarf|sipar|lid|targe\b|tray|wheel") then goto BRAWL_EMPTY
		var EMPTY_HANDED OFF
		var COMBO1 dodge
		var COMBO2 circle
		var COMBO3 elbow
		var COMBO4 jab
		var COMBO5 kick
		var COMBO6 punch
		var COMBO7 unused
		var COMBO8 unused
		counter add 500
		var CURR_WEAPON %1
		shift
	BRAWL_WEAPON:
		var LAST BRAWL_WEAPON
		gosub WIELD_WEAPON %CURR_WEAPON
		goto BRAWL_SETUP

COLL:
COLLE:
COLLEC:
COLLECT:
COLLECTIBLE:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** LOOT_COLLECTIBLES: ***
		echo
	}
	if ("$GH_LOOT" != "ON") then put #var GH_LOOT ON
	put #var GH_LOOT_COLL ON
	return

CUST:
CUSTO:
CUSTOM:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** CUSTOM STANCE: ***
		echo
	}
	action var PARRY_LEVEL $1 when ^You are currently using (\d+)% of your weapon parry skill
	action var EVAS_LEVEL $1 when ^You are currently using (\d+)% of your evasion skill
	action var SHIELD_LEVEL $1 when ^You are currently using (\d+)% of your shield block skill
	put stance custom
	waitfor You are now set to
	if (%PARRY_LEVEL > %EVAS_LEVEL) then
	{
		if (%PARRY_LEVEL > %SHIELD_LEVEL) then
		{
			var CURR_STANCE Parry_Ability
		} else
		{
			var CURR_STANCE Shield_Usage
		}
	} else
	{
		if (%EVAS_LEVEL >= %SHIELD_LEVEL) then
		{
			var CURR_STANCE Evasion
		} else
		{
			var CURR_STANCE Shield_Usage
		}
	}
	action remove ^You are currently using (\d+)% of your weapon parry skill
	action remove ^You are currently using (\d+)% of your evasion skill
	action remove ^You are currently using (\d+)% of your shield block skill
	return

## Dances with a number of creatures
## The number of creatures to dance with 
COUNT:
DANCE:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** COUNT: ***
		echo
	}
	put #var GH_DANCING ON
	if (%1 > 6) then goto COUNT_6
	goto COUNT_%1
	COUNT_0:
	COUNT_1:
		var xCOUNT COUNT_ONE
		shift
		return
	COUNT_2:
		var xCOUNT COUNT_TWO
		shift
		return
	COUNT_3:
		var xCOUNT COUNT_THREE
		shift
		return
	COUNT_4:
		var xCOUNT COUNT_FOUR
		shift
		return
	COUNT_5:
		var xCOUNT COUNT_FIVE
		shift
		return
	COUNT_6:
		var xCOUNT COUNT_SIX
		shift
		return

## Danger, adds retreating to buffing
DANGER:

	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** DANGER: ***
		echo
	}
	put #var GH_BUFF_DANGER ON
	var casting 0
	action if %casting = 1 then put #send ret when closes to melee range on you\!$
	if toupper("$GH_BUFF") != "YES") then gosub BUFF
	return

DEF:
DEFA:
DEFAU:
DEFAUL:
DEFAULT:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** DEFAULT: ***
		echo Using Default Settings
		echo
	}
	gosub clear
	gosub GENERAL_TRIGGERS
	if ("$GH_MULTI" != "OFF") then goto DEFAULT_ERROR
	goto LOAD_DEFAULT_SETTINGS

DSET:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** DEFAULT-SET: ***
		echo Preparing to set Default settings
		echo
	}
	var DSET ON
	return

DMSET:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** DEFAULT-MULTI-SET: ***
		echo Preparing to setup up weapons to use in multi.
		echo Using other default settings
		echo
	}
	var SET_NUM 1
	SET_DM_STRING:
		if (SET_NUM > 10) then goto DONE_SET_DM
		put #var GH_MULTI_WEAPON_%SET_NUM %1
		math SET_NUM add 1
		shift
		if_1 goto SET_DM_STRING
	DONE_SET_DM:
	math SET_NUM subtract 1
	put #var GH_MULTI_NUM %SET_NUM
	goto DONE

DMULTI:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** DMULTI: ***
		echo
	}
	gosub clear
	put #var GH_EXP ON
	put #var GH_TRAIN ON
	put #var GH_MULTI DMULTI
	if matchre ("%1","^\d+$") then
		{
			put #var GH_MULTI_CURR_NUM %1
			if ($GH_MULTI_CURR_NUM > $GH_MULTI_NUM) then goto MULTI_ERROR
			goto DMULTI_$GH_MULTI_CURR_NUM
		}
	put #var GH_MULTI_CURR_NUM 1
	DMULTI_1:
		put .geniehunter MULTIWEAPON $GH_MULTI_WEAPON_1
	DMULTI_2:
		put .geniehunter MULTIWEAPON $GH_MULTI_WEAPON_2
	DMULTI_3:
		put .geniehunter MULTIWEAPON $GH_MULTI_WEAPON_3
	DMULTI_4:
		put .geniehunter MULTIWEAPON $GH_MULTI_WEAPON_4
	DMULTI_5:
		put .geniehunter MULTIWEAPON $GH_MULTI_WEAPON_5
	DMULTI_6:
		put .geniehunter MULTIWEAPON $GH_MULTI_WEAPON_6
	DMULTI_7:
		put .geniehunter MULTIWEAPON $GH_MULTI_WEAPON_7
	DMULTI_8:
		put .geniehunter MULTIWEAPON $GH_MULTI_WEAPON_8
	DMULTI_9:
		put .geniehunter MULTIWEAPON $GH_MULTI_WEAPON_9
	DMULTI_10:
		put .geniehunter MULTIWEAPON $GH_MULTI_WEAPON_10
	DMULTI_ERROR:
		echo
		echo *** DMULTI_ERROR: ***
		echo Something bad happened trying to multi-weapon with defaults
	goto DONE

## Non-lethal brawling, useful for Empaths or dancing
EMP:
EMPU:
EMPA:
EMPUF:
EMPAT:
EMPUFF:
EMPATH:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** EMPATH_BRAWLING: ***
		echo
	}
	gosub clear
	gosub GENERAL_TRIGGERS
	var WEAPON_EXP Brawling
	var COMBO1 parry
	var COMBO2 shove
	var COMBO3 circle
	var COMBO4 weave
	var COMBO5 bob
	var COMBO6 unused
	var COMBO7 unused
	var COMBO8 unused
	var EMPTY_HANDED ON
	counter add 500
	EMPATH_WEAPON_CHECK:
		var LAST EMPATH_WEAPON_CHECK
		if_1 then
		{
			if matchre ("%1","shield|buckler|pavise|heater|kwarf|sipar|lid|targe\b") then goto BRAWL_SETUP
			else 
			{
				var CURR_WEAPON %1
				shift
				gosub WIELD_WEAPON %CURR_WEAPON
				var EMPTY_HANDED OFF
			}
		}
		goto BRAWL_SETUP

## Sets the stance to evasion
DODGE:
EVAS:
EVAD:
EVASI:
EVADE:
EVASIO:
EVASION:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** EVASION: ***
		echo
	}
	var CURR_STANCE Evasion
	SET_EVAS_STANCE:
		var LAST SET_EVAS_STANCE
			match RETURN You are now set to
		put stance evasion
		matchwait 15
	return

## Will check exp, ends scripts when checked skill is locked
EXP:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** EXP: ***
		echo
	} 
	put #var GH_EXP ON
	return

## This will use feint during combat to keep balance up
FEINT:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** FEINT: ***
		echo
	}
	if ("%BACKSTAB" != "ON") then put #var GH_FEINT ON
	return

## Uses HUNT to train perception and stalk, but not move
HUNT:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** HUNT: ***
		echo
	}
	put #var GH_HUNT ON
	var HUNT_TIME 0
	return

## Juggles when no monsters
JUGG:
JUGGL:
JUGGLE:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** JUGGLE: ***
		echo
	}
	put #var GH_JUGGLE ON
	return

## Loots gems
JUNK:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** LOOT_JUNK: ***
		echo
	}
	if ("$GH_LOOT" != "ON") then put #var GH_LOOT ON
	put #var GH_LOOT_JUNK ON
	return

## Loots everything
LOOTA:
LOOTAL:
LOOTALL:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** LOOT_ALL: ***
		echo
	}
	put #var GH_LOOT ON
	put #var GH_LOOT_GEM ON
	put #var GH_LOOT_BOX ON
	put #var GH_LOOT_COIN ON  
	put #var GH_LOOT_COLL ON
	return

## Loots boxes
LOOTB:
LOOTBO:
LOOTBOX:
LOOTBOXE:
LOOTBOXES:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** LOOT_BOXES: ***
		echo
	}
	if ("$GH_LOOT" != "ON") then put #var GH_LOOT ON
	put #var GH_LOOT_BOX ON
	return

## Loots coins
LOOTC:
LOOTCO:
LOOTCOI:
LOOTCOIN:
LOOTCOINS:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** LOOT_COINS: ***
		echo
	}
	if ("$GH_LOOT" != "ON") then put #var GH_LOOT ON
	put #var GH_LOOT_COIN ON	
	return

## Loots gems
LOOTG:
LOOTGE:
LOOTGEM:
LOOTGEMS:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** LOOT_GEMS: ***
		echo
	}
	if ("$GH_LOOT" != "ON") then put #var GH_LOOT ON
	put #var GH_LOOT_GEM ON
	return

## Single cast of spell before non-magical combat
MAGIC:
	if contains("Barbarian|Thief|Trader", "%guild") then return
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** MAGIC: ***
		echo
	}
	counter add 2000
	var MAGIC ON
	var MAGIC_TYPE PM
	var ALTEXP ON
	var EXP2 Primary_Magic
	put #var GH_SPELL %1
	shift
	put #var GH_MANA %1
	shift
	if matchre ("%1","^\d+$") then
		{
			put #var GH_HARN %1
			if ("%GAG_ECHO" != "YES") then
			{
				echo *** Harnessing an extra %1 ***
			}
			shift
		} else put #var GH_HARN 0
	echo Casting $GH_SPELL with a prep of $GH_MANA and harnessing $GH_HARN
	if_1 return
	else goto BRAWL

## Starts training Multiple weapons
MULTI:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** MULTI: ***
		echo
	}
	gosub clear
	put #var GH_EXP ON
	put #var GH_TRAIN ON
	put #var GH_MULTI MULTI
	if matchre ("%1","^\d+$") then
		{
			put #var GH_MULTI_CURR_NUM %1
			if ($GH_MULTI_CURR_NUM > $GH_MULTI_NUM) then goto MULTI_ERROR
			goto MULTI_$GH_MULTI_CURR_NUM
		}
	put #var GH_MULTI_CURR_NUM 1
	MULTI_1:
		put .geniehunter MULTIWEAPON $GH_MULTI_1
	MULTI_2:
		put .geniehunter MULTIWEAPON $GH_MULTI_2
	MULTI_3:
		put .geniehunter MULTIWEAPON $GH_MULTI_3
	MULTI_4:
		put .geniehunter MULTIWEAPON $GH_MULTI_4
	MULTI_5:
		put .geniehunter MULTIWEAPON $GH_MULTI_5
	MULTI_6:
		put .geniehunter MULTIWEAPON $GH_MULTI_6
	MULTI_7:
		put .geniehunter MULTIWEAPON $GH_MULTI_7
	MULTI_8:
		put .geniehunter MULTIWEAPON $GH_MULTI_8
	MULTI_9:
		put .geniehunter MULTIWEAPON $GH_MULTI_9
	MULTI_10:
		put .geniehunter MULTIWEAPON $GH_MULTI_10
	MULTI_11:
		put .geniehunter MULTIWEAPON $GH_MULTI_11
	MULTI_12:
		put .geniehunter MULTIWEAPON $GH_MULTI_11
	MULTI_ERROR:
		echo
		echo *** MULTI_ERROR: ***
		echo Something bad happened trying to multi-weapon
	goto DONE

MSET:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** MULTI-SET: ***
		echo Preparing to setup up multi-weapon training
		echo
	}
	gosub clear
	var SET_NUM 1
	SET_M_STRING:
		if (SET_NUM > 11) then goto DONE_M_SET
		put #var GH_MULTI_%SET_NUM %1
		math SET_NUM add 1
		shift
		if_1 goto SET_M_STRING
	DONE_M_SET:
	math SET_NUM subtract 1
	put #var GH_MULTI_NUM %SET_NUM
	goto DONE

# Not using evasion stance in stance switching
NOEVADE:
NOEVAS:
NOEVASION:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** NOEVADE: ***
		echo
	}
	var NOEVADE ON
	return

# Not using parry stance in stance switching
NOPA:
NOPARRY:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** NOPARRY: ***
		echo
	}
	var NOPARRY ON
	return

# Not using shield stance in stance switching
NOSH:
NOSHIELD:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** NOSHIELD: ***
		echo
	}
	var NOSHIELD ON
	return

## Uses the weapon in the offhand
## Currently just for throwing weapons from the left hand
OFF:
OFFH:
OFFHA:
OFFHAN:
OFFHAND:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** OFFHAND: ***
		echo
	}
	var HAND left
	var HAND2 right
	var ALTEXP ON
	var EXP2 Offhand_Weapon
	return	

## Sets the stance to parry
PARRY:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** PARRY: ***
		echo
	}
	var CURR_STANCE Parry_Ability
	SET_PARRY_STANCE:
		var LAST SET_PARRY_STANCE
			match RETURN You are now set to
		put stance parry
		matchwait 15
	return

PP:
POW:
POWER:
POWERP:
	if contains("Barbarian|Thief|Trader", "%guild") then return
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** POWER PERCEIVE: ***
		echo
	}
	put #var GH_PP ON
	var PP_TIME 0
	return

## Casts a spell using non-targeted magic
PM:
TM:
	if contains("Barbarian|Thief|Trader", "%guild") then return
	if (toupper("%OPTION") = "TM") then 
	{
		var MAGIC OFF
		var MAGIC_TYPE TM
	} else 
	{
		var MAGIC OFF
		var MAGIC_TYPE PM
	}
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo ***  %MAGIC_TYPE:  ***
		echo
	}
	counter add 2000	
	var ALTEXP ON
	if (toupper("%MAGIC_TYPE") = "TM") then var EXP2 Targeted_Magic
	else var EXP2 Primary_Magic
	put #var GH_SPELL %1
	shift
	put #var GH_MANA %1
	shift
	if matchre ("%1","^\d+$") then
		{
			put #var GH_HARN %1
			if ("%GAG_ECHO" != "YES") then echo *** Harnessing an extra %1 ***
			shift
		} else put #var GH_HARN 0
	echo Casting $GH_SPELL with a prep of $GH_MANA and harnessing $GH_HARN
	if_1 return
	else goto BRAWL

## Poaching a target, if target is unpoachable, just fires 
POACH:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** POACH: ***
		echo
	}
	var FIRE_TYPE POACH
	var ALTEXP ON
	var EXP2 Stalking
	return

### Turns off Retreating
RET:
RETREAT:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** RETREAT: ***
		echo
	}
	put #var GH_RETREAT ON
	return

# Roam hunting area if all creatures in your room are dead
ROAM:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** ROAM: ***
		echo
	}
	put #var GH_ROAM ON
	return

# Scrape skins/pelts/hides after skinning
SCRAPE:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** SCRAPE: ***
		echo
	}
	if ("$GH_SKIN" != "ON") then gosub SKIN
	put #var GH_SCRAPE ON
	return

## Skins creatures that can be skinned
SKIN:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** SKIN: ***
		echo
	}
	var BELT_WORN OFF
	action var BELT_WORN ON when ^You tap a(.+)belt knife(.*)you are wearing
	put tap belt knife
	pause 1
	action remove ^You tap a(.*)belt knife(.*)you are wearing
	put #var GH_SKIN ON
	return

## Retreats while skinning
SKINR:
SKINRE:
SKINRET:
SKINRETREAT:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** SKINRET: ***
		echo
	}
	if ("$GH_SKIN" != "ON") then gosub SKIN
	put #var GH_SKIN_RET ON
	return

## Pauses between combat manuevers to sustain stamina
SLOW:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo ***  SLOW:  ***
		echo
	}
	put #var GH_SLOW ON
	if matchre ("%1", "(\d+)") then 
	{
		put #var GH_SLOW_PAUSE $1
		shift
	} else put #var GH_SLOW_PAUSE 3
	return

## Snapfires a ranged weapon or snapcasts spells
SNAP:
SNAPFIRE:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** SNAP: ***
		echo
	}
	put #var GH_SNAP ON
	if matchre ("%1", "(\d+)") then 
	{
		put #var GH_SNAP_PAUSE $1
		shift
	} else put #var GH_SNAP_PAUSE 0
	return

## Snipes with a ranged weapon
SNIP:
SNIPE:
SNIPING:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** SNIPE: ***
		echo
	}
	var FIRE_TYPE SNIPE
	var ALTEXP ON
	var EXP2 Hiding
	return

## Will cycle through stances
STA:
STAN:
STANC:
STANCE:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** STANCE: ***
		echo
	}
	action var PARRY_LEVEL $1 when ^You are currently using (\d+)% of your weapon parry skill
	action var EVAS_LEVEL $1 when ^You are currently using (\d+)% of your evasion skill
	action var SHIELD_LEVEL $1 when ^You are currently using (\d+)% of your shield block skill
	put #var GH_STANCE ON
	put stance
	waitfor Last Combat Maneuver:
	if (%PARRY_LEVEL > %EVAS_LEVEL) then
	{
		if (%PARRY_LEVEL > %SHIELD_LEVEL) then
		{
			var CURR_STANCE Parry_Ability
		} else
		{
			var CURR_STANCE Shield_Usage
		}
	} else
	{
		if (%EVAS_LEVEL >= %SHIELD_LEVEL) then
		{
			var CURR_STANCE Evasion
		} else
		{
			var CURR_STANCE Shield_Usage
		}
	}
	action remove ^You are currently using (\d+)% of your weapon parry skill
	action remove ^You are currently using (\d+)% of your evasion skill
	action remove ^You are currently using (\d+)% of your shield block skill
	echo %CURR_STANCE
	return

## Throws a stacked weapon (e.g. throwing blades)
STACK:
STACKS:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** STACK: ***
		echo
	}
	var STACK ON
	goto THROW

SWAP:
BAST:
BASTA:
BASTAR:
BASTARD:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** SWAP: ***
		echo
	}
	gosub clear
	gosub GENERAL_TRIGGERS
	var SWAP_TYPE %1
	var GOING_TO WEAPON_CHECK
	shift
	goto SWAP_WIELD

TSWAP:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** THROWN SWAP: ***
		echo
	}
	gosub clear
	gosub GENERAL_TRIGGERS
	var SWAP_TYPE %1
	var GOING_TO THROW_VARI	
	counter add 1200
	shift

	SWAP_WIELD:
		var LAST SWAP_WIELD
			matchre SWAP_%SWAP_TYPE You draw|re already|free ot
			match BEGIN_HANDS free hand|need to have your right hand
			matchre SWAP_REMOVE out of reach|remove|What were you|can't seem|Wield what\?
			match VARIABLE_ERROR You can only wield a weapon or a shield!
		put wield right my %1
		matchwait 15
	SWAP_REMOVE:
		var LAST SWAP_REMOVE
			matchre SWAP_%SWAP_TYPE You sling|re already|inventory|you remove
			matchre SWAP_GET Remove what|You aren't wearing
			match BEGIN_HANDS hands are full
		put remove my %1
		matchwait 15
	SWAP_GET:
		var LAST SWAP_GET
			match SWAP_%SWAP_TYPE You get
			match VARIABLE_ERROR What were you
		put get my %1
		matchwait 15
	goto VARIABLE_ERROR
		
	SWAP_1:
		var LAST SWAP_1
			matchre PAUSE two-handed
			match %GOING_TO heavy
		put swap my %1
		matchwait 15
		goto SWAP_ERROR	
	SWAP_2:
		var LAST SWAP_2
			matchre PAUSE heavy
			match %GOING_TO two-handed
		put swap my %1
		matchwait 15
		goto SWAP_ERROR
	SWAP_B:
		var LAST SWAP_B
			matchre PAUSE edged
			match %GOING_TO blunt
		put swap my %1
		matchwait 15
		goto SWAP_ERROR
	SWAP_E:	
		var LAST SWAP_E
			matchre PAUSE blunt
			match %GOING_TO edged
		put swap my %1
		matchwait 15
		goto SWAP_ERROR
	SWAP_PI:
		var LAST SWAP_PI
			matchre PAUSE halberd|short staff|quarter staff
			match %GOING_TO pike
		put swap my %1
		matchwait 60
		goto SWAP_ERROR
	SWAP_SS:
		var LAST SWAP_SS
			matchre PAUSE halberd|pike|quarter staff
			match %GOING_TO short staff
		put swap my %1
		matchwait 60
		goto SWAP_ERROR
	SWAP_HA:
		var LAST SWAP_HA
			matchre PAUSE short staff|pike|quarter staff
			match %GOING_TO halberd
		put swap my %1
		matchwait 60
		goto SWAP_ERROR
	SWAP_QS:
		var LAST SWAP_QS
			matchre PAUSE short staff|pike|halberd
			match %GOING_TO quarter staff
		put swap my %1
		matchwait 60
		goto SWAP_ERROR

## Sets a bodypart to target for ranged & spells
TARG:
TARGET:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** TARGET: ***
		echo
	}
	if matchre ("%1","^\D+$") then
	{
		put #VAR GH_TARGET %1
		echo Targetting the %1 with attacks.
		shift
	}
	return

## Will include tending routine
TEND:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** TEND: ***
		echo
	}
	put #var GH_TEND ON
	return
	
## Throws a weapon
THROW:
THROWN:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** THROWN: ***
		echo
	}
	gosub clear
	gosub GENERAL_TRIGGERS
	var THROWN ON
	counter add 1200
	WIELD_THROWN:
		var LAST WIELD_THROWN
			matchre THROW_VARI You draw|free to|re already
			match BEGIN_HANDS free hand|need to have your right hand
			matchre THROW_EQUIP out of reach|remove|What were you|can't seem|Wield what\?|^You can only wield
		put wield right my %1
		matchwait 60

	THROW_EQUIP:
			matchre THROW_VARI You sling|re already|inventory|You remove|right hand
			matchre THROW_EQUIP_2 ^Remove what\?|You aren't wearing that
			match BEGIN_HANDS hands are full
		put remove my %1
		matchwait 60

	THROW_EQUIP_2:
			matchre THROW_VARI ^You get|^You are already holding
			matchre VARIABLE_CHECK ^What were you
		put get my %1
		matchwait 85
	goto VARIABLE_ERROR

	THROW_VARI:  
		var LAST THROW_VARI
		var CURR_WEAPON %1
		if ("$GH_FEINT" = "ON") then put #var GH_FEINT OFF
		if ("%MAGIC_TYPE" != "OFF") then var MAGIC_COUNT %c
		if (("%HAND" = "left") && ("$lefthand" = "Empty")) then gosub SWAP_LEFT $righthandnoun
		else if_2 then gosub EQUIP_SHIELD %2
	APPRAISE_THROWN:
		var LAST APPRAISE_THROWN
		if (toupper("%CURR_WEAPON") = "LOG") then goto HT
		if (toupper("%CURR_WEAPON") = "ROCK") then goto LT
			match LT light thrown
			match HT heavy thrown
			matchre WEAPON_APPR_ERROR Roundtime|It's hard to appraise
		put appr my %CURR_WEAPON quick
		matchwait 85
		goto WEAPON_APPR_ERROR
	LT:
		var T_SHEATH %LT_SHEATH
		var WEAPON_EXP Light_Thrown
		if ("%DSET" = "ON") then goto SET_DEFAULT
		else goto %c
	HT:
		var T_SHEATH %HT_SHEATH
		var WEAPON_EXP Heavy_Thrown
		if ("%DSET" = "ON") then goto SET_DEFAULT
		else goto %c

## Will tie bundles.
TIE:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** TIE: ***
		echo
	}
	put #var GH_TIE ON
	if ("$GH_BUNDLE" != "ON") then gosub BUNDLE
	return
		
## Wears bunles
WEAR:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** WEAR: ***
		echo
	}
	put #var GH_WEAR ON
	if ("$GH_BUNDLE" != "ON") then gosub BUNDLE
	return
		
TIME:
TIMER:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** TIMER: ***
		echo
	}
	put #var GH_TIMER ON
	var START_TIME %t
	if matchre ("%1", "(\d+)") then 
	{
		var MAX_TRAIN_TIME $1
		shift
	}
	math MAX_TRAIN_TIME add %START_TIME
	return

TRAIN:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** TRAIN: ***
		echo
	}
	put #var GH_EXP ON
	put #var GH_TRAIN ON
	return

## Juggles a yoyo when no monsters
YOYO:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** YOYO: ***
		echo
	}
	put #var GH_JUGGLE ON
	var YOYO ON
	return

####################################
##                                ##
##    End variables & options     ##
##                                ##
####################################

BEGIN_HANDS:
	echo
	echo *** BEGIN_HANDS: ***
	echo
	echo *************************************
	echo **  Empty your hands and try again **
	echo **         Ending script           **
	echo *************************************
	echo
	exit

###############################
##                           ##
##  Weapon checking section  ##
##                           ##
###############################

WEAPON_CHECK:
	put #var GH_LAST_COMMAND appraise my %CURR_WEAPON quick
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** WEAPON_CHECK: ***
		echo
	}
	var LAST WEAPON_CHECK
	gosub clear
	if ("%BACKSTAB" != "ON") then var CURR_WEAPON %1
		matchre LE (a|and) light edged 
		matchre ME (a|and) medium edged
		matchre HE (a|and) heavy edged
		matchre 2HE (a|and) two-handed edged
		matchre LB (a|and) light blunt
		matchre MB (a|and) medium blunt
		matchre HB (a|and) heavy blunt
		matchre 2HB (a|and) two-handed blunt
		matchre STAFF_SLING (a|and) staff sling
		matchre SHORT_BOW (a|and) short bow
		matchre LONG_BOW (a|and) long bow
		matchre COMP_BOW (a|and) composite bow
		matchre LX  (a|and) light crossbow
		matchre HX (a|and) heavy crossbow
		matchre SHORT_STAFF (a|and) short staff
		matchre Q_STAFF (a|and) quarter staff
		matchre PIKE (a|and) pike 
		matchre HALBERD (a|and) halberd
		matchre SLING (a|and) sling
		matchre WEAPON_APPR_ERROR Roundtime|It's hard to appraise
	put appraise my %CURR_WEAPON quick
	matchwait 85
	goto WEAPON_APPR_ERROR

	2HE:
		echo
		echo *** 2HE: ***
		echo
		var WEAPON_EXP Twohanded_Edged
		var RANGED OFF
		var COMBO1 parry
		var COMBO2 feint
		var COMBO3 draw
		var COMBO4 sweep
		var COMBO5 slice
		var COMBO6 chop
		var COMBO7 unused
		var COMBO8 unused
		counter add 600
		if ("%HAND" = "left") then
		{
			var HAND
			var ALTEXP NONE
		}
		goto 2_HANDED_WEAPON

	HE:
		echo
		echo *** HE: ***
		echo
		var WEAPON_EXP Heavy_Edged
		var RANGED OFF
		var COMBO1 parry
		var COMBO2 feint
		var COMBO3 draw
		var COMBO4 sweep
		var COMBO5 slice
		var COMBO6 chop
		var COMBO7 unused
		var COMBO8 unused
		counter add 600
		goto 1_HANDED_WEAPON

	ME:
		echo
		echo *** ME: ***
		echo
		var WEAPON_EXP Medium_Edged
		var RANGED OFF
		if matchre("$righthand","adze|axe|cleaver|curlade|cutlass|hanger|hatchet|lata'oloh|mallet|mirror blade|nimsha|parang|sapara|scimitar|scythe-blade|shotel|sword|tei'oloh'ata|telo") then goto ME_SLICE
		if matchre("$righthand","blade|foil|gladius|nambeli|pasabas|rapier|sabre|shashqa|yataghan") then goto ME_STAB
		if matchre("$righthand","iltesh") then goto ME_ILTESH
		goto WEAPON_APPR_ERROR

		ME_SLICE:
			echo
			echo *** ME_SLICE: ***
			echo
			var COMBO1 parry
			var COMBO2 feint
			var COMBO3 draw
			var COMBO4 sweep
			var COMBO5 slice
			var COMBO6 chop
			var COMBO7 unused
			var COMBO8 unused
			counter add 600
		goto 1_HANDED_WEAPON

		ME_ILTESH:
			echo
			echo *** ME_ILTESH: ***
			echo
			var COMBO1 feint
			var COMBO2 draw
			var COMBO3 sweep
			var COMBO4 slice
			var COMBO5 chop
			var COMBO6 lunge
			var COMBO7 thrust
			var COMBO8 jab
			counter add 800
		goto 1_HANDED_WEAPON

		ME_STAB:
			echo
			echo *** ME_THRUST: ***
			echo
			var COMBO1 parry
			var COMBO2 feint
			var COMBO3 draw
			var COMBO4 sweep
			var COMBO5 thrust
			var COMBO6 unused
			var COMBO7 unused
			var COMBO8 unused
			counter add 500
		goto 1_HANDED_WEAPON

	LE:
		echo
		echo *** LE: ***
		echo
		var WEAPON_EXP Light_Edged
		var RANGED OFF
		if matchre("$righthandnoun", "bin|blade|bodkin|dagger|dirk|kasai|kindjal|lata|marlinspike|misericorde|pick|poignard|pugio|shavi|shriike|stiletto|takouba|telek") then goto LE_STAB 
		if matchre("$righthandnoun", "dao|jambiya|kanabu|katar|knife|kounmya|kris|kythe|nehlata|oben|sword|tago|uenlata") then goto LE_SLICE 
		goto WEAPON_APPR_ERROR

		LE_SLICE:
			echo
			echo *** LE_SLICE: ***
			echo
			var COMBO1 parry
			var COMBO2 feint
			var COMBO3 draw
			var COMBO4 slice
			var COMBO5 chop
			var COMBO6 sweep
			var COMBO7 unused
			var COMBO8 unused
			counter add 600
		goto 1_HANDED_WEAPON

		LE_STAB:
			echo
			echo *** LE_STAB: ***
			echo
			var COMBO1 parry
			var COMBO2 feint
			var COMBO3 lunge
			var COMBO4 thrust
			var COMBO5 jab
			var COMBO6 unused
			var COMBO7 unused
			var COMBO8 unused
			counter add 500
		goto 1_HANDED_WEAPON

	2HB:
		echo
		echo *** 2HB: ***
		echo  
		var RANGED OFF
		var WEAPON_EXP Twohanded_Blunt
		var COMBO1 dodge
		var COMBO2 feint
		var COMBO3 bash
		var COMBO4 sweep
		var COMBO5 draw
		var COMBO6 swing
		var COMBO7 unused
		var COMBO8 unused
		counter add 600
		if ("%HAND" = "left") then
		{
			var HAND
			var ALTEXP NONE
		}
		goto 2_HANDED_WEAPON

	HB:
		echo
		echo *** HB: ***
		echo
		var WEAPON_EXP Heavy_Blunt
		var RANGED OFF
		var COMBO1 dodge
		var COMBO2 feint
		var COMBO3 bash
		var COMBO4 sweep
		var COMBO5 draw
		var COMBO6 swing
		var COMBO7 unused
		var COMBO8 unused
		counter add 600
		goto 1_HANDED_WEAPON

	MB:
		echo
		echo *** MB: ***
		echo
		var WEAPON_EXP Medium_Blunt
		var RANGED OFF
		var COMBO1 dodge
		var COMBO2 feint
		var COMBO3 bash
		var COMBO4 sweep
		var COMBO5 draw
		var COMBO6 swing
		var COMBO7 unused
		var COMBO8 unused
		counter add 600
		goto 1_HANDED_WEAPON

	LB:
		echo
		echo *** LB: ***
		echo
		var WEAPON_EXP Light_Blunt
		var RANGED OFF
		var COMBO1 dodge
		var COMBO2 feint
		var COMBO3 bash
		var COMBO4 sweep
		var COMBO5 draw
		var COMBO6 jab
		var COMBO7 swing
		var COMBO8 unused
		counter add 700
		goto 1_HANDED_WEAPON

	HALBERD:
		echo
		echo *** HALBERD: ***
		echo
		var WEAPON_EXP Halberds
		var RANGED OFF
		var COMBO1 dodge
		var COMBO2 feint
		var COMBO3 thrust
		var COMBO4 sweep
		var COMBO5 chop
		var COMBO6 jab
		var COMBO7 unused
		var COMBO8 unused
		counter add 600
		if ("%HAND" = "left") then
		{
			var HAND
			var ALTEXP NONE
		}
		goto 2_HANDED_WEAPON

	PIKE:
		echo
		echo *** PIKE: ***
		echo
		var WEAPON_EXP Pikes
		var RANGED OFF
		var COMBO1 dodge
		var COMBO2 jab
		var COMBO3 sweep
		var COMBO4 thrust
		var COMBO5 lunge
		var COMBO6 unused
		var COMBO7 unused
		var COMBO8 unused
		counter add 500
		if ("%HAND" = "left") then
		{
			var HAND
			var ALTEXP NONE
		}
		goto 2_HANDED_WEAPON

	SHORT_STAFF:
		echo
		echo *** SHORT_STAFF: ***
		echo
		var WEAPON_EXP Short_Staff
		var RANGED OFF
		var COMBO1 parry
		var COMBO2 thrust
		var COMBO3 sweep
		var COMBO4 chop
		var COMBO5 jab
		var COMBO6 unused
		var COMBO7 unused
		var COMBO8 unused
		counter add 500
		goto 1_HANDED_WEAPON

	Q_STAFF:
		echo
		echo *** QUARTER_STAFF: ***
		echo
		var WEAPON_EXP Quarter_Staff
		var RANGED OFF
		var COMBO1 parry
		var COMBO2 thrust
		var COMBO3 sweep
		var COMBO4 bash
		var COMBO5 draw
		var COMBO6 slice
		var COMBO7 unused
		var COMBO8 unused
		counter add 600
		if ("%HAND" = "left") then
		{
			var HAND
			var ALTEXP NONE
		}
		goto 2_HANDED_WEAPON

	SHORT_BOW:
		echo
		echo *** SHORT_BOW: ***
		echo  
		var WEAPON_EXP Short_Bow
		var RANGED ON
		var AMMO %BOW_AMMO
		pause 1
		put ret
		counter add 1000
		goto 2_HANDED_WEAPON

	LONG_BOW:
		echo
		echo *** LONG_BOW: ***
		echo  
		var WEAPON_EXP Long_Bow
		var RANGED ON
		var AMMO %BOW_AMMO
		pause 1
		put ret
		counter add 1000
		goto 2_HANDED_WEAPON

	COMP_BOW:
		echo
		echo *** COMP_BOW: ***
		echo  
		var WEAPON_EXP Composite_Bow
		var RANGED ON
		var AMMO %BOW_AMMO
		pause 1
		put ret
		counter add 1000
		goto 2_HANDED_WEAPON

	HX:
		echo
		echo *** HX: ***
		echo  
		var WEAPON_EXP Heavy_Crossbow
		var RANGED ON
		var AMMO %XB_AMMO
		pause 1
		put ret
		counter add 1000
		goto 2_HANDED_WEAPON

	LX:
		echo
		echo *** LX: ***
		echo  
		var WEAPON_EXP Light_Crossbow
		var RANGED ON
		var AMMO %XB_AMMO
		pause 1
		put ret
		counter add 1000
		goto LX_SLING

	SLING:
		echo
		echo *** SLING: ***
		echo  
		var WEAPON_EXP Slings
		var RANGED ON
		var AMMO %SLING_AMMO
		pause 1
		put ret
		counter add 1000
		goto LX_SLING

	STAFF_SLING:
		echo
		echo *** STAFF_SLING: ***  
		echo  
		var WEAPON_EXP Staff_Sling
		var RANGED ON
		var AMMO %SLING_AMMO
		pause 1
		put ret
		counter add 1000
		goto 2_HANDED_WEAPON

	2_HANDED_WEAPON:
		var LAST 2_HANDED_WEAPON
		save %c
		if (("%RANGED" = "ON") && ("$GH_FEINT" = "ON")) then put #var GH_FEINT OFF
		if ("%MAGIC_TYPE" != "OFF") then var MAGIC_COUNT %c
		if ("%DSET" = "ON") then goto SET_DEFAULT
		goto COUNT_$GH_DANCING

	1_HANDED_WEAPON:
		var LAST 1_HANDED_WEAPON
		save %c
		if ("%MAGIC_TYPE" != "OFF") then var MAGIC_COUNT %c
		if ("%DSET" = "ON") then goto SET_DEFAULT
		if (("%HAND" = "left") && ("$lefthand" = "Empty")) then gosub SWAP_LEFT $righthandnoun
		else if_2 then gosub EQUIP_SHIELD %2
		goto COUNT_$GH_DANCING

	LX_SLING:
		var LAST LX_SLING
		save %c
		if ("$GH_FEINT" = "ON") then put #var GH_FEINT OFF
		if ("%MAGIC_TYPE" != "OFF") then var MAGIC_COUNT %c
		if ("%DSET" = "ON") then goto SET_DEFAULT
		if_2 then gosub EQUIP_SHIELD %2
		goto COUNT_$GH_DANCING

	BRAWL_SETUP:
		var LAST BRAWL_SETUP
		save %c
		if ("%MAGIC_TYPE" != "OFF") then var MAGIC_COUNT %c
		if ("%DSET" = "ON") then goto SET_DEFAULT
		if_1 then gosub EQUIP_SHIELD %1
		goto COUNT_$GH_DANCING

#######################
##                   ##
##   Useful gosubs   ##
##                   ##
#######################
SWAP_LEFT:
	var ITEM $1
SWAPPING_LEFT:
		matchre SWAPPING_LEFT %ITEM(.*)to your right hand
		matchre RETURN %ITEM(.*)to your left hand
	put swap
	matchwait 85
	goto SWAP_ERROR

SWAP_RIGHT:
	var ITEM $1
SWAPPING_RIGHT:
		matchre SWAPPING_RIGHT %ITEM(.*)to your left hand
		matchre RETURN %ITEM(.*)to your right hand
	put swap
	matchwait 85
	goto SWAP_ERROR

EQUIP_SHIELD:
	if ("%SHIELD" = "NONE") then var SHIELD $1
	pause 0.5
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** EQUIP_SHIELD: ***
		echo
	}
	GETTING_SHIELD:
			match WEAPON_APPR_ERROR What were you
			matchre RETURN already|You get|You sling|You remove
		put remove my %SHIELD
		put get my %SHIELD
		matchwait 85
	EQUIP_SHIELD_FAIL:
		echo
		echo *** Something happened while getting shield ***
		echo ***           Aborting script               ***
		echo
		gosub clear
		put #beep
		goto ERROR_DONE

UNEQUIP_SHIELD:
	pause 0.5
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** UNEQUIP_SHIELD ***
		echo
	}
	STOWING_SHIELD:
			matchre RETURN You put your|You sling|You are already wearing that|But that is already in your inventory
		put wear my %SHIELD
		put stow my %SHIELD
		matchwait 85
	UNEQUIP_SHIELD_FAIL:
		echo
		echo *** Something happened while stowing shield ***
		echo ***           Aborting script               ***
		echo
		gosub clear
		put #beep
		goto ERROR_DONE

WIELD_WEAPON:
	var STRING $1
	pause 0.5
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** WIELD_WEAPON: ***
		echo
	}
	WIELDING_WEAPON:
			matchre REMOVING_WEAPON out of reach|You'll need to remove|What were you|can't seem|is out of reach|You can only wield
			matchre RETURN You draw|already holding|You deftly remove|With a flick of your wrist|With fluid and stealthy movements|You slip a 
		put wield my %STRING
		matchwait 12
	REMOVING_WEAPON:
			matchre WIELD_FAIL free hand|hands are full
			matchre GETTING_WEAPON Remove what?|You aren't wearing
			matchre RETURN You sling|already holding|inventory|You remove|You deftly remove
		put remove my %STRING
		matchwait 12
	GETTING_WEAPON:
			matchre WIELD_FAIL Please rephrase that command|What were you
			matchre RETURN You get|You are already holding
		put get my %STRING
		matchwait 12
	WIELD_FAIL:
		echo
		echo *** Something happened during wielding ***
		echo ***           Aborting script          ***
		echo
		gosub clear
		put #beep
		goto ERROR_DONE

SHEATHE:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** SHEATHE ***
		echo
	}
	if ("$0" = "blades") then var COMM_STRING blade
	else var COMM_STRING $0
	pause 0.5
	SHEATHING:
			matchre WEAR_WEAPON where\?
			matchre RETURN ^You sheath|^You strap|^With a flick of your wrist|^You hang|you sheath|^Sheathe what\?|^You easily strap|^With fluid and stealthy movements|^You slip|^You secure
		put shea %COMM_STRING
		matchwait 12
	WEAR_WEAPON:
			match STOW_WEAPON You can't wear that!
			matchre RETURN You sling|Wear what?|You attach
		put wear %COMM_STRING
		matchwait 12
	STOW_WEAPON:
			matchre RETURN You put|easily strap|already in your inventory
		put stow %COMM_STRING
		matchwait 85
	SHEATHE_FAIL:
		echo
		echo *** Something happened during sheathing ***
		echo ***           Aborting script           ***
		echo
		gosub clear
		put #beep 
		goto ERROR_DONE

RANGE_SHEATHE:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** RANGE_SHEATHE: ***
		echo
	}   
	pause 1
	put ret
	waitfor You
	pause 1
	put unload %CURR_WEAPON
	pause 1
	STOW_AMMO:
			matchre STOW_AMMO You pick up|You put
			match GO_ON Stow what?
		if "%AMMO" = "basilisk head arrow" then put stow basilisk arrow
		else
		put stow %AMMO
		matchwait 40
	GO_ON:
		pause 1
		gosub SHEATHE %CURR_WEAPON
	return

############################################
##                                        ##
##  Default section, setting and loading  ##
##                                        ##
############################################
SET_DEFAULT:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** SET_DEFAULT ***
		echo Setting default values
		echo
	}
	put #var GH_DEF_SET YES
	put #var GH_DEF_COUNTER %c
	put #var GH_DEF_ALTEXP %ALTEXP
	put #var GH_DEF_AMMO %AMMO
	put #var GH_DEF_BACKSTAB %BACKSTAB
	put #var GH_DEF_COMBO1 %COMBO1
	put #var GH_DEF_COMBO2 %COMBO2
	put #var GH_DEF_COMBO3 %COMBO3
	put #var GH_DEF_COMBO4 %COMBO4
	put #var GH_DEF_COMBO5 %COMBO5
	put #var GH_DEF_COMBO6 %COMBO6
	put #var GH_DEF_COMBO7 %COMBO7
	put #var GH_DEF_COMBO8 %COMBO8
	put #var GH_DEF_CURR_STANCE %CURR_STANCE
	put #var GH_DEF_WEAPON %CURR_WEAPON
	put #var GH_DEF_EMPTY_HANDED %EMPTY_HANDED
	put #var GH_DEF_EVAS_LVL %EVAS_LEVEL
	put #var GH_DEF_EXP2 %EXP2
	put #var GH_DEF_FIRE_TYPE %FIRE_TYPE
	if ("%HAND" = "") then put #var GH_DEF_HAND none
	else put #var GH_DEF_HAND %HAND
	put #var GH_DEF_HAND2 %HAND2
	put #var GH_DEF_MAGIC %MAGIC
	put #var GH_DEF_MAGIC_TYPE %MAGIC_TYPE
	put #var GH_DEF_MAGIC_COUNT %MAGIC_COUNT
	put #var GH_DEF_MAX_TRAIN_TIME %MAX_TRAIN_TIME
	put #var GH_DEF_NOEVADE %NOEVADE
	put #var GH_DEF_NOPARRY %NOPARRY
	put #var GH_DEF_NOSHIELD %NOSHIELD
	put #var GH_DEF_PARRY_LVL %PARRY_LEVEL
	put #var GH_DEF_RANGED %RANGED
	put #var GH_DEF_RUCK %RUCK
	put #var GH_DEF_SHIELD %SHIELD
	put #var GH_DEF_SHIELD_LVL %SHIELD_LEVEL
	put #var GH_DEF_STACK %STACK
	put #var GH_DEF_THROWN %THROWN
	put #var GH_DEF_WEAPON_EXP %WEAPON_EXP
	put #var GH_DEF_XCOUNT %xCOUNT
	put #var GH_DEF_YOYO %YOYO
	
	put #var GH_DEF_AMBUSH $GH_AMBUSH
	put #var GH_DEF_APPR $GH_APPR
	put #var GH_DEF_ARRANGE $GH_ARRANGE
	put #var GH_DEF_BUN $GH_BUN 
	put #var GH_DEF_COUNTING $GH_DANCING
	put #var GH_DEF_EXP $GH_EXP
	put #var GH_DEF_HARN $GH_HARN
	put #var GH_DEF_HUNT $GH_HUNT
	if ("$GH_HUNT" = "ON") then var HUNT_TIME 0
	put #var GH_DEF_JUGGLE $GH_JUGGLE
	put #var GH_DEF_LOOT $GH_LOOT
	put #var GH_DEF_LOOT_BOX $GH_LOOT_BOX
	put #var GH_DEF_LOOT_COIN $GH_LOOT_COIN
	put #var GH_DEF_LOOT_COLL $GH_LOOT_COLL
	put #var GH_DEF_LOOT_GEM $GH_LOOT_GEM
	put #var GH_DEF_LOOT_JUNK $GH_LOOT_JUNK
	put #var GH_DEF_MANA $GH_MANA
	put #var GH_DEF_PP $GH_PP
	put #var GH_DEF_RETREAT $GH_RETREAT
	put #var GH_DEF_ROAM $GH_ROAM
	put #var GH_DEF_SCRAPE $GH_SCRAPE
	put #var GH_DEF_SKIN $GH_SKIN
	put #var GH_DEF_SKIN_RET $GH_SKIN_RET
	put #var GH_DEF_SLOW $GH_SLOW
	put #var GH_DEF_SNAP $GH_SNAP
	put #var GH_DEF_SPELL $GH_SPELL
	put #var GH_DEF_STANCE $GH_STANCE
	if ("$GH_TARGET" = "") then put #var GH_DEF_TARGET none
	else put #var GH_DEF_TARGET $GH_TARGET
	put #var GH_DEF_TIMER $GH_TIMER 
	put #var GH_DEF_TRAIN $GH_TRAIN
	
	echo 
	echo Default setting are now ready
	echo
	exit

LOAD_DEFAULT_SETTINGS:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** LOAD_DEFAULT_SETTINGS ***
		echo
	}
	gosub GENERAL_TRIGGERS
	## Loading default nonweapon settings
	var ALTEXP $GH_DEF_ALTEXP
	var BACKSTAB $GH_DEF_BACKSTAB
	var CURR_STANCE $GH_DEF_CURR_STANCE
	var EMPTY_HANDED $GH_DEF_EMPTY_HANDED
	var EVAS_LEVEL $GH_DEF_EVAS_LVL
	var EXP2 $GH_DEF_EXP2
	var FIRE_TYPE $GH_DEF_FIRE_TYPE
	if ("$GH_DEF_HAND" = "none") then var HAND
	else var HAND $GH_DEF_HAND
	var HAND2 $GH_DEF_HAND2
	var MAGIC $GH_DEF_MAGIC
	var MAGIC_TYPE $GH_DEF_MAGIC_TYPE
	var MAGIC_COUNT $GH_DEF_MAGIC_COUNT
	var PARRY_LEVEL $GH_DEF_PARRY_LVL
	var RANGED $GH_DEF_RANGED
	var RUCK $GH_DEF_RUCK
	var SHIELD_LEVEL $GH_DEF_SHIELD_LVL
	var STACK $GH_DEF_STACK
	var THROWN $GH_DEF_THROWN
	var xCOUNT $GH_DEF_XCOUNT
	var YOYO $GH_DEF_YOYO
	
	put #var GH_AMBUSH $GH_DEF_AMBUSH
	put #var GH_APPR $GH_DEF_APPR
	put #var GH_ARRANGE $GH_DEF_ARRANGE
	put #var GH_BUN $GH_DEF_BUN
	put #var GH_DANCING $GH_DEF_COUNTING
	if ("$GH_MULTI" = "OFF") then put #var GH_EXP $GH_DEF_EXP
	put #var GH_HARN $GH_DEF_HARN
	put #var GH_HUNT $GH_DEF_HUNT
	if ("$GH_HUNT" = "ON") then var HUNT_TIME 0
	put #var GH_JUGGLE $GH_DEF_JUGGLE
	put #var GH_LOOT $GH_DEF_LOOT
	put #var GH_LOOT_BOX $GH_DEF_LOOT_BOX
	put #var GH_LOOT_COIN $GH_DEF_LOOT_COIN
	put #var GH_LOOT_COLL $GH_DEF_LOOT_COLL
	put #var GH_LOOT_GEM $GH_DEF_LOOT_GEM
	put #var GH_LOOT_JUNK $GH_DEF_LOOT_JUNK
	put #var GH_MANA $GH_DEF_MANA
	put #var GH_PP $GH_DEF_PP
	put #var GH_RETREAT $GH_DEF_RETREAT	
	put #var GH_ROAM $GH_DEF_ROAM
	put #var GH_SCRAPE $GH_DEF_SCRAPE
	put #var GH_SKIN $GH_DEF_SKIN
	put #var GH_SKIN_RET $GH_DEF_SKIN_RET
	put #var GH_SLOW $GH_DEF_SLOW
	put #var GH_SNAP $GH_DEF_SNAP
	put #var GH_SPELL $GH_DEF_SPELL
	put #var GH_STANCE $GH_DEF_STANCE
	if ("$GH_DEF_TARGET" = "none") then put #var GH_TARGET 
	else put #var GH_TARGET  $GH_DEF_TARGET	
	put #var GH_TIMER $GH_DEF_TIMER
	if ("$GH_MULTI" = "OFF") then put #var GH_TRAIN $GH_DEF_TRAIN
	
	var MAX_TRAIN_TIME $GH_DEF_MAX_TRAIN_TIME
	DEF_STANCE_SETUP:
		if ("%CURR_STANCE" = "Evasion") then put stance evasion
		elseif ("%CURR_STANCE" = "Parry_Ability") then put stance parry
		elseif ("%CURR_STANCE" = "Shield_Usage") then put stance shield
		elseif ("%CURR_STANCE" = "Custom") then put stance custom

	if ("$GH_MULTI" != "OFF") then goto BEGIN

	## Loading default weapon settings
	var AMMO $GH_DEF_AMMO
	var COMBO1 $GH_DEF_COMBO1
	var COMBO2 $GH_DEF_COMBO2
	var COMBO3 $GH_DEF_COMBO3
	var COMBO4 $GH_DEF_COMBO4
	var COMBO5 $GH_DEF_COMBO5
	var COMBO6 $GH_DEF_COMBO6
	var COMBO7 $GH_DEF_COMBO7
	var COMBO8 $GH_DEF_COMBO8
	counter set $GH_DEF_COUNTER
	var RANGED $GH_DEF_RANGED
	var SHIELD $GH_DEF_SHIELD
	var CURR_WEAPON $GH_DEF_WEAPON
	var WEAPON_EXP $GH_DEF_WEAPON_EXP
	echo
	echo Ready to go!
	echo
	var LAST DEF_WIELD_WEAPON
	DEF_WIELD_WEAPON:
			matchre SWAP_CHECK You draw|already holding|free to
			match BEGIN_HANDS free hand
			matchre DEF_REMOVE_WEAPON out of reach|remove|What were you|can't seem|Wield what\?
		put wield my %CURR_WEAPON
		matchwait 16
	DEF_REMOVE_WEAPON:		
			matchre SWAP_CHECK You sling|already holding|inventory|You remove
			matchre BEGIN_HANDS free hand|hands are full
			match DEF_GET_WEAPON Remove what?
		put remove my %CURR_WEAPON
		matchwait 85
	DEF_GET_WEAPON:
			match SWAP_CHECK you get
			match NO_VALUE Please rephrase that command
		put get my %CURR_WEAPON
		matchwait 85
	goto VARIABLE_ERROR
	SWAP_CHECK:
		var LAST SWAP_CHECK
		if (("%HAND" = "left") && ("$lefthand" = "Empty")) then gosub SWAP_LEFT $righthandnound
		elseif ("%SHIELD" != "NONE") then gosub EQUIP_SHIELD %SHIELD
	goto %c

#####################################
##                                 ##
##  Action initialization section  ##
##                                 ##
#####################################
GENERAL_TRIGGERS:
	action (geniehunter) goto STAND when eval $standing = 0
	action (geniehunter) goto STAND when You should stand up first|You had better stand up first
	action put #var standing 1 when You are already standing
	action (geniehunter) goto DONE when reaches over and holds your hand|grabs your arm and drags you|clasps your hand tenderly
	action (geniehunter) goto WEBBED when eval $webbed = 1
	action (geniehunter) goto WEBBED when You can't do that while entangled in a web
	action (geniehunter) goto STUNNED when eval $stunned = 1
	action (geniehunter) goto BLEEDING when eval $bleeding = 1
	action (geniehunter) goto ABORT when eval $health < 40
	action (geniehunter) goto DEAD when eval $dead = 1
	action (geniehunter) goto DROPPED_WEAPON when Your fingers go numb as you drop|You have nothing to swap|You don't have a weapon|With your bare hands\?
	action (geniehunter) goto HUM_STOP when You are a bit too busy performing|You should stop playing|You are concentrating too much upon your performance
	
	action var lastmaneuver parry when Last Combat Maneuver.*Parry
	action var lastmaneuver feint when Last Combat Maneuver.*Feint
	action var lastmaneuver draw when Last Combat Maneuver.*Draw
	action var lastmaneuver sweep when Last Combat Maneuver.*Sweep
	action var lastmaneuver slice when Last Combat Maneuver.*Slice
	action var lastmaneuver chop when Last Combat Maneuver.*Chop
	action var lastmaneuver bash when Last Combat Maneuver.*Bash
	action var lastmaneuver thrust when Last Combat Maneuver.*Thrust
	action var lastmaneuver shove when Last Combat Maneuver.*Shove
	action var lastmaneuver jab when Last Combat Maneuver.*Jab
	action var lastmaneuver dodge when Last Combat Maneuver.*Dodge
	action var lastmaneuver claw when Last Combat Maneuver.*Claw
	action var lastmaneuver dodge when Last Combat Maneuver.*Dodge
	action var lastmaneuver kick when Last Combat Maneuver.*Kick
	action var lastmaneuver weave when Last Combat Maneuver.*Weave
	action var lastmaneuver punch when Last Combat Maneuver.*Punch
	action var lastmaneuver lunge when Last Combat Maneuver.*Lunge
	action var lastmaneuver bob when Last Combat Maneuver.*Bob
	action var lastmaneuver circle when Last Combat Maneuver.*Circle
	return

RETREAT_TRIGGERS:
	var RETREATING ON
	var RETREATED NO
	action if ("%RETREATED" = "YES") then put #queue clear;send ret;var RETREATED YES when closes to pole weapon range
MELEE_TRIGGERS:
	action if ("%RETREATED" = "YES") then put #queue clear;send ret;send ret;var RETREATED YES when (^\*.*at you\..*You)|(closes to melee range on you)
	action var RETREATED NO when You retreat from combat
	action var RETREATED NO when You try to back away
	return

RETREAT_UNTRIGGERS:
	var RETREATING OFF
	action remove closes to pole weapon range
	action remove (^\*.*at you\..*You)|(closes to melee range on you)
	action remove You retreat from combat
	action remove You try to back away
	return

#####################################
##                                 ##
##  End of Initialization section  ##
##                                 ##
#####################################
ADVANCE:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** ADVANCE: ***
		echo
	}
	counter set %s
	ADV_NOW:
		if (($hidden = 1) && ("%guild" = "Paladin")) then put unhid
		var LAST ADV_NOW
			matchre FACE You stop advancing|You have lost sight
			match NO_MONSTERS advance towards?
			matchre ADVANCING ^You begin
			matchre ADVANCING_FURTHER ^You are already advancing
			match %c already at melee
		put advance
		matchwait 85
		goto ERROR
	ADVANCING:
		if ("$GH_APPR" = "YES") then goto APPR_YES
	ADVANCING_FURTHER:
		waitforre to melee range|\[You're|You stop advancing because|You have lost sight of your target
		goto APPR_NO

APPR_YES:
	if (("%APPRAISED" = "YES") || ($Appraisal.LearningRate >= 30)) then goto COUNT_$GH_DANCING
	else var APPRAISED YES
	var LAST APPR_YES
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** APPR_YES: ***
		echo
	}
	if matchre ("$monsterlist", "\b(%nonskinnablecritters)\b") then goto APPR_CREEP
	if matchre ("$monsterlist", "\b(%skinnablecritters)\b") then goto APPR_CREEP
	if matchre ("$monsterlist", "\b(%invasioncritters)\b") then goto APPR_CREEP
	goto APPR_NO
	APPR_CREEP:
		var Monster $0
	APPRAISING:
		var LAST APPRAISING
			matchre APPR_NO Roundtime|Appraise|You can't determine|appraise|You don't see|still stunned
		put appr %Monster quick
		matchwait 85
	goto APPR_ERROR

APPR_NO: 
	var lastdirection none
	goto COUNT_$GH_DANCING

COUNT_ON:
	var LAST COUNT_ON
COUNT_START:
	if (toupper("$GH_STANCE") = "ON")) then gosub SWITCH_STANCE
	if (($Multi_Opponent.LearningRate > 20) || ($%ARMOR1.LearningRate > 20) || ($%ARMOR2.LearningRate > 20)) then goto COUNT_OFF
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** COUNT_START: ***
		echo
	} 
	goto %xCOUNT
		match COUNT_WAIT_1 You notice only one
	COUNT_ONE:
		matchre %c ^You notice two
	COUNT_TWO:
		matchre %c ^You notice three
	COUNT_THREE:
		matchre %c ^You notice four
	COUNT_FOUR:
		matchre %c ^You notice five
	COUNT_FIVE:
		matchre %c ^You notice six
	COUNT_SIX:
		matchre %c ^You notice (seven|eight|nine|ten|eleven|twelve|twenty)
		matchre %c ^You notice (.+)teen
		matchre COUNT_WAIT_1 ^You notice no
		matchre COUNT_WAIT_1 ^Roundtime
	put count critter
	matchwait 85
	goto ERROR

COUNT_OFF:
	goto %c

FACE:      
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** FACE: ***
		echo
	}
	var LAST FACE
		match APPR_$GH_APPR You turn to face
		matchre CHECK_FOR_MONSTER nothing else to|Face what
	put face next
	matchwait 85
	goto ERROR

CHECK_FOR_MONSTER:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** CHECK_FOR_MONSTER ***
		echo
	}
	if (($hidden = 1) && ("%guild" = "Paladin")) then put unhide
	counter set %s
	if matchre ("$monsterlist", "\b(%nonskinnablecritters)\b") then goto APPR_$GH_APPR
	if matchre ("$monsterlist", "\b(%skinnablecritters)\b") then goto APPR_$GH_APPR
	if matchre ("$monsterlist", "\b(%invasioncritters)\b") then goto APPR_$GH_APPR
	goto NO_MONSTERS

NO_MONSTERS:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** NO_MONSTERS: ***
		echo
	}
	if ("%RANGED" = "ON") then 
	{
		if (matchre("$roomobjs", "%AMMO\b")) then gosub RANGED_CLEAN
	}
	if ("%THROWN" = "ON") then
	{
		if (matchre("$roomobjs", "%CURR_WEAPON\b")) then 
		{
			put get %CURR_WEAPON
		}
	}
	if ((toupper("$GH_JUGGLE") = "ON") && ($Perception.LearningRate <= 25)) then goto JUGGLE_STUFF
	if (toupper("$GH_ROAM") = "ON") then goto MOVE_ROOMS
	else
	{
		if ($hidden = 1) then put unhide
		pause 3
		waitforre \.|\?|!|pole|melee|advance
		goto FACE 
	}

JUGGLE_STUFF:
	timer stop
	var LAST JUGGLE_STUFF
	if ("%SHIELD" != "NONE") then gosub UNEQUIP_SHIELD
	if ("%EMPTY_HANDED" != "ON") then
	{
		if ("%RANGED" = "ON") then gosub RANGE_SHEATHE
		else gosub SHEATHE %CURR_WEAPON
	}
	if ("%YOYO" = "OFF") then
	{
		action put hum %HUM_SONG %HUM_DIFFICULTY when ^You finish	
	}
	action goto JUGGLE_STOP when ^\*.*at you\..*You|begins to advance on you|to melee range|to polee range|You're|already at melee	
	JUGGLE_TOP:
		var LAST JUGGLE_TOP
		if ("%YOYO" = "OFF") then put hum $HUM_SONG $HUM_DIFFICULTY
		if ("%JUGGLIE" = "pebble") then goto juggle
			match NO_JUGGLIE What were you referring to
			matchre YOYO_%YOYO You get|You are already
		put get my %JUGGLIE
		matchwait 40
		goto JUGGLE_ERROR
	YOYO_ON:
			match JUGGLING You slip the string
		put wear my %JUGGLIE
		matchwait 40
		goto JUGGLE_ERROR
	YOYO_OFF:
	JUGGLING:
		if matchre ("$monsterlist", "%critters") then goto JUGGLE_STOP
		var LAST JUGGLING
			matchre JUGGLE_ERROR Your injuries make juggling|But you're not holding|You realize that if your throw|Your wounds begin aching
			match JUGGLE_EXP Roundtime
		if ("%YOYO" = "ON") then put throw my %JUGGLIE
		else put juggle my $JUGGLIE
		matchwait 40
		goto JUGGLE_ERROR	
	JUGGLE_EXP: 
		if $Perception.LearningRate > 22 then goto JUGGLE_STOP
		goto JUGGLING
	JUGGLE_ERROR:
		echo *** Juggling error ***
		put #var GH_JUGGLE OFF
		goto JUGGLE_STOP
	NO_JUGGLIE:
		echo *** Can't find your JUGGLIE ***
	JUGGLE_STOP:
		action remove ^You finish
		action remove ^\*.*at you\..*You|begins to advance on you|to melee range|to polee range|You're|already at melee
		var LAST JUGGLE_STOP
		pause
		if ("%YOYO" = "ON") then
		{
			put remove %JUGGLIE
			waitfor off of your finger
		}
		pause 0.5
		put stop hum
		put stow %JUGGLIE
		waitfor You put your
		if "$righthand" != "Empty" then put stow right
		if "$lefthand" != "Empty" then put stow left
	JUGGLE_DONE:
		var LAST JUGGLE_DONE
		if ("%EMPTY_HANDED" != "ON") then gosub WIELD_WEAPON %CURR_WEAPON
		if (("%HAND" = "left") && ("$righthand" != "Empty")) then gosub SWAP_LEFT $righthandnoun
		if ("%SHIELD" != "NONE") then gosub EQUIP_SHIELD
		timer start
		goto FACE

MOVE_ROOMS:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** MOVE_ROOMS: ***
		echo
	}	
	echo No monsters here, moving rooms
	pause 1

	var ROOMNUMBER 0
HUNTING_FOR_ROOM:
	var LAST HUNTING_FOR_ROOM
	action math ROOMNUMBER add 1 when ^To the .+:

	var ROOM1OCCUPIED FALSE
	var ROOM2OCCUPIED FALSE
	var ROOM3OCCUPIED FALSE
	var ROOM4OCCUPIED FALSE
	var ROOM5OCCUPIED FALSE
	var ROOM6OCCUPIED FALSE
	var ROOM7OCCUPIED FALSE
	var ROOM8OCCUPIED FALSE
	action var ROOM%ROOMNUMBEROCCUPIED TRUE when ^  \d+\)   \w+$|^  \d+\)   A hidden \w+$
	action var ROOM%ROOMNUMBEROCCUPIED TRUE when ^  --\)   Signs of something hidden from sight\.

	var ROOM1MOBS 0
	var ROOM2MOBS 0
	var ROOM3MOBS 0
	var ROOM4MOBS 0
	var ROOM5MOBS 0
	var ROOM6MOBS 0
	var ROOM7MOBS 0
	var ROOM8MOBS 0

	action math ROOM%ROOMNUMBERMOBS add 1 when ^  \d+\)   (a|an)
	action var ROOM%ROOMNUMBERTARGET $1 when ^  (\d+)\)

	put stop stalk
	waitfor stalking
	put hunt
	waitforre ^Roundtime:|You find yourself unable to

	action remove ^To the .+:
	action remove ^  \d+\)   \w+$|^  \d+\)   A hidden \w+$
	action remove ^  --\)   Signs of something hidden from sight\.
	action remove ^  \d+\)   (a|an)
	action remove ^  (\d+)\)

	if "%ROOM1OCCUPIED" = "TRUE" then var ROOM1MOBS 0
	if "%ROOM2OCCUPIED" = "TRUE" then var ROOM2MOBS 0
	if "%ROOM3OCCUPIED" = "TRUE" then var ROOM3MOBS 0
	if "%ROOM4OCCUPIED" = "TRUE" then var ROOM4MOBS 0
	if "%ROOM5OCCUPIED" = "TRUE" then var ROOM5MOBS 0
	if "%ROOM6OCCUPIED" = "TRUE" then var ROOM6MOBS 0
	if "%ROOM7OCCUPIED" = "TRUE" then var ROOM7MOBS 0
	if "%ROOM8OCCUPIED" = "TRUE" then var ROOM8MOBS 0

	var BESTMOBCOUNT 0
	var HUNTNUMBER 0
	if %ROOM1MOBS > %BESTMOBCOUNT then
	{
		var BESTMOBCOUNT %ROOM1MOBS
		var HUNTNUMBER %ROOM1TARGET
	}
	if %ROOM2MOBS > %BESTMOBCOUNT then
	{
		var BESTMOBCOUNT %ROOM2MOBS
		var HUNTNUMBER %ROOM2TARGET
	}
	if %ROOM3MOBS > %BESTMOBCOUNT then
	{
		var BESTMOBCOUNT %ROOM3MOBS
		var HUNTNUMBER %ROOM3TARGET
	}
	if %ROOM4MOBS > %BESTMOBCOUNT then
	{
		var BESTMOBCOUNT %ROOM4MOBS
		var HUNTNUMBER %ROOM4TARGET
	}
	if %ROOM5MOBS > %BESTMOBCOUNT then
	{
		var BESTMOBCOUNT %ROOM5MOBS
		var HUNTNUMBER %ROOM5TARGET
	}
	if %ROOM6MOBS > %BESTMOBCOUNT then
	{
		var BESTMOBCOUNT %ROOM6MOBS
		var HUNTNUMBER %ROOM6TARGET
	}
	if %ROOM7MOBS > %BESTMOBCOUNT then
	{
		var BESTMOBCOUNT %ROOM7MOBS
		var HUNTNUMBER %ROOM7TARGET
	}
	if %ROOM8MOBS > %BESTMOBCOUNT then
	{
		var BESTMOBCOUNT %ROOM8MOBS
		var HUNTNUMBER %ROOM8TARGET
	}
	pause

	if %HUNTNUMBER = 0 then goto RANDOM_MOVE

	if ((toupper("$GH_BUN") = "ON")) && contains("$roomobjs", "lumpy bundle")) then
	{
			match HUNT_MOVE You pick up
		put get bun
		matchwait 16
	}		
	HUNT_MOVE:
		var LAST HUNT_MOVE
			matchre RANDOM_MOVE You don't have that target currently available|Your prey seems to have completely vanished|You were unable to locate|You find yourself unable|You'll need to be in the area
			matchre MOVE_ROOMS Also here: (.*)			
			matchre CHECK_OCCUPIED ^You'll need to disengage first|^While in combat?|^Obvious exits|^Obvious paths
		put hunt %HUNTNUMBER
		matchwait 60

	RANDOM_MOVE:
		var exits 0
		if $north = 1 then math exits add 1
		if $northeast = 1 then math exits add 1
		if $east = 1 then math exits add 1
		if $southeast = 1 then math exits add 1
		if $south = 1 then math exits add 1
		if $southwest = 1 then math exits add 1
		if $west = 1 then math exits add 1
		if $northwest = 1 then math exits add 1
		if $up = 1 then math exits add 1
		if $down = 1 then math exits add 1
		if (%exits = 0) then goto CHECK_OCCUPIED

		random 1 10
		var move_cycles 0
		goto MOVE_%r

	MOVE_1:
		if ($north = 1) then
		{
			if ((%exits > 1) && ("%lastdirection" != "south")) then
			{
				var direction north
				goto GOOD_DIRECTION
			} elseif (%exits = 1) then
			{
				var direction north
				goto GOOD_DIRECTION
			}			
		}
	MOVE_2:
		if ($northeast = 1) then
		{
			if ((%exits > 1) && ("%lastdirection" != "southwest")) then
			{
				var direction northeast
				goto GOOD_DIRECTION
			} elseif (%exits = 1) then
			{
				var direction northeast
				goto GOOD_DIRECTION
			}
		}
	MOVE_3:
		if ($east = 1) then
		{
			if ((%exits > 1) && ("%lastdirection" != "west")) then
			{
				var direction east
				goto GOOD_DIRECTION
			} elseif (%exits = 1) then
			{
				var direction east
				goto GOOD_DIRECTION
			}
		}
	MOVE_4:
		if ($southeast = 1) then
		{
			if ((%exits > 1) and (("%lastdirection" != "northwest")) then
			{
				var direction southeast
				goto GOOD_DIRECTION
			} elseif (%exits = 1) then
			{
				var direction southeast
				goto GOOD_DIRECTION
			}
		}
	MOVE_5:
		if ($south = 1) then
		{
			if ((%exits > 1) && ("%lastdirection" != "north")) then
			{
				var direction south
				goto GOOD_DIRECTION
			} elseif (%exits = 1) then
			{
				var direction south
				goto GOOD_DIRECTION
			}
		}
	MOVE_6:
		if ($southwest = 1) then
		{
			if ((%exits > 1) && ("%lastdirection" != "northeast")) then
			{
				var direction southwest
				goto GOOD_DIRECTION
			} elseif (%exits = 1) then
			{
				var direction southwest
				goto GOOD_DIRECTION
			}
		}
	MOVE_7:
		if ($west = 1) then
		{
			if ((%exits > 1) && ("%lastdirection" != "east")) then
			{
				var direction west
				goto GOOD_DIRECTION
			} elseif (%exits = 1) then
			{
				var direction west
				goto GOOD_DIRECTION
			}
		}
	MOVE_8:
		if ($northwest = 1) then
		{
			if ((%exits > 1) && ("%lastdirection" != "southeast")) then
			{
				var direction northwest
				goto GOOD_DIRECTION
			} elseif (%exits = 1) then
			{
				var direction northwest
				goto GOOD_DIRECTION
			}
		}
	MOVE_9:
		if ($up = 1) then
		{
			if ((%exits > 1) && ("%lastdirection" != "down")) then
			{
				var direction up
				goto GOOD_DIRECTION
			} elseif (%exits = 1) then
			{
				var direction up
				goto GOOD_DIRECTION
			}
		}
	MOVE_10:
		if ($down = 1) then
		{
			if ((%exits > 1) && ("%lastdirection" != "up")) then
			{
				var direction down
				goto GOOD_DIRECTION
			} elseif (%exits = 1) then
			{
				var direction down
				goto GOOD_DIRECTION
			}
		}
	if (%move_cycles <= 5) then
	{
		math move_cycles add 1
		goto MOVE_1
	} else goto ERROR
GOOD_DIRECTION:
	if ((toupper("$GH_BUN") = "ON")) && contains("$roomobjs", "lumpy bundle")) then
	{
			match MOVING You pick up
		put get bun
		matchwait 40
	}		
	MOVING:
		var LAST MOVING
			matchre MOVE_ROOMS Also here: (.*)|^You can't go there
			matchre CHECK_OCCUPIED ^You are engaged|^Obvious exits|^Obvious paths|^While in combat
		put %direction
		matchwait 40
		goto CHECK_OCCUPIED
FOUND_ROOM:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** FOUND_ROOM: ***
		echo
	}
	if (toupper("$GH_PP") = "ON") then var PP_TIME %t
	if ((toupper("$GH_BUN") = "ON")) && (("$righthandnoun" = "bundle") || ("$lefthandnoun" = "bundle"))) then
	{
		put drop bun
		waitfor You drop
	}
	var lastdirection %direction
	goto FACE
CHECK_OCCUPIED:
	put search
	waitforre ^Roundtime:
	pause 1
	if ("$roomplayers" = "") then goto FOUND_ROOM
	else
	{
		put ret
		put ret
		goto %LAST
	}

######################################
###                                ###
### This section handles what to   ###
### do while waiting for more      ###
### creatures                      ###
###                                ###
######################################
COUNT_FACE:
	var LAST COUNT_FACE
		match COUNT_ASSESS_ADV nothing else to face
		match APPR_$GH_APPR You turn to
	put face next
	matchwait 40

COUNT_ASSESS_ADV:
	if (($hidden = 1) && ("%guild" = "Paladin")) then put unhid
		match COUNT_FACE You stop advancing|You have lost sight
		match NO_MONSTERS advance towards?
		matchre APPR_$GH_APPR begin|to melee range|\[You're|already at melee/
	put advance
	matchwait 40

COUNT_ADV:
	var LAST_COUNT_ADV
	if (($hidden = 1) && ("%guild" = "Paladin")) then put unhid
		matchre COUNT_FACE You stop advancing|You have lost sight
		match NO_MONSTER advance towards?
		matchre ADVANCING You begin|already advancing
		match %LAST already at melee
	put advance
	matchwait 40
	goto ERROR	
COUNT_ADVANCING:
		waitforre to melee range|\[You're
		goto %LAST

COUNT_FATIGUE_PAUSE:
	pause
COUNT_FATIGUE:
	var LAST COUNT_FATIGUE
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** COUNT_FATIGUE: ***
		echo
	}
		matchre PAUSE \[You're|You stop advancing|Roundtime
		match COUNT_FATIGUE_CHECK You cannot back away from a chance to continue your slaughter!
		matchre COUNT_FATIGUE_CHECK You retreat from combat.|You sneak back|already as far
	put ret
	put ret
	matchwait 40
	goto COUNT_FATIGUE

COUNT_FATIGUE_CHECK:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** COUNT_FATIGUE_CHECK: ***
		echo
	}
	if ($stamina < 80) then
	{
		goto COUNT_FATIGUE_WAIT
	} else
	{
		goto COUNT_START
	}

COUNT_FATIGUE_WAIT:
	echo
	echo COUNT_FATIGUE_WAIT:
	echo
		matchre COUNT_FATIGUE melee|pole|\[You're
	matchwait

#######################################
###                                 ###
### This section is for waiting for ###
### new creatures to show up.       ###
### Brawls until more creatures.    ###
###                                 ###
#######################################
COUNT_WAIT_1:
	var LAST COUNT_WAIT_1
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** COUNT_WAIT_1: parry ***
		echo
	}
		matchre COUNT_WAIT_2 You are already in a position|But you are already dodging|You move into a position to|Roundtime|pointlessly hack
		matchre COUNT_FATIGUE You're beat,|You're exhausted|You're bone-tired|worn-out
		matchre COUNT_ADV aren't close enough
		matchre DEAD_MONSTER balanced\]|balance\]|already dead|very dead
		matchre COUNT_FACE nothing else
	put parry
	matchwait 80
	goto ATTACK_ERROR

COUNT_WAIT_2:
goto COUNT_WAIT_3
	var LAST COUNT_WAIT_2
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** COUNT_WAIT_2: shove ***
		echo
	}
		matchre COUNT_WAIT_3 You are already in a position|But you are already dodging|You move into a position to|Roundtime|pointlessly hack
		matchre COUNT_FATIGUE You're beat,|You're exhausted|You're bone-tired|worn-out
		matchre COUNT_ADV aren't close enough
		matchre DEAD_MONSTER balanced\]|balance\]|already dead|very dead
		matchre COUNT_FACE nothing else
	put shove
	matchwait 80
	goto ATTACK_ERROR

COUNT_WAIT_3:
	var LAST COUNT_WAIT_3
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** COUNT_WAIT_3: circle ***
		echo
	}
		matchre COUNT_WAIT_4 You are already in a position|But you are already dodging|You move into a position to|Roundtime|pointlessly hack
		matchre COUNT_FATIGUE You're beat,|You're exhausted|You're bone-tired|worn-out
		matchre COUNT_ADV aren't close enough
		matchre DEAD_MONSTER balanced\]|balance\]|already dead|very dead
		matchre COUNT_FACE nothing else
	put circle
	matchwait 80
	goto ATTACK_ERROR

COUNT_WAIT_4:
	var LAST COUNT_WAIT_4
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** COUNT_WAIT_4: weave ***
		echo
	}
		matchre COUNT_WAIT_5 You are already in a position|But you are already dodging|You move into a position to|Roundtime|pointlessly hack
		matchre COUNT_FATIGUE You're beat,|You're exhausted|You're bone-tired|worn-out
		matchre COUNT_ADV aren't close enough
		matchre DEAD_MONSTER balanced\]|balance\]|already dead|very dead
		matchre COUNT_FACE nothing else
	put weave
	matchwait 80
	goto ATTACK_ERROR

COUNT_WAIT_5:
	var LAST COUNT_WAIT_5
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** COUNT_WAIT_5: bob ***
		echo
	}
		matchre COUNT_START You are already in a position|But you are already dodging|You move into a position to|Roundtime|pointlessly hack
		matchre COUNT_FATIGUE You're beat,|You're exhausted|You're bone-tired|worn-out
		matchre COUNT_ADV aren't close enough
		matchre DEAD_MONSTER balanced\]|balance\]|already dead|very dead
		matchre COUNT_FACE nothing else
	put bob
	matchwait 80
	goto ATTACK_ERROR

######################################
###                                ###
### This section is for the 5 move ###
### weapon attack COMBO            ###
###                                ###
######################################
5_COMBO:
500:
	if ("%lastmaneuver" = "none") then
	{
		put stance maneuver
		waitfor Last Combat Maneuver
	}
	var LAST 5_COMBO
	gosub clear
	counter set 500
	save 500
	if ("%lastmaneuver" = "%COMBO5") then gosub COMBAT_COMMAND %COMBO1
	if ("%lastmaneuver" = "%COMBO1") then gosub COMBAT_COMMAND %COMBO2 %HAND $GH_TARGET
	if ("%lastmaneuver" = "%COMBO2") then gosub COMBAT_COMMAND %COMBO3 %HAND $GH_TARGET
	if ("%lastmaneuver" = "%COMBO3") then gosub COMBAT_COMMAND %COMBO4 %HAND $GH_TARGET
	if ("%lastmaneuver" = "%COMBO4") then gosub COMBAT_COMMAND %COMBO5 %HAND $GH_TARGET
	else gosub COMBAT_COMMAND %COMBO1
	if (toupper("$GH_TIMER") = "ON") then goto TIMER_ON
	if (toupper("$GH_TRAIN") = "ON") then goto EXPCHECK_ON
	else goto 500

######################################
###                                ###
### This section is for the 6 move ###
### weapon attack COMBO            ###
###                                ###
######################################
6_COMBO:
600:
	if ("%lastmaneuver" = "none") then
	{
		put stance maneuver
		waitfor Last Combat Maneuver
	}
	var LAST 6_COMBO
	gosub clear
	counter set 600
	save 600
	if ("%lastmaneuver" = "%COMBO6") then gosub COMBAT_COMMAND %COMBO1
	if ("%lastmaneuver" = "%COMBO1") then gosub COMBAT_COMMAND %COMBO2 %HAND $GH_TARGET
	if ("%lastmaneuver" = "%COMBO2") then gosub COMBAT_COMMAND %COMBO3 %HAND $GH_TARGET
	if ("%lastmaneuver" = "%COMBO3") then gosub COMBAT_COMMAND %COMBO4 %HAND $GH_TARGET
	if ("%lastmaneuver" = "%COMBO4") then gosub COMBAT_COMMAND %COMBO5 %HAND $GH_TARGET
	if ("%lastmaneuver" = "%COMBO5") then gosub COMBAT_COMMAND %COMBO6 %HAND $GH_TARGET
	else gosub COMBAT_COMMAND %COMBO1
	if (toupper("$GH_TIMER") = "ON") then goto TIMER_ON
	if (toupper("$GH_TRAIN") = "ON") then goto EXPCHECK_ON
	else goto 600

######################################
###                                ###
### This section is for the 7 move ###
### weapon attack COMBO            ###
###                                ###
######################################
7_COMBO:
700:
	if ("%lastmaneuver" = "none") then
	{
		put stance maneuver
		waitfor Last Combat Maneuver
	}
	var LAST 7_COMBO
	gosub clear
	counter set 700
	save 700
	if ("%lastmaneuver" = "%COMBO7") then gosub COMBAT_COMMAND %COMBO1
	if ("%lastmaneuver" = "%COMBO1") then gosub COMBAT_COMMAND %COMBO2 %HAND $GH_TARGET
	if ("%lastmaneuver" = "%COMBO2") then gosub COMBAT_COMMAND %COMBO3 %HAND $GH_TARGET
	if ("%lastmaneuver" = "%COMBO3") then gosub COMBAT_COMMAND %COMBO4 %HAND $GH_TARGET
	if ("%lastmaneuver" = "%COMBO4") then gosub COMBAT_COMMAND %COMBO5 %HAND $GH_TARGET
	if ("%lastmaneuver" = "%COMBO5") then gosub COMBAT_COMMAND %COMBO6 %HAND $GH_TARGET
	if ("%lastmaneuver" = "%COMBO6") then gosub COMBAT_COMMAND %COMBO7 %HAND $GH_TARGET
	else gosub COMBAT_COMMAND %COMBO1
	if (toupper("$GH_TIMER") = "ON") then goto TIMER_ON
	if (toupper("$GH_TRAIN") = "ON") then goto EXPCHECK_ON
	else goto 700

######################################
###                                ###
### This section is for the 8 move ###
### weapon attack COMBO            ###
###                                ###
######################################
8_COMBO:
800:
	if ("%lastmaneuver" = "none") then
	{
		put stance maneuver
		waitfor Last Combat Maneuver
	}
	var LAST 8_COMBO
	gosub clear
	counter set 800
	save 800
	if ("%lastmaneuver" = "%COMBO8") then gosub COMBAT_COMMAND %COMBO1 %HAND $GH_TARGET
	if ("%lastmaneuver" = "%COMBO1") then gosub COMBAT_COMMAND %COMBO2 %HAND $GH_TARGET
	if ("%lastmaneuver" = "%COMBO2") then gosub COMBAT_COMMAND %COMBO3 %HAND $GH_TARGET
	if ("%lastmaneuver" = "%COMBO3") then gosub COMBAT_COMMAND %COMBO4 %HAND $GH_TARGET
	if ("%lastmaneuver" = "%COMBO4") then gosub COMBAT_COMMAND %COMBO5 %HAND $GH_TARGET
	if ("%lastmaneuver" = "%COMBO5") then gosub COMBAT_COMMAND %COMBO6 %HAND $GH_TARGET
	if ("%lastmaneuver" = "%COMBO6") then gosub COMBAT_COMMAND %COMBO7 %HAND $GH_TARGET
	if ("%lastmaneuver" = "%COMBO7") then gosub COMBAT_COMMAND %COMBO8 %HAND $GH_TARGET
	else gosub COMBAT_COMMAND %COMBO1
	if (toupper("$GH_TIMER") = "ON") then goto TIMER_ON
	if (toupper("$GH_TRAIN") = "ON") then goto EXPCHECK_ON
	else goto 800

######################################
###                                ###
### This section is for the ranged ###
### weapon attack COMBO            ###
###                                ###
######################################
RANGED:
1000:
	var LAST RANGED
	save 1000
	action var FULL_AIM YES when You think you have your best shot possible
	action var FULL_AIM NO when stop concentrating on aiming
	if ((toupper("$GH_RETREAT") = "ON") && ("%RETREATING" = "OFF") && (("%FIRE_TYPE" != "SNIPE") || ("%FIRE_TYPE" != "POACH"))) then gosub RETREAT_TRIGGERS
	if ("%lastmaneuver" = "none") then gosub COMBAT_COMMAND dodge
RANGED_COMBAT:
1010:
	var LAST RANGED_COMBAT
	gosub clear
	counter set 1010
	save 1010
	if (("%lastmaneuver" = "dodge") || ("%lastmaneuver" = "FIRE") || ("%lastmaneuver" = "POACH") || ("%lastmaneuver" = "SNIPE")) then 
	{
		gosub LOAD
		gosub AIM
		#if (toupper("$GH_SNAP") = "ON")) then gosub stun
		if (("%FIRE_TYPE" = "POACH") || ("%FIRE_TYPE" = "SNIPE")) then gosub HIDE
		if (toupper("$GH_SNAP") = "OFF")) then gosub AIMING
		elseif ($GH_SNAP_PAUSE > 0) then pause $GH_SNAP_PAUSE
		var FULL_AIM NO
			matchre RANGE_FIRE2 You can not poach|are not hidden
			match RETURN isn't loaded
			matchre RETURN ^I could not find what you were
		gosub COMBAT_COMMAND %FIRE_TYPE $GH_TARGET
	} else gosub COMBAT_COMMAND dodge
	goto 1010
	
LOAD:
		matchre CHECK_AMMO ^You don't have the proper ammunition readily available for your
		matchre RANGE_GET ^You must|your hand jams|^You can not load
		matchre RANGE_REMOVE_CHECK (\w+) makes the task more difficult|while wearing a (.+)|while wearing an (.+)
		matchre RETURN Roundtime|is already
	put load
	matchwait 80
	goto RANGED_ERROR

AIM:
	var AIM_TIMEOUT %t
	math AIM_TIMEOUT add 30
		match RE_LOAD loaded
		matchre RETURN best shot possible now|already targetting|begin to target|You shift your
		matchre FACE ^There is nothing
	put aim
	matchwait 80
	goto RANGED_ERROR
	
RE_LOAD:
	gosub clear
	goto RANGED_COMBAT

AIMING:
	if ("%FULL_AIM" = "YES") then return
	else 
	{
		if (%t > %AIM_TIMEOUT) then goto RANGED_COMBAT
		else
		{
			pause 3
			goto AIMING
		}
	}

RANGE_FIRE2:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** Can't poach that, just using FIRE ***
		echo
	}
	var LAST RANGE_FIRE2
	gosub clear
		matchre RETURN ^I could not find what you were
		match RETURN isn't loaded
	gosub COMBAT_COMMAND FIRE $GH_TARGET
	goto 1010

RANGE_GET:
	var LAST RANGE_GET
	gosub clear
	if (matchre("$roomobjs", "%AMMO\b")) then
	{
			match CHECK_AMMO ^What were you
			match DEAD_MONSTER ^You pull
			matchre %c ^Stow what|^You must unload|^You get some
			matchre RANGE_GET ^You pick up|^You put|^You stow|^You get
		if "%AMMO" = "basilisk head arrow" then put stow basilisk arrow in my %QUIVER
		else
		put stow %AMMO in my %QUIVER
		matchwait 80
		goto RANGED_ERROR
	} else goto %c

RANGE_REMOVE_CHECK:
	if matchre ("$0", "shield|buckler|pavise|heater|kwarf|sipar|lid|targe\b") then goto RANGE_REMOVE
	else goto RANGED_ERROR
RANGE_REMOVE:
	var REM_SHIELD $0
	counter set %s
RANGE_REMOVING:
	var LAST RANGE_REMOVING
		matchre RANGE_STOW ^You loosen the straps securing|^You aren't wearing that
		match RANGED_ERROR ^Remove what?
	put remove my %REM_SHIELD
	matchwait 80
	goto RANGED_ERROR

RANGE_STOW:
	var LAST RANGE_STOW
		match RANGED_ERROR ^Stow What?
		match RANGE_ADJUST too 
		match RETURN You put
	put stow my %REM_SHIELD
	matchwait 16
RANGE_ADJUST:
		matchre RANGED_ERROR through the straps|You can't wear any more items like that
		match RETURN You sling
	put adj my %REM_SHIELD
	put wear my %REM_SHIELD
	matchwait  30
	goto RANGED_ERROR

CHECK_AMMO:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** No ammo on you, checking the ground ***
		echo
	}
	if contains("$roomobjs", "%AMMO") then
	{
		gosub RANGED_CLEAN
		goto 1000
	}
NO_AMMO:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** No more ammo, stopping script ***
		echo
	}
	var LAST NO_AMMO
	if ("%REM_SHIELD" != "NONE") then
	{
		gosub EQUIP_SHIELD %REM_SHIELD
	}
	gosub RANGE_SHEATHE
	goto DONE

######################################
###                                ###
### This section is for the ranged ###
### weapon attack COMBO            ###
###                                ###
######################################
THROWING:
1200:
	save 1200
	var LAST THROWING
	if ((toupper("$GH_RETREAT") = "ON") && ("%RETREATING" = "OFF")) then gosub RETREAT_TRIGGERS
	if ("%lastmaneuver" = "none") then gosub COMBAT_COMMAND dodge
THROW_WEAPON:
1210:
	var LAST THROW_WEAPON
	gosub clear
	counter set 1210
	save 1210
	gosub COMBAT_COMMAND throw %HAND $GH_TARGET
	if ((("%HAND" = "") && ("$righthand" = "Empty")) || (("%HAND" = "left") && ("$lefthand" = "Empty"))) then gosub GET_THROWN
	if (("%HAND" = "left") && "$righthand" = "%CURR_WEAPON")) then gosub SWAP_LEFT $righthandnoun
	if (toupper("$GH_TIMER") = "ON") then goto TIMER_ON
	if (toupper("$GH_TRAIN") = "ON") then goto EXPCHECK_ON
	goto 1210

GET_THROWN:
		match GET_THROWN As you reach for a large frozen club
		match WEAPON_STUCK What were you
		matchre RETURN already|You need a free hand to pick that up|You get|You pick up|With a flick|You pull|^A (.+) suddenly leaps toward you|^A (.+) and flies toward you
	put get %CURR_WEAPON
	matchwait 85
	goto THROWN_ERROR

WEAPON_STUCK:
1220:
	var LAST WEAPON_STUCK
	if ("%RETREATING" = "ON") then gosub RETREAT_UNTRIGGERS
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** Getting weapon back ***
		echo
	}
	gosub clear
	put adv
	waitforre to melee range|already at melee
	if (("%lastmaneuver" = "throw") || ("%lastmaneuver" = "jab")) then 
	{
			match GET_WEAPON comes free and falls to the ground.
		gosub COMBAT_COMMAND dodge
	}
	if ("%lastmaneuver" = "dodge") then
	{	
			match GET_WEAPON comes free and falls to the ground.
		gosub COMBAT_COMMAND gouge
	}
	if ("%lastmaneuver" = "gouge") then
	{	
			match GET_WEAPON comes free and falls to the ground.
		gosub COMBAT_COMMAND claw
	}
	if ("%lastmaneuver" = "claw") then
	{	
			match GET_WEAPON comes free and falls to the ground.
		gosub COMBAT_COMMAND elbow
	}
	if ("%lastmaneuver" = "elbow") then
	{	
			match GET_WEAPON comes free and falls to the ground.
		gosub COMBAT_COMMAND jab
	} else gosub COMBAT_COMMAND dodge
	goto 1220

GET_WEAPON:
	if ((toupper("$GH_RETREAT") = "ON") && ("%RETREATING" = "OFF")) then gosub RETREAT_TRIGGERS
	gosub clear
		matchre GET_WEAPON comes free and falls to the ground|As you reach for a large frozen club
		matchre 1210 already|You get|You pull|You pick|You need a free hand to|What were you
	put get %CURR_WEAPON
	matchwait 85
	goto THROWN_ERROR

########################################
###                                  ###
### This section is for the backstab ###
### weapon attack COMBO              ###
###                                  ###
########################################
STABBITY:
1300:
	var LAST STABBITY
	gosub clear
	counter set 1300
	save 1300
	if ("%lastmaneuver" != "parry") then gosub COMBAT_COMMAND parry
	if ($hidden != 1) then gosub HIDE
	if ("%lastmaneuver" = "parry") then
	{
			matchre FACE Backstab what\?|Face what\?
			matchre BS_ATTACK You can't backstab that\.|political|You'll need something a little lighter
			matchre BAD_WEAPON entirely unsuitable|Backstabbing is much more effective when you use a melee weapon
		gosub COMBAT_COMMAND backstab %HAND $GH_TARGET
	}
	if (toupper("$GH_TIMER") = "ON") then goto TIMER_ON
	if (toupper("$GH_TRAIN") = "ON") then goto EXPCHECK_ON
	else goto 1300
BS_ATTACK:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** Can't backstab, ambushing instead ***
		echo
	}
	gosub clear
	goto 500

BAD_WEAPON:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** BAD_WEAPON: ***
		echo This weapon is not suitable for this type of attack, switching to regular combat
		echo
	}
	counter set 0
	goto WEAPON_CHECK

######################################
###                                ###
###      Combat Manuever           ###
###                                ###
######################################
COMBAT_COMMAND:
	if (("$GH_FEINT" = "ON") && (("$0" != "feint") && ("$0" != "parry") && ("$0" != "dodge"))) then var COMMAND feint $0
	else var COMMAND $0
	var lastmaneuver $1
	if ("%SEARCHED" = "NO") then
	{
		if matchre ("$roomplayers", "Also here: (\S+)") then goto NOT_CHECKING
		if matchre ("$roomobjs", "((which|that) appears dead|\(dead\))") then goto DEAD_MONSTER
	} else var SEARCHED NO
	NOT_CHECKING:
	if ((toupper("$GH_AMBUSH") = "ON") && ($hidden != 1)) then
	{
		if ("%BACKSTAB" = "ON") then gosub HIDE
		elseif (($Hiding.LearningRate < 30) && ($Stalking.LearningRate < 30)) then gosub HIDE
	}
	if ((toupper("$GH_HUNT") = "ON") && (%t >= %HUNT_TIME) && ($Perception.LearningRate < 33) && ($Stalking.LearningRate < 33)) then
	{
		put hunt
		var HUNT_TIME %t
		math HUNT_TIME add 75
		waitforre Roundtime|You find yourself unable
	}
	if ((toupper("$GH_PP") = "ON") && (%t >= %PP_TIME) && ($Power_Perceive.LearningRate < 33)) then
	{
		put perc
		var PP_TIME %t
		math PP_TIME add 360
		waitforre Roundtime
	}
	if (($hidden = 1) && ("%guild" = "Paladin")) then 
	{
		send unhid
		pause 1
	}
	if toupper("$GH_TEND") = "ON" && $bleeding = 1 then
	{
	action (geniehunter) off
	gosub tend.start
	action (geniehunter) on
	}
	if toupper("$GH_ARMOR") = "ON" then
	{
		#if $GH_ARMOR_COUNT >= $GH_ARMOR_TOTAL then put #var GH_ARMOR OFF 
		if "$GH_ARMOR.INCLUDE" = "1" and $%%swap.armor > $swap.learningrate then 
		{
		action (geniehunter) off
		gosub gh_armor.start
		action (geniehunter) on
		}
		if "$GH_ARMOR.INCLUDE" = "0" then 
		{
		action (geniehunter) off
		gosub gh_armor.start
		action (geniehunter) on
		}

	}	
	if toupper("$GH_BUFF") = "ON" and $mana > 98 then 
	{
	action (geniehunter) off
	var casting 1
	gosub gh_buff.start
	var casting 0
	action (geniehunter) on
	if $standing = 0 then put stand
	}
	if ((toupper("$GH_SLOW") = "ON") && (("%lastmaneuver" != "dodge") && ("%lastmaneuver" != "parry")) then pause $GH_SLOW_PAUSE

ATTACK:
		matchre FLYING_MONSTER flying far too high to hit with
		matchre FATIGUE You're beat|You're exhausted|You're bone-tired|worn-out
		matchre ADVANCE help if you were closer|aren't close enough
		matchre DEAD_MONSTER balanced\]|balance\]|already dead|very dead|pointlessly hack
		matchre FACE nothing else|^Face what\?
		matchre RETURN You are already in a position|But you are already dodging|You move into a position to|Roundtime|must be hidden|What were you|What are you
	put %COMMAND
	matchwait 5
	return
	goto ATTACK_ERROR

FLYING_MONSTER:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo ***  Monster is flying, trying attack again ***
		echo
	}
	put #beep
	pause 3
	goto ATTACK
	
HIDE:
	if (("%guild" = "Thief") && (%level >= 50)) then goto STALK1
		match HIDE fail
		matchre HIDE1_RETREAT You are too close|notices|reveals
		matchre STALK1 You melt|You blend|Eh\?
	put hide
	matchwait 85
	goto STEALTH_ERROR
	
HIDE1_RETREAT:
	put ret
	goto HIDE
	
STALK1:
		matchre CIRCLE_CHECK reveals|try being out of sight|discovers you|trying to stalk
		match STALK1 You think|You fail
		match FACE Stalk what?
		matchre RETURN You move into position|You are already stalking|You're already stalking
	put stalk
	matchwait 85
	goto STEALTH_ERROR

CIRCLE_CHECK:
	if (("%guild" = "Thief") && (%level >= 50)) then var level 1
	goto HIDE

######################################
###                                ###
### This section is for Magic      ###
###                                ###
######################################
2000:
2500:
2600:
2700:
2800:
3000:
3010:
3200:
if ((toupper("$GH_RETREAT") = "ON") && ("%RETREATING" = "OFF")) then gosub RETREAT_TRIGGERS
action var FULL_PREP YES when The formation of the target pattern around
save %c

MAGIC_PREP:
	var LAST MAGIC_PREP
	echo
	echo MAGIC_PREP:
	echo
	if ("%SEARCHED" = "NO") then
	{
		if matchre ("$roomobjs", "((which|that) appears dead|\(dead\))") then goto DEAD_MONSTER
	} else var SEARCHED NO
	put #var GH_HARN_FLAG NO
	if ("%MAGIC_TYPE" = "TM") then match MAGIC_TARGET You trace an arcane sigil in the air, shaping the pattern 
		matchre MAGIC_TARGET fully prepared|already preparing
		match MAGIC_COMBAT have to strain
	put prep $GH_SPELL $GH_MANA
	matchwait 85
	goto MAGIC_ERROR

MAGIC_TARGET:
	var LAST MAGIC_TARGET
	echo
	echo MAGIC_TARGET:
	echo
		matchre MAGIC_PREP You don't have a spell prepared|You must be preparing a spell
		match MAGIC_FACE_TM not engaged
		match MAGIC_TARGET_WAIT1 You begin to weave mana lines into
		matchre MAGIC_TARGET_WAIT2 don't need to target|Your target pattern is already formed
		matchre MAGIC_TARGET_FAIL patterns dissipate|pattern dissipates 
	put target $GH_TARGET
	matchwait 85
	goto MAGIC_ERROR

MAGIC_TARGET_WAIT1:
	if (($GH_HARN != 0) && (toupper("$GH_HARN_FLAG") = "NO")) then gosub MAGIC_HARNESS
	if ("$GH_SNAP" = "ON") then	
	{
		if ($GH_SNAP_PAUSE > 0) then pause $GH_SNAP_PAUSE
		goto MAGIC_CAST
	}
	if ("%FULL_PREP" = "YES") then goto MAGIC_CAST
		match MAGIC_CAST The formation of the target pattern around
		matchre TARGET_FAIL patterns dissipate|pattern dissipates 
		matchre MAGIC_DEATH You gesture|You reach
	matchwait 85
	goto MAGIC_ERROR

MAGIC_TARGET_WAIT2:
	if ($GH_HARN != 0) then gosub MAGIC_HARNESS
	if ("$GH_SNAP" = "ON") then 
	{
		if ($GH_SNAP_PAUSE > 0) then pause $GH_SNAP_PAUSE
		goto MAGIC_CAST
	}
	goto MAGIC_CAST

MAGIC_TARGET_FAIL:
	if ("%MAGIC" = "ON") then goto MAGIC_COMBAT
	put release
	goto PREP

MAGIC_HARNESS:
	echo
	echo MAGIC_HARNESS:
	echo
	put #var GH_HARN_FLAG YES
		matchre MAGIC_HARNESS_DONE You tap into the mana from|You strain, but cannot harness
	put harness $GH_HARN
	matchwait 85
	goto MAGIC_ERROR

MAGIC_HARNESS_DONE:
	pause 0.5
	return

MAGIC_FACE_TM:
	var LAST MAGIC_FACE_TM
	echo
	echo MAGIC_FACE_TM:
	echo
		match MAGIC_TARGET You turn
		matchre MAGIC_TM_ADV There is nothing|Face what?
	put face next
	matchwait 85
	goto MAGIC_ERROR

MAGIC_TM_ADV:
	var LAST MAGIC_TM_ADV
		match MAGIC_FACE_TM You stop advancing
		match MAGIC_FACE_TM2 advance towards?
		match MAGIC_FACE_TM You have lost sight
		matchre MAGIC_TARGET to melee range|\[You're|already at melee|begin
	put ADV
	matchwait 85
	goto MAGIC_ERROR

MAGIC_FACE_TM2:
	put rel spell
	goto FACE

MAGIC_CAST:
	var LAST MAGIC_CAST
	echo
	echo MAGIC_CAST:
	echo
	var FULL_PREP NO
		matchre MAGIC_DEATH You gesture|You reach|Roundtime
		match MAGIC_DEATH_REL because your target is dead
		match MAGIC_COMBAT You are unable to harness
		match MAGIC_FACE_TM on yourself!
		match MAGIC_PREP You don't
		matchre TARGET_FAIL patterns dissipate|pattern dissipates|Your secondary spell pattern dissipates because
	put cast
	matchwait 85
	goto MAGIC_ERROR

TARGET_FAIL:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo ***  TARGET_FAIL:  ***
		echo Failed to target magically
		echo Re-prepping and trying again
		echo
	}
	put rel
	goto %c

MAGIC_DEATH_REL:
	put rel spell
	wait
	goto DEAD_MONSTER

MAGIC_DEATH:
	if ("%MAGIC" = "ON") then goto MAGIC_COMBAT
	var LAST MAGIC_DEATH
	if matchre ("$roomobjs", "((which|that) appears dead|\(dead\))") then goto DEAD_MONSTER
	else goto EXPCHECK_$GH_TRAIN

MAGIC_COMBAT:
	pause
	put rel spell
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** MAGIC_COMBAT: ***
		echo
	}
	counter subtract 2000
	if ("%RETREATING" = "ON") then gosub RETREAT_UNTRIGGERS
	goto %c

######################################
###                                ###
### End of Magics                  ###
###                                ###
######################################
RANGED_CLEAN:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** RANGED_CLEAN ***
		echo
	}
	if (("%SHIELD" != "NONE" && ("$lefthandnoun" = "%SHIELD")) then	
	{
		gosub UNEQUIP_SHIELD
	}
	if "%AMMO" = "basilisk head arrow" then put stow basilisk arrow in my %QUIVER
	else
	put stow %AMMO in my %QUIVER
	put retreat
	pause
		matchre RANGED_CLEAN_DONE You get some|You get a|You are already holding |You must unload|You stop as you realize
		matchre RANGED_CLEAN You pick up|You pull
	if "%AMMO" = "basilisk head arrow" then put get basilisk arrow
	else
	put get %AMMO
	matchwait 85
	goto CLEANING_ERROR

RANGED_CLEAN_DONE:
	if "%AMMO" = "basilisk head arrow" then put stow basilisk arrow in my %QUIVER
	else
	put stow %AMMO in my %QUIVER
	if (("%SHIELD" != "NONE" && ("$lefthand" = "Empty")) then	
	{
		gosub EQUIP_SHIELD
	}
	return

THROWN_CLEAN:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** THROWN_CLEAN ***
		echo
	}
	put put my %CURR_WEAPON in my %T_SHEATH
	put retreat
	pause
		matchre THROWN_CLEAN_DONE You get some|You get a|You are already holding 
		matchre THROWN_CLEAN You pick up|You pull
	put get %CURR_WEAPON
	matchwait 85
	goto CLEANING_ERROR

THROWN_CLEAN_DONE:
	put put my %CURR_WEAPON in my %T_SHEATH
	return

WEBBED:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** You have been webbed ***
		echo
	}	
	var WEBBED YES
	action remove eval $webbed = 1
	action var WEBBED NO when move freely again|free yourself from the webbing\.
	put #beep
	if ("%WEBBED" = "YES") then 
	{
		waitforre move freely again|free yourself from the webbing\.
	}
	action goto WEBBED when eval $webbed = 1
	goto %LAST

STAND:
	pause 1
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** Knocked down, standing back up ***
		echo
	}
	var GO_BACK %LAST
STANDING:
	var LAST STANDING
		matchre STANDING cannot manage to stand|The weight of all your possessions|still stunned
		matchre %GO_BACK ^You stand|^You are already standing
	put stand
	matchwait 85
	goto ERROR

FATIGUE:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** FATIGUE: ***
		echo
	}
	if (("%THROWN" = "ON") && matchre("$roomobjs", "%CURR_WEAPON")) then
	{
		pause 1
		put get %CURR_WEAPON  
		waitforre You pick up|You get|You are
	}
	var LAST FATIGUE
		matchre FATIGUE \[You're|You stop advancing
		match FATIGUE_CHECK You cannot back away from a chance to continue your slaughter!
		matchre FATIGUE_CHECK You retreat from combat|You sneak back|already as far
	put ret
	put ret
	matchwait 40
	goto FATIGUE_CHECK

FATIGUE_CHECK:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** FATIGUE_CHECK: ***
		echo
	}
	if ($stamina < 90) then
	{
		goto FATIGUE_WAIT
	} else
	{
		goto %c
	}

FATIGUE_WAIT:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** FATIGUE_WAIT: ***
		echo
	}
		matchre FATIGUE You feel fully rested|melee|pole|\[You're
	matchwait
	
######################################
###                                ###
###      Dead monster routines     ###
###                                ###
######################################
DEAD_MONSTER:
	pause 1
	gosub clear
	match clear
	var SEARCHED YES
	var APPRAISED NO
	var LAST DEAD_MONSTER
	if ("%BACKSTAB" = "ON") then 
	{
		counter set 1300
		save 1300
	}
	if ("%RETREATING" = "ON") then gosub RETREAT_UNTRIGGERS
	if ("%THROWN" = "ON") then
	{
		if ((("%HAND" = "") && ("$righthand" = "Empty")) || (("%HAND" = "left") && ("$lefthand" = "Empty"))) then gosub GET_THROWN
	}
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** DEAD_MONSTER: ***
		echo
	}
	var LOCAL $GH_KILLS
	math LOCAL add 1
	put #var GH_KILLS %LOCAL
	if matchre ("$roomobjs", "(%skinnablecritters) ((which|that) appears dead|\(dead\))") then goto SKIN_MONSTER_$GH_SKIN
	if matchre ("$roomobjs", "(%nonskinnablecritters) ((which|that) appears dead|\(dead\))") then goto SEAR_MONSTER
	if matchre ("$roomobjs", "(%invasioncritters) ((which|that) appears dead|\(dead\))") then goto SEAR_MONSTER
	goto NO_MONSTER

######################################
###                                ###
###        Skinning routines       ###
###                                ###
######################################
SKIN_MONSTER_ON:
action remove eval $bleeding = 1
	var Monster $1
	if (toupper("$GH_SKIN_RET") = "ON") && ("%RETREATING" = "OFF")) then gosub RETREAT_TRIGGERS
SKIN_MONSTER:
	var LAST SKIN_MONSTER
	pause 1
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** SKIN_MONSTER: ***
		echo
	}
	if ("%SHIELD" != "NONE") then	
	{
		if ("$lefthand" != "Empty") then 
		{
			gosub UNEQUIP_SHIELD
		}
	}
	GET_KNIFE:
		var LAST GET_KNIFE
		if ("%BELT_WORN" = "OFF") then
		{
			if ("%EMPTY_HANDED" != "ON") then 
			{
				if ("%RANGED" = "ON") then gosub RANGE_SHEATHE %CURR_WEAPON
				else gosub SHEATHE %CURR_WEAPON
			}
			if ("$righthand" != "Empty") then gosub SHEATHE $righthandnoun
			if ("$lefthand" != "Empty") then gosub SHEATHE $lefhthandnoun
			gosub WIELD_WEAPON knife
		}
		var LAST SKINNING
	ARRANGE_CHECK:	
		if (toupper("$GH_ARRANGE") = "ON") then 
		{
			var NUM_ARRANGES 0
			goto ARRANGE_KILL
		}
	SKINNING:
			matchre SKINNING ^You approach
			matchre QUIT You're carrying far too many items already.
			matchre DROPPED_SKINNER ^You'll need to have a bladed instrument
			matchre SKIN_FAIL ^Some days it just doesn't pay to wake up|^A heartbreaking slip at the last moment renders your chances|manage to slice it to dripping tatters|You bumble the attempt|but only succeed in reducing|but end up destroying|You fumble and make an improper cut|Maybe helping little old Halfling widows across a busy Crossing street|You claw|twists and slips in your grip|^There isn't another|^Living creatures often object|Skin what\?|^Somehow managing to do EVERYTHING|^You hide|cannot be skinned
			matchre SKIN_KNIFE_SHEATH into your bundle\.$
			matchre SKIN_CHECK Roundtime
		put skin
		matchwait 85
		goto SKIN_ERROR
SKIN_CHECK:
	if ("$lefthand" != "Empty") then goto SCRAPE_$GH_SCRAPE
SKIN_FAIL:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** SKIN_FAIL ***
		echo Skinning failed
		echo
	}
	goto SKIN_KNIFE_SHEATH
DROPPED_SKINNER:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** Dropped your skinning knife ***
		echo
	}
	pause 1
	put get knife
	goto SKINNING

ARRANGE_KILL:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** ARRANGE_KILL: ***
		echo
	}
ARRANGING:
	math NUM_ARRANGES add 1
	if (%NUM_ARRANGES > $MAX_ARRANGE) then goto SKINNING
	var LAST ARRANGING
	ARRANGEIT:
			matchre SKIN_FAIL corpse is worthless now|Arrange what|^You might want to kill it first|so you can't arrange it either
			match SKINNING has already been arranged as much as you can manage
			if (("%guild" = "Ranger") && ($MAX_ARRANGE = 5)) then match SKINNING Roundtime
			else match ARRANGING Roundtime
		if (("%guild" = "Ranger") && ($MAX_ARRANGE = 5)) then put arrange all
		else put arrange
		matchwait 85
		goto SKIN_ERROR

SCRAPE_ON:
	if ($Mechanical_Lore.LearningRate >= 30) then goto SCRAPE_OFF
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** SCRAPE_ON: ***
		echo
	}
	var LAST SCRAPE_ON
	put loot all
	if matchre ("$lefthand", "skin|pelt|hide") then goto SCRAPING
	goto SCRAPE_OFF
	SCRAPING:
		var SKIN $0
		gosub SHEATHE $righthandnoun
		put loot all
	GET_SCRAPER:
		var LAST GET_SCRAPER
			matchre SCRAPE_CONT You get|You are already hold
			match SCRAPE_OFF What were you referring to?
		put get my scraper
		matchwait 85
		goto SKIN_ERROR
	SCRAPE_CONT:
		var LAST SCRAPE_CONT
			matchre SCRAPE_CONT cleaning some dirt and debris from it|you snag the scraper
			matchre SCRAPE_DONE Your %SKIN has been completely cleaned|going to help anything|looks as clean as you can make it.
		put scrape %SKIN with scraper quick
		matchwait 85
		goto SKIN_ERROR
	SCRAPE_DONE:
		put stow scraper
		waitfor You put

SCRAPE_OFF:
	goto BUNDLE_$GH_BUN

BUNDLE_ON:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** BUNDLE_ON: ***
		echo
	}
	var LOCAL $GH_SKINS
	math LOCAL add 1
	put #var GH_SKINS %LOCAL
	var LAST BUNDLE_ON
		match HAVE_ONE You tap
		match CHECK_ROPE I could not find what you were
	put tap bundle
	matchwait 85
	goto SKIN_ERROR
CHECK_ROPE:
	var LAST CHECK_ROPE
		match GET_ROPE You tap
		match NO_MORE_ROPE I could not find
	##CHECK HERE
	put tap bund rope
	matchwait 85
	goto SKIN_ERROR
NO_MORE_ROPE:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** No more rope for bundling ***
		echo
	}
	put #var GH_BUN OFF
	goto BUNDLE_OFF
GET_ROPE:
	var LAST GET_ROPE
	pause 1
	if ("$righthandnoun" != "Empty") then gosub SHEATHE $righthandnoun
GET_ROPE_CONT:
	##CHECK HERE
	put get my bund rope
	waitfor You get
	put bundle
	pause 1
	if toupper("$GH_TIE") = "ON" then gosub TIE_BUNDLE
	if toupper("$GH_WEAR") = "ON" then gosub WEAR_BUNDLE
	else
	{
	put #var GH_ROAM OFF
	put drop bundle
	waitfor You drop
	}
	goto SKIN_REEQUIP	
TIE_BUNDLE:
matchre TIE_BUNDLE ^Once you've
matchre return ^Using the
put tie my bundle
matchwait
HAVE_ONE:
	if ("$righthandnoun" != "Empty") then gosub SHEATHE $righthandnoun
	if ("$lefthand" = "Empty") then goto SKIN_ERROR
	put get bundle
	if toupper("$GH_WEAR") = "OFF" then put remove bundle
	waitforre You pick|You sling|You remove|But that is
		matchre TOO_HEAVY Time to start a new bundle|You try to stuff your
		matchre HAVE_ONE_CONT You stuff|not going to work|You carefully fit
	put put my $lefthandnoun in my bundle
	matchwait 85
	goto SKIN_ERROR
TOO_HEAVY:
	var LAST TOO_HEAVY
		match CHECK_ROPE You drop
	put #var GH_ROAM OFF
	put drop bundle
	matchwait 85
	goto SKIN_ERROR
HAVE_ONE_CONT:
	if toupper("$GH_WEAR") = "ON" then gosub WEAR_BUNDLE
	else
	{
	put #var GH_ROAM OFF
	put drop bundle
	waitfor You drop
	}
	if ("%EMPTY_HANDED" = "ON") then goto SKIN_REEQUIP_DONE
	else goto SKIN_REEQUIP
WEAR_BUNDLE:
matchre PULL_BUNDLE ^You can't wear
matchre return ^You put|^You attach|^You sling|^You drape|^You are already wearing
put wear my bundle
matchwait 5
goto SKIN_ERROR

PULL_BUNDLE:
matchre WEAR_BUNDLE_OFF over your shoulder\.$
matchre WEAR_BUNDLE around your waist\.$|on your back\.$|attached to your belt\.$|around your shoulders\.$
put pull my bundle
matchwait 5
goto SKIN_ERROR

WEAR_BUNDLE_OFF:
echo
echo *** CAN'T FIND LOCATION TO WEAR BUNDLE
echo *** WEAR_BUNDLE_OFF ***
echo
put #var GH_WEAR OFF
put drop my bundle
return

BUNDLE_OFF:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** BUNDLE_OFF ***
		echo
	}
	var LOCAL $GH_SKINS
	math LOCAL add 1
	put #var GH_SKINS %LOCAL
	if ("$lefthand" != "Empty") then put empty left
	pause 1
SKIN_KNIFE_SHEATH:
	var LAST SKIN_KNIFE_SHEATH
	if ("$righthandnoun" = "knife") then gosub SHEATHE knife
	goto SKIN_REEQUIP

SKIN_REEQUIP:
	var LAST SKIN_REEQUIP
	if ("%EMPTY_HANDED" != "ON") then
	{
		if ("$righthand" = "Empty") then gosub WIELD_WEAPON %CURR_WEAPON
		if (("%HAND" = "left") && ("$righthand" != "Empty")) then gosub SWAP_LEFT $righthandnoun
	}	
	if ("%SHIELD" != "NONE") then	
	{
		if ("$lefthand" = "Empty") then 
		{
			gosub EQUIP_SHIELD
		}
	}
	if ("%RETREATING" = "ON") then gosub RETREAT_UNTRIGGERS
	goto SKIN_REEQUIP_DONE

######################################
###                                ###
###        Looting routines        ###
###                                ###
######################################
SKIN_MONSTER_OFF: 
SEAR_MONSTER: 
	var Monster $1
SKIN_REEQUIP_DONE:
	pause 1
	gosub clear
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** SEAR_MONSTER: ***
		echo
	}
	put .countbundle
	var LAST SKIN_REEQUIP_DONE	
		matchre TIMER_$GH_TIMER ^I could not find what|not dead
		matchre SEARCH_OTHER_MONSTER ^Sheesh
		matchre LOOT_$GH_LOOT ^You search|^You shove your arm|^Roundtime|picked clean of anything|^You should probably wait until|has already been searched
##CHECK HERE JUST LOOT	
	put loot all
	matchwait 30
	goto LOOT_ERROR

LOOT_OFF:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** Not looting ***
		echo
	}
	goto LOOT_DONE

LOOT_ON:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** Looting ***
		echo
	}
	var LAST LOOT_ON
	if ("%SHIELD" != "NONE") then	
	{
		if ("$lefthand" != "Empty") then 
		{
			gosub UNEQUIP_SHIELD
		}
	}
	goto LOOT_BOX_$GH_LOOT_BOX

LOOT_BOX_ON:
	if matchre ("$roomobjs", "(%boxtype) (%boxes)") then goto GET_BOX
LOOT_BOX_OFF:
	goto LOOT_GEM_$GH_LOOT_GEM

LOOT_GEM_ON:
	if (matchre ("$roomobjs", "\b(%gems1|%gems2|%gems3|%gems4|%gweths)\b(,|\.| and)")) then goto GET_GEM
LOOT_GEM_OFF:
	goto LOOT_COLLECTIBLE_$GH_LOOT_COLL

LOOT_COLLECTIBLE_ON:
	if matchre ("$roomobjs", "\b(%collectibles)\b") then goto GET_COLLECTIBLE
LOOT_COLLECTIBLE_OFF:
	goto LOOT_COIN_$GH_LOOT_COIN

LOOT_COIN_ON:
	if matchre ("$roomobjs", "(coin|coins)") then goto GET_COIN
LOOT_COIN_OFF:
	goto LOOT_JUNK_$GH_LOOT_JUNK

LOOT_JUNK_ON:
	if matchre ("$roomobjs", "(%junkloot)") then goto GET_JUNK
LOOT_JUNK_OFF:
	goto NO_LOOT

GET_BOX:
	var BOX $0
	var LOOTED YES
STOW_BOX:
	var LAST STOW_BOX
		matchre NO_MORE_ROOM_BOX any more room in|^Stow what|^You just can't get|^But that's closed
		matchre LOOT_BOX_ON ^You put your
	put stow box
	matchwait 30
	goto LOOT_ERROR

NO_MORE_ROOM_BOX:
	if matchre ("$righthandnoun", "(%boxes)") then put empty right
	else put empty left
	waitforre ^You drop|^What were you|is already empty
	put #var GH_LOOT_BOX OFF
	put #Beep
	goto LOOT_GEM_$GH_LOOT_GEM

GET_GEM:
	var GEM $1
	var LOOTED YES
	if contains("%GEM", "stone") then
	{
		var GEM stone
	}
STOW_GEM:
	var LAST STOW_GEM		
		matchre NO_MORE_ROOM_GEM any more room in|^Stow what|^You just can't get|^But that's closed|^You think the gem pouch is
		matchre LOOT_GEM_ON ^You put your|^You open your
	put stow gem
	matchwait 30
	goto LOOT_ERROR

NO_MORE_ROOM_GEM:
	put drop %GEM
	waitforre ^You drop|^What were you	
	put #var GH_LOOT_GEM OFF
	goto LOOT_COIN_$GH_LOOT_COIN

GET_COLLECTIBLE:
	var ITEM $0
	var LOOTED YES
STOW_COLLECTIBLE:
	var LAST STOW_COLLECTIBLE
		matchre NO_MORE_ROOM_COLLECTIBLE any more room in|^Stow what|^You just can't get|^But that's closed
		matchre LOOT_COLLECTIBLE_ON ^You put your
	put stow %ITEM
	matchwait 30
	goto LOOT_ERROR

NO_MORE_ROOM_COLLECTIBLE:
	if matchre ("$righthandnoun", "(%collectibles)") then put empty right
	else put empty left
	waitforre ^You drop|^What were you|is already empty
	put #var GH_LOOT_COLL OFF
	goto LOOT_COIN_$GH_LOOT_COIN

GET_COIN:
	var LAST GET_COIN
	put get coin
	waitforre ^You pick up|^What were you
	goto LOOT_COIN_ON

GET_JUNK:
	var JUNK $0
	var LOOTED YES
STOW_JUNK:
	var LAST STOW_JUNK
		matchre  NO_MORE_ROOM_JUNK any more room in|^Stow what|^You just can't get|^But that's closed
		matchre LOOT_JUNK_ON ^You put your
	put stow %JUNK in %JUNK_CONTAINER
	matchwait 30
	goto LOOT_ERROR

NO_MORE_ROOM_JUNK:
	put drop %JUNK
	waitforre ^You drop|^What were you	
	put #var GH_LOOT_JUNK OFF
	goto NO_LOOT

TOO_DARK:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** It's too dark to see anything ***
		echo
	}
	goto TIMER_$GH_TIMER

NO_MONSTER:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo ***        No recognizable monsters.         ***
		echo ***      If you think this is an error,      ***
		echo *** post the creature you just killed please ***
		echo ***          Or AIM IRXSwmr about it         ***
		echo
	}
##CHECK HERE just loot
	put loot all
	goto TIMER_$GH_TIMER

NO_LOOT:
	if ("%GAG_ECHO" != "YES") then
	{
		echo 
		echo *** No Loot ***
		echo
	} 
	if ("%LOOTED" = "YES") then
	{
		var LOCAL $GH_LOOTS
		math LOCAL add 1
		put #var GH_LOOTS %LOCAL
		var LOOTED NO
	}
LOOT_DONE:
##CHECK HERE DELETE LINE BELOW
action goto BLEEDING when eval $bleeding = 1
	var LAST LOOT_DONE
	if ("%RANGED" = "ON") then 
		if matchre("$roomobjs", "%AMMO") then gosub RANGED_CLEAN
	if ("%THROWN" = "ON") then
		if matchre("$roomobjs", "%CURR_WEAPON") then gosub THROWN_CLEAN
	if ("%SHIELD" != "NONE") then	
	{
		if ("$lefthand" = "Empty") then 
		{
			gosub EQUIP_SHIELD
		}
	}
	if ((toupper("$GH_RETREAT") = "ON") && ("%RETREATING" = "OFF")) then gosub RETREAT_TRIGGERS
	goto TIMER_$GH_TIMER

######################################
###                                ###
###   Experience check routines    ###
###                                ###
######################################
TIMER_ON:
	if (%t > (%MAX_TRAIN_TIME)) then goto SWITCH_WEAPON	
TIMER_OFF:
	goto EXPCHECK_$GH_EXP

EXPCHECK_ON:
##CHECK HERE
##	if ($%EXP2.LearningRate > 18) then goto SWITCH_WEAPON
##			else if ($%WEAPON_EXP.LearningRate > 18) then goto SWITCH_WEAPON
##		}
##	} else if ($%WEAPON_EXP.LearningRate > 24) then goto SWITCH_WEAPON	
	if ("%ALTEXP" = "ON") then 
	{
		if ($%EXP2.LearningRate > 14) then
		{
			if ($%EXP2.LearningRate > 20) then goto SWITCH_WEAPON
			else if ($%WEAPON_EXP.LearningRate > 32) then goto SWITCH_WEAPON
		}
	} else if ($%WEAPON_EXP.LearningRate > 32) then goto SWITCH_WEAPON	

EXPCHECK_OFF:
	var LAST EXPCHECK_OFF
	if (toupper("$GH_STANCE") = "ON")) then gosub SWITCH_STANCE
	if ("%MAGIC_TYPE" != "OFF") then 
	{ 
		counter set %MAGIC_COUNT
		save %c
	}
	#put #statusbar 1 GH - Kills:$GH_KILLS  Skins:$GH_SKINS  Loots:$GH_LOOTS
	if ("%SEARCHED" = "YES") then goto FACE
	else goto %c

MIND_MURKED:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** Mind murked up, going to rest mode***
		echo
	}
	pause 1
	send sleep
	var REST ON
	goto EXPCHECK_OFF

SWITCH_STANCE:
##CHECK HERE
##if ($%CURR_STANCE.LearningRate < 15) then return
	if ($%CURR_STANCE.LearningRate < 20) then return
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo ***     SWITCH_STANCE:    ***
		echo *** Current stance locked ***
		echo
	} 
	if ("%CURR_STANCE" = "Evasion") then
	{
		if ("%NOSHIELD" = "OFF") then
		{
			send stance shield
			waitfor You are now set to use
			var CURR_STANCE Shield_Usage
		} else
		{		
			send stance parry
			waitfor You are now set to use
			var CURR_STANCE Parry_Ability
		}
	} elseif ("%CURR_STANCE" = "Shield_Usage") then
	{
		if ("%NOPARRY" = "OFF") then
		{
			put stance parry
			waitfor You are now set to use
			var CURR_STANCE Parry_Ability
		} else
		{
			put stance evasion
			waitfor You are now set to use
			var CURR_STANCE Evasion
		}
	} elseif ("%CURR_STANCE" = "Parry_Ability") then
	{
		if ("%NOEVADE" = "OFF") then
		{
			put stance evasion
			waitfor You are now set to use
			var CURR_STANCE Evasion
		} else
		{
			send stance shield
			waitfor You are now set to use
			var CURR_STANCE Shield_Usage
		}		
	}
	return

SWITCH_WEAPON:
	var LAST SWITCH_WEAPON
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo ***    SWITCH_WEAPON    
		echo *** Weapon skill locked ***
		echo
	}
	put stance shield
	put #playsystem Open
	if ("%EMPTY_HANDED" != "ON") then
	{
		if ("%RANGED" = "ON") then 
		{
			action remove You think you have your best shot possible
			action remove stop concentrating on aiming
			gosub RANGE_SHEATHE
			if (matchre("$roomobjs", "%AMMO\b")) then gosub RANGED_CLEAN
			if ("%REM_SHIELD" != "NONE") then 
			{
				pause 1
				put get %REM_SHIELD
				waitfor You get a
				put wear %REM_SHIELD
				waitfor You slide
			}
		} else 
		{
			put ret
			gosub SHEATHE %CURR_WEAPON
		}
	}
	if ("%SHIELD" != "NONE") then
	{
		gosub UNEQUIP_SHIELD
	}
	if (toupper("$GH_MULTI") != "OFF") then
	{
		if ($GH_MULTI_CURR_NUM < $GH_MULTI_NUM) then 
		{
			var TEMP $GH_MULTI_CURR_NUM
			math TEMP add 1
			put #var GH_MULTI_CURR_NUM %TEMP
		}
		else 
		{
			put #var GH_MULTI_CURR_NUM 1
		}
		if (toupper("$GH_MULTI") = "MULTI") then goto MULTI_$GH_MULTI_CURR_NUM
		else goto DMULTI_$GH_MULTI_CURR_NUM
	} else goto DONE

BLEEDING:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** BLEEDING: ***
		echo You are bleeding
		echo Retreating to check health
		echo
	}
	action remove eval $bleeding = 1
	action var INFECTED YES when ^You.+(infect|disease)
	pause 0.2
	var GOING_TO %LAST
	var INFECTED NO
	put heal
	goto HEALTH_CHECK

STUNNED:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** STUNNED: ***
		echo You have been stunned.
		echo Retreating to check health.
		echo
	}
	action remove eval $stunned = 1
	var GOING_TO %LAST
HEALTH_CHECK:
	gosub clear
		matchre HEALTH_CHECK pole|still stunned
		matchre CHECKING_HEALTH ^You retreat from combat|^You try to back away|already as far away as you can get
	put ret
	matchwait 10
CHECKING_HEALTH:
	if ("%INFECTED" = "YES") then goto INFECTED
	if ($health >= 60) then
	{
		echo
		echo Not too beat up, returning to combat
		echo Be careful!
		echo
		action goto BLEEDING when eval $bleeding = 1
		action goto STUNNED when eval $stunned = 1
		action remove ^You.+(infect|disease)
		goto %GOING_TO
	} else
	{
		echo
		echo Too beat up, aborting
		echo
		goto ABORT
	}

INFECTED:
	echo
	echo Your wounds are infected, seek medical attention!!!
	echo
	put #beep
	goto DEAD

DROPPED_WEAPON:
	pause
	put get %CURR_WEAPON
	counter set 0
	goto BEGIN

ABORT:
	gosub RETREAT_TRIGGERS
ABORTING:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** ABORT: ***
		echo
	}
	echo Injured badly, you need medical assistance
	if ("%DYING" = "ON") then 
	{
		put look sword
##CHECK HERE
##		put quit
	}
	if ($health <= 30) then goto DEAD
	put #beep
	pause 2
	goto ABORTING

DEAD:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** DEAD: ***
		echo
		echo You are dead, or about to be
	}
	if ("%DYING" = "ON") then
	{
		put look sword
		pause 0.5
		put look sword
	}
	put #beep
##CHECK HERE
#	put quit
	exit

NO_VALUE:
	if ("%GAG_ECHO" != "YES") then
	{
		echo
		echo *** NO_VALUE: ***
		echo
	}
	echo Basic use of script .geniehuntera <weapon>
	goto DONE

DONE:
	if ("%REST" = "ON") then send awaken
	echo
	echo ***  DONE:  ***
	echo
	pause 1
	put glance
	put #parse GENIEHUNTER DONE
	put look
	exit

##############################
##                          ##
##      Error handling      ##
##                          ##
##############################
APPR_ERROR:
	gosub clear
	echo
	echo ***                APPR_ERROR                     ***
	echo *** Something happened while appraising a critter ***
	echo
	goto ERROR_DONE

ATTACK_ERROR:
	gosub clear
	echo
	echo ***             ATTACK_ERROR               ***
	echo *** Something bad happened while attacking ***
	echo
	goto ERROR_DONE

CLEANING_ERROR:
	gosub clear
	echo
	echo ***           CLEANING_ERROR              ***
	echo *** Something bad happened while cleaning ***
	echo
	goto ERROR_DONE

DEFAULT_ERROR:
	gosub clear
	echo
	echo ***                        DEFAULT_ERROR:                          ***
	echo ***         Cannot use keyword DEFAULT with keyword multi          ***
	echo *** To use Default settings with multi-weapons, use keyword dmulti ***
	echo
	goto ERROR_DONE

LOOT_ERROR:
	gosub clear
	echo
	echo ***       LOOT_ERROR            ***
	echo *** Error occured while looting ***
	echo
	goto ERROR_DONE

MAGIC_ERROR:
	gosub clear
	echo
	echo ***         MAGIC_ERROR             ***
	echo *** Error occured while using magic ***
	echo
	goto ERROR_DONE

RANGED_ERROR:
	gosub clear
	echo
	echo ***         RANGED_ERROR             ***
	echo *** Error occured while using ranged ***
	echo
	goto ERROR_DONE

SKIN_ERROR:
	gosub clear
	echo
	echo ***          SKIN_ERROR          ***
	echo *** Error occured while skinning ***
	echo
	goto ERROR_DONE

STEALTH_ERROR:
	gosub clear
	echo
	echo ***           STEALTH_ERROR            ***
	echo *** Error occured while being stealthy ***
	echo
	goto ERROR_DONE

SWAP_ERROR:
	gosub clear
	echo
	echo ***              SWAP_ERROR:                    ***
	echo *** Something bad happened while trying to swap ***
	echo
	goto ERROR_DONE

THROWN_ERROR:
	gosub clear
	echo
	echo ***        THROWN_ERROR          ***
	echo *** Error occured while throwing ***
	echo
	goto ERROR_DONE

VARIABLE_ERROR:
	gosub clear
	echo
	echo ***                VARIABLE_ERROR:                 ***
	echo *** An error has occured with one of the variables ***
	echo
	goto ERROR_DONE

WEAPON_APPR_ERROR:
	gosub clear
	echo
	echo ***                   WEAPON_APPR_ERROR:                          ***
	echo *** Something happened while trying to discern the type of weapon ***
	echo
	goto ERROR_DONE

ERROR:
	gosub clear
	echo
	echo *** Some general ERROR occured ***
	echo
	goto DONE

ERROR_DONE:
	pause 1
	echo
	echo *** DONE, BUT WITH ERRORS ***
	echo
	put #beep
	put stow right
	pause 1
	put stow left
	pause 1
	put #playsystem Open
	put glance
	put #parse GENIEHUNTER DONE
	put look
	exit

##############################
##                          ##
##    End Error handling    ##
##                          ##
##############################

#################################
##                             ##
##  General Utility functions  ##
##                             ##
#################################
PAUSE:
	pause
	goto %LAST

HUM_STOP:
	pause
	put stop hum
	goto %LAST

RETURN:
	return
#################################
##                             ##
##        HELP Section         ##
##                             ##
#################################
HELP:
	gosub clear
	echo
	echo **************************************************************************************
	echo **
	echo ** Ambushing
	echo ** Appraisal
	echo ** Armor swapping
	echo ** Backstabbing
	echo ** Brawling
	echo ** Buffing
	echo ** Counting Critters (Dancing)
	echo ** Default Setting
	echo ** Empathic Brawling
	echo ** Experience Checks/Sleeping with a murked mind
	echo ** Global Variables
	echo ** HUNT verb
	echo ** Juggling
	echo ** Looting Options
	echo ** Magic
	echo ** Multi Skill Training
	echo ** Offhand Weapon Fighting
	echo ** Poaching/Sniping
	echo ** Power Perception
	echo ** Roaming a Hunting Ground
	echo ** Retreating Options
	echo ** Shields
	echo ** Skinning Options
	echo ** Snapfiring
	echo ** Stance Options
	echo ** Swappable Weapons (Bastard swords etc.)
	echo ** Syntax Full
	echo ** Targeting Body Parts
	echo ** Tending
	echo ** Timer Training - training for X amount of time
	echo ** Thrown
	echo ** Weapons
	echo **
	echo ** Please type one of the above options for details.
	echo **
	echo **************************************************************************************
	echo
		match HELP_AMBUSH ambush
		match HELP_APP appr
		match HELP_ARMOR armor
		match HELP_BACK back
		matchre HELP_BRAWL brawl
		matchre HELP_BUFF buff
		matchre HELP_COUNT count|danc
		match HELP_DANGER danger
		matchre HELP_DEF defa|sett
		matchre HELP_EMPATH empath
		match HELP_EXP exp
		matchre HELP_GLOBAL glob|var
		match HELP_HUNT hunt
		match HELP_JUGGLE jugg
		match HELP_LOOT loot
		match HELP_MAGIC magic
		match HELP_MULTI multi
		match HELP_OFFHAND offh
		matchre HELP_POACH poach|snip
		match HELP_POWER pow
		match HELP_ROAM roam
		match HELP_RETREAT ret
		match HELP_SHIELD shield
		match HELP_SKIN skin
		match HELP_SNAP snap
		match HELP_STANCE stance
		match HELP_SWAP swap
		match HELP_SYNTAX synt
		match HELP_TARGET targ
		match HELP_TEND tend
		match HELP_THROWN throw
		match HELP_TIMER time
		match HELP_WEAPON weap
	matchwait

HELP_GENERAL:
	echo
	echo ************************************************************************************** 
	echo **
	echo ** The Option you chose was a "General Command"
	echo ** General commands must come before any other scripting commands,
	echo ** but can be mixed in any order with other General Commands.
	echo **
	echo ** LIST of General commands: Appraise, Arrange, Block, Bundle, Count, Custom, Dance, 
	echo **                           Default, Dodge, Evade, Exp, Lootall, Lootbox, Lootcoin,
	echo **                           Lootgem, Retreat, Junk, Multi, Parry, Roam, Timer, 
	echo **                           Target, Train
	echo **
	echo **************************************************************************************
	echo
	pause 5
	goto HELP

HELP_AMBUSH:
	echo
	echo **************************************************************************************
	echo ** For anyone looking to get the drop on someone there's always ambushing.
	echo ** This function will hide/stalk an enemy and then attack from hiding.  For paladins
	echo ** it will unhide before advancing and also unhide before attacking to avoid soul hits.
	echo ** Support is in there for ambushing with ANY melee weapon in the game, as well as 
	echo ** ambushing while brawling.
	echo **
	echo ** .geniehunter ambush {weapon} (shield)
	echo ** .geniehunter ambush brawl {weapon} (shield)
	echo **************************************************************************************
	echo
	pause 3
	goto HELP

HELP_APP:
	echo
	echo **************************************************************************************
	echo ** The Script can be set-up to appraise the monsters you are fighting.
	echo **
	echo ** The script will 'appraise quick' for a 3 second RT.
	echo ** It attempts to app after a kill, and will app when a monster enters an empty room.
	echo ** Do to the limitations of the script it can ONLY app the same type of monster as the
	echo ** last monster you killed.
	echo ** This creates a sort of "hit or miss" system, but it does work most of the time.
	echo **
	echo ** .geniehunter APPR {weapon} (shield)
	echo **
	echo ** Note: The appraisal variable is a global variable so you can turn it on/off as you 
	echo ** so desire while the script is running.  The variable is GH_APPR
	echo **************************************************************************************
	echo
	pause 3
	goto HELP

HELP_ARMOR:
	echo
	echo **************************************************************************************
	echo ** The Script can be set-up to swap armors.
	echo **
	echo ** The script will swap armors when the learning rate becomes greater than the 
	echo ** GH_ARMOR_RATE is set to.  This variable is found in the setup section at the top.
	echo ** This armor will only swap through the armors once per run of the script to keep from
	echo ** Looping endlessly through armors if they all get to the rate.  This count is restarted
	echo ** Everytime Geniehunter is re-run tough, such as when using the MULTI option
	echo **************************************************************************************
	echo
	pause 3
	goto HELP


HELP_BACK:
	echo
	echo ************************************************************************************** 
	echo ** For all you sneaky types, backstab is supported.
	echo ** Just don't try this if you aren't a allowed!
	echo ** And if you try it with an inappropriate weapon, you will just attack like a Barbarian
	echo **
	echo ** .geniehunter backstab {weapon} (shield)
	echo **************************************************************************************
	echo
	pause 3
	goto HELP

HELP_BRAWL:
	echo
	echo **************************************************************************************
	echo ** The script Brawls, no weapons allowed.  Just Fist of Fury
	echo **
	echo ** .geniehunter BRAWL 
	echo **************************************************************************************
	echo
	pause 3
	goto HELP

HELP_BUFF:
	echo **************************************************************************************
	echo ** The Script can be set-up to put up buffing spells, and put them back up when needed
	echo **
	echo ** The script gh_buff needs to be edited for your list of spells, preps, and what
	echo ** to charge the cambrinth at.
	echo **************************************************************************************
	echo
	pause 3
	goto HELP

HELP_COUNT:
	echo
	echo **************************************************************************************
	echo ** It is possible to have the script Dance with a certain number of critters without
	echo ** killing them. The Script will do 'Brawling' until MORE THAN the number of critters 
	echo ** you designate is in the room. (NOT at melee. NOT on you. IN THE ROOM)
	echo ** Both the Count and Dance keyword works for this function
	echo **
	echo ** .geniehunter COUNT/DANCE <Number of critters to dance with>
	echo **
	echo ** Example:
	echo **  .geniehunter COUNT/DANCE 3 Scimitar
	echo **     You will Dance until there are 4 critters, then attack until there are only
	echo **     3 again.
	echo **
	echo ** Note: The dancing variable is a global variable so you can turn it on/off as you 
	echo ** so desire while the script is running.  The variable is GH_DANCING
	echo **************************************************************************************
	echo
	pause 7
	goto HELP

HELP_DANGER:
	echo **************************************************************************************
	echo ** The Script can be set-up to retreat while casting buffing spells in dangerous areas
	echo **
	echo ** This will retreat and stay retreated while buffing.  This option will enable the buff
	echo ** option too.
	echo **************************************************************************************
	echo
	pause 3
	goto HELP

HELP_DEF:
	echo
	echo **************************************************************************************
	echo ** The script can be configured to create 1 default combat setting.
	echo ** This setting will be used when the script is started with no variables.
	echo ** It will skip all variable checks and go immediately into combat using
	echo ** the pre-configured weapon set-up created with this command.
	echo ** 
	echo ** Basically think of this as your "Oh crap! I need to be fighting NOW" set-up.
	echo ** 
	echo ** SYNTAX: .geniehuntera DSET {weapon set-up}
	echo ** EXAMPLE: .geniehuntera DSET loot skin scimtar shield
	echo ** USAGE: .geniehuntera
	echo ** 
	echo ** A note on multi word weapons:
	echo **     If your set-up contains a multi word weapon like short.bow or bastard.sword
	echo ** there is an added step to get this to work properly. Once you create your set-up,
	echo ** since it is inside quotes the . is removed making these one word weapons two words,
	echo ** and thus two variables. To fix this do the following.
	echo **     Go into your config window and click the "Variables" tab. Find the variable
	echo ** with your multi word weapon and re-enter the period. This will make it function 
	echo ** properly when default mode is used.  Default variables are all saved as 
	echo ** GH_DEF_<variable name> so they are easily findable
	echo ** 
	echo **************************************************************************************
	echo
	pause 10
	goto HELP_DM

HELP_DM:
	echo
	echo **************************************************************************************
	echo ** To tie Default setting into a Multi-Weapon Setup use the command DMULTI
	echo ** This will make the script use your default setting as the first chain in
	echo ** Multi-weapon set-up. You must have previously set-up default settings to use this.
	echo ** Also, use DMSET to set the weapons to use
	echo **
	echo ** SYNTAX: .geniehunter DMSET weapon1 weapon2
	echo ** EXAMPLE: .geniehunter DMSET scimitar sword mace
	echo **          This sets up to use these 3 weapons with DEFAULT settings
	echo ** EXAMPLE: .geniehunter DMULTI 2 (this will start fighting with weapon 2)
	echo **
	echo **************************************************************************************
	echo
	pause 3
	goto HELP

HELP_EMPATH:
	echo
	echo **************************************************************************************
	echo ** If you're an Empath, or just want to dance with a critter. There is brawling that
	echo ** doesn't hurt the critter.  No weapons allowed, just like normal brawling
	echo **
	echo ** SYNTAX: .geniehunter EMPATH
	echo **************************************************************************************
	echo
	pause 3
	goto HELP

HELP_EXP:
	echo
	echo **************************************************************************************
	echo ** The script has three methods of Checking Experience.
	echo **   The Main method is using the 'MUlTI' command, where the script will check Exp
	echo ** and switch weapons to your next set-up when needed. (See the Multi-weapon section)
	echo **
	echo **	  The second method is using the 'EXP' variable. This causes the script to check the 
	echo ** of the current weapon, or alternate experience (depending on the skill).  If the 
	echo ** learning state of the experience is greater than 10 (dazed or mind locked) the script
	echo ** stops.
	echo **
	echo **   The third method is using the 'TRAIN' variable.  This causes the script to check 
	echo ** the experience after every weapon cycle.  This method also checks after every kill.
	echo **
	echo **   The 'MULTI' command defaults to using both the 'TRAIN' and 'EXP' variable so it
	echo ** will check experience after every weapon cycle and after every kill
	echo **
	echo ** SYNTAX: .geniehunter EXP <weapon> (shield)
	echo ** SYNTAX: .geniehunter TRAIN <weapon> (shield)
	echo **
	echo ** Note: The training variables are a global variable so you can turn it on/off as you 
	echo ** so desire while the script is running.  The variables are GH_EXP and GH_TRAIN
	echo ** Note2: You need the EXP plugin to make use of these functions.
	echo **************************************************************************************
	echo
	pause 5
	goto HELP

HELP_GLOBAL:
	echo
	echo **************************************************************************************
	echo ** Geniehunter makes use of global variable so that you may modify your hunting without
	echo ** having to restart the script all together.  Here is a list of all the global
	echo ** variables and the allowable values
	echo **
	echo ** GH_AMBUSH    - OFF/ON  (ambushing with weapon)
	echo ** GH_APPR      - NO/YES  (appraising creatures) 
	echo ** GH_ARRANGE   - OFF/ON  (arranging before skinning)
	echo ** GH_BUN       - OFF/ON  (bundling after skinning)
	echo ** GH_DANCING   - OFF/ON  (dancing with creatures)
	echo ** GH_EXP       - OFF/ON  (experience check after kills)
	echo ** GH_LOOT      - OFF/ON  (general looting, if OFF no looting is done)
	echo ** GH_LOOT_BOX  - OFF/ON  (box looting)
	echo ** GH_LOOT_COIN - OFF/ON  (coin looting)
	echo ** GH_LOOT_GEM  - OFF/ON  (gem looting)
	echo ** GH_LOOT_JUNK - OFF/ON  (junk looting)
	echo ** GH_SPELL     - <spell> (spell to cast)
	echo ** GH_MANA      - <mana>  (mana level to prepare spell at)
	echo ** GH_HARN      - <mana>  (mana level to harness after prep)
	echo ** GH_RETREAT   - OFF/ON  (retreating for ranged/magic)
	echo ** GH_ROAM      - OFF/ON  (roaming when nothing left to kill)
	echo ** GH_SKIN      - OFF/ON  (skinning creatures)
	echo ** GH_SKIN_RET  - OFF/ON  (retreating while skinning)
	echo ** GH_SNAP      - OFF/ON  (snapcasting/snapfiring)
	echo ** GH_STANCE    - OFF/ON  (stance switching)
	echo ** GH_TARGET    - <body part> (body part to target)
	echo ** GH_TIMER     - OFF/ON  (using timing function
	echo ** GH_TRAIN     - OFF/ON  (exp checks after combat cycles)
	echo **
	echo Note: Please note values are case sensitive for all variables with the options ON/OFF/NO/YES.
	echo      For all other variables, their values are case insensitive
	echo **************************************************************************************
	echo
	pause 10
	goto HELP

HELP_HUNT:
	echo
	echo **************************************************************************************
	echo ** The script will use the HUNT verb every 90 seconds to train perception, stalking
	echo ** and scouting (for the Rangers).  It will hunt before your swing your weapon during
	echo ** combat.
	echo **
	echo ** SYNTAX: .geniehuntera HUNT {weapon} (shield)
	echo **
	echo **************************************************************************************
	echo
	pause 5
	goto HELP

HELP_JUGGLE:
	echo
	echo **************************************************************************************
	echo ** The script can juggle while waiting for new monsters to show up for killing
	echo **
	echo ** SYNTAX: .geniehunter JUGGLE/YOYO {weapon} (shield)
	echo **
	echo ** You can also use yoyos as a jugglie.  If you use a standard jugglie, the script
	echo ** will also hum while jugglig
	echo **
	echo ** Note:  For this to work you need to have a few global variables:
	echo **                JUGGLIE = your jugglie of choice, be it standard or a yoyo
	echo **                HUM_SONG = song to hum while juggling
	echo **                HUM_DIFFICULTY = song difficulty to hum while juggling
	echo **************************************************************************************
	echo
	pause 5
	goto HELP

HELP_LOOT:
	echo
	echo **************************************************************************************
	echo ** The Script can be set-up to loot Kills. (It always searches.)
	echo **
	echo ** SYNTAX: .geniehunter LOOTALL {weapon} (shield)    <--- Loots everything
	echo **
	echo ** You can also set-up the script to loot specific item types, rather than everything.
	echo ** The variables for these are:
	echo **
	echo ** COLLECTIBLE - will loot collectibles (cards/diras)
	echo ** LOOTBOX - will only loot boxes until the stow container is full
	echo ** LOOTCOIN - will only loot coins
	echo ** LOOTGEM - will only loot gems until the stow container is full
	echo ** JUNK - will loot junk items (runestones/scrolls/lockpicks etc)
	echo **
	echo ** EXAMPLE: .geniehunter LOOTBOX {weapon} {shield}          <--- Loot boxes but not gems or coins.
	echo ** EXAMPLE: .geniehunter LOOTGEM LOOTCOIN {weapon} {shield} <--- Loot coins and gems but not boxes.
	echo **
	echo ** Note: The looting variables are a global variable so you can turn it on/off as you 
	echo ** so desire while the script is running.  The variables are GH_LOOT,GH_LOOT_BOX,
	echo ** GH_LOOT_COIN, GH_LOOT_GEM, and GH_LOOT_JUNK
	echo **************************************************************************************
	echo
	pause 5
	goto HELP

HELP_MAGIC:
	echo
	echo **************************************************************************************
	echo ** At long Last, the script can use magic. Both Targeted and none Targeted Magic, be
	echo **   they attack spells or buff spells. (LB or SOP)
	echo ** It is however limited to one spell, and the standard prep/target/cast routine.
	echo **	  And The script CANNOT use weapons while a spell is being preped/targeted.
	echo ** The script can also use brawling with magic.
	echo **
	echo ** Commands:  TM/PM = You will use mainly magic to hunt.
	echo **            MAGIC = You will use mainly weapons to hunt.
	echo **                 When combined with Multi, TM checks Targeted Magic, PM/MAGIC Primary.
	echo **
	echo ** SYNTAX:   .geniehunter TM/PM/MAGIC <spell> <mana> <harness mana> {weapon} (shield)
	echo **
	echo ** EXAMPLES: .geniehunter TM FB 15 3 scimitar
	echo **           .geniehunter MAGIC SOP 20 swap 1 b.sword targe
	echo **           .geniehunter PM bolt 5 5 - uses bolt spell and brawling for weapon
	echo **
	echo ** Notes: TM/PM will hunt using magic, your weapon is a back-up and is only used when
	echo **        low on mana.
	echo **        MAGIC is a single spell cast as the weapon combo repeats.
	echo **        SNAP can be used for snap casting.
	echo **************************************************************************************
	echo
	pause 10
	goto HELP

HELP_MULTI:
	echo
	echo **************************************************************************************
	echo ** To set up multi weapon simply put in SET as the first variable followed by the
	echo ** geniehunter set-ups you want to cycle through, each set-up must be inside a set of
	echo ** quotes (""). Multi-weapon will change set-ups when you reach Dazed in the
	echo ** current weapon.
	echo ** SYNTAX:  .geniehunter MSET "Set-up1" "Set-up2" "Set-up3" ... "Set-up10"
	echo **        NOTE: You don't have to use all 10 available set-up spots.
	echo ** EXAMPLE: .geniehunter MSET "skin loot scimitar shield" "loot app brawl"
	echo **
	echo ** USE:
	echo **     Once set-up, to use the script for multi-weapon simply use the "multi" command.
	echo ** If you want to start on a set-up that isn't your first one entered simply type in
	echo ** the number of the set-up you want to start with.
	echo ** 
	echo ** SYNTAX: .geniehunter MULTI <Set-up number you want to start with>
	echo ** EXAMPLE: .geniehunter MULTI - starts with Set-up1
	echo ** EXAMPLE: .geniehunter MULTI 3 - starts with Set-up3
	echo ** I know its a bit complex. AIM: IRXSwmr EMAIL: KllrWhle79@hotmail.com
	echo ** 
	echo ** A note on multi word weapons:
	echo **     If a set-up contains a multi word weapon like short.bow or bastard.sword there
	echo ** is an added step to get this to work properly.
	echo **     Once you create your set-up, since it is inside quotes the . is removed making
	echo ** these one word weapons two words, and thus two variables. To fix this do the
	echo ** following.
	echo **     Go into your config window and click the "Variables" tab. Find the variable
	echo ** with your multi word weapon and re-enter the period. This will make it function
	echo ** properly when "multi" is used.  Default variables are all saved as 
	echo ** GH_MULTI_<SETUP NUMBER> so they are easily findable
	echo **
	echo **************************************************************************************
	echo
	pause 10
	goto HELP

HELP_OFFHAND:
	echo
	echo **************************************************************************************
	echo ** The script will fight with your offhand. This function is usable with all melee 
	echo ** weapons and thrown weapons. You must still specify if you want to throw the weapon
	echo ** just like the throwing function. It will use the typical combat sequence, just with 
	echo ** the left hand. Shields are not usable because they provide no protect when held in 
	echo ** the right hand.
	echo **
	echo ** SYNTAX: .geniehunter OFF {weapon}
	echo ** EXAMPLE: .geniehunter OFF scimitar
	echo ** EXAMPLE: .geniehunter OFF throw hammer
	echo **
	echo **************************************************************************************
	echo
	pause 3
	goto HELP

HELP_POACH:
	echo
	echo **************************************************************************************
	echo ** For those of you who like your stealth kills at range, Poaching and Sniping is
	echo ** fully operational.
	echo **
	echo ** SYNTAX: .geniehunter POACH {weapon} (shield(slings and LX only!)
	echo ** SYNTAX: .geniehunter SNIPE {weapon} (shield(LX only!)
	echo **************************************************************************************
	echo
	pause 3
	goto HELP

HELP_POWER:
	echo
	echo **************************************************************************************
	echo ** The script will use the perceive verb to train power perception every 6 minutes
	echo **
	echo ** SYNTAX: .geniehuntera POWERP {weapon} (shield)
	echo **
	echo **************************************************************************************
	echo
	pause 5
	goto HELP

HELP_ROAM:
	echo
	echo **************************************************************************************
	echo ** The script will roam a hunting area if you run out of things to kill. It will move
	echo ** throughout the current hunting area and check each room for people and critters. 
	echo ** It will makes sure you have your ammo first; and if you are bundling skins, it will
	echo ** pick up one bundle to take with you.
	echo **
	echo **                         !!!!!! CAUTION !!!!!!
	echo ** The script does not check to make sure you don't leave the hunting area and enter
	echo ** other, possibly more dangerous areas. Beforewarned that if there are more difficult
	echo ** creatures in an adjacent, easily accessed area, use extreme caution with this function.
	echo ** Also, there is not 100% coverage for people hunting in hiding. Be courteous of others
	echo ** so you don't get an arrow in the face.
	echo **
	echo ** SYNTAX: .geniehunter ROAM {weapon} (shield)
	echo **************************************************************************************
	echo
	pause 7
	goto HELP

HELP_RETREAT:
	echo
	echo **************************************************************************************
	echo ** The script defaults to not staying at a distance while using ranged weapons, thrown
	echo ** weapons and magic.  If you want to stay at a distance and retreat from combat while
	echo ** doing these actions, the script can do that with the RETREAT function
	echo **
	echo ** SYNTAX: .geniehunter RET {weapon} (shield)
	echo **************************************************************************************
	echo
	pause 3
	goto HELP

HELP_SHIELD:
HELP_WEAPON:
	echo
	echo **************************************************************************************
	echo ** It works with (just about) any type of weapon in the game. Anytime you can use a 
	echo ** shield, the script supports it.  The script won't even try to pull out a shield if
	echo ** you are using a two-handed weapon or bow.
	echo ** !!!WARNING!!! If you are using an arm worn shield DO NOT enter a shield name.
	echo **
	echo ** SYNTAX: .geniehunter {weapon} (shield)
	echo **
	echo ** Note: If you have an arm worn shield on when trying to use a bow, the script will
	echo ** remove and attempt to stow the offending shield
	echo **************************************************************************************
	echo
	pause 3
	goto HELP

HELP_SKIN:
	echo
	echo **************************************************************************************
	echo ** Everyone has there own method of how they skin. This script therefore has several
	echo ** options on how skinning works.
	echo ** Here are the commands for skinning, and what they do:
	echo **
	echo ** SKIN     : Skins, drops the skin if you aren't bundling
	echo ** BUNDLE   : Same as 'SKIN', but bundles the skins.  If no ropes to bundle, drops skins, drops bundles
	echo ** SKINRET  : Will make the script retreat before skinning.
	echo ** SCRAPE   : Will scrape the skins before dropping/bundling them
	echo ** ARRANGE  : Same as 'SKIN' but it arranges first, also can input number of times to arrange (1-5)
	echo ** WEAR     : Wears bundles, instead of dropping them
	echo ** TIE      : Ties bundles off before either dropping or wearing them, reduces item count
	echo **
	echo ** There is no need to use 'SKIN' if you are using one of the other options, it knows
	echo ** you're skinning.  In other words, ".geniehunter skin bundle" is redundant, just use 
	echo ** ".geniehunter bundle"
	echo **
	echo ** Options can be combined for full effect.
	echo **
	echo ** EXAMPLE: .geniehunter ARRANGE SKINRET {weapon} - this would make the script retreat,
	echo ** arrange the kill, skin it, and drop the skin.
	echo **
	echo ** Note: If you are a ranger and you do "arrange 5" (max arranges) the script will use
	echo ** "arrange all" to arrange for minimum RT
	echo **************************************************************************************
	echo
	pause 10
	goto HELP

HELP_SNAP:
	echo
	echo ************************************************************************************** 
	echo ** For those of us who are impatient, ALL Ranged systems can be snapfired.
	echo **   Snapfiring will cause the script to aim and fire instanly after you load until 
	echo ** your target is dead.
	echo **
	echo ** SNAP also works with Magic systems. It will fully prepare the spell then Target and
	echo **   Cast at the same time.
	echo **
	echo ** EXAMPLE: .geniehunter SNAP {weapon} (shield)-(slings and LX only!)
	echo ** EXAMPLE: .geniehunter SNAP poach {weapon} (shield)-(slings and LX only!)
	echo ** EXAMPLE: .geniehunter SNAP TM FB 15 scimitar
	echo **************************************************************************************
	echo
	pause 3
	goto HELP

HELP_STANCE:
	echo
	echo **************************************************************************************
	echo ** The script is able to alter your stance.
	echo ** Block - Custom - Evasion - Parry
	echo ** These commands will make the script switch to the preset Stance you enter.
	echo ** 
	echo ** .geniehunter BLOCK/CUSTOM/EVASION(or DODGE)/PARRY {weapon} (shield)
	echo **
	echo ** The script also has the function to switch stances when one is locked. It will
	echo ** determine your current stance, and then check the experience for that skill. If the
	echo ** is dazed or above, it will switch stances.  The stance switching goes in the following
	echo ** order: evasion -> shield -> parry and back
	echo **
	echo ** SYNTAX: .geniehunter STANCE {weapon} (shield)
	echo **
	echo ** If you would like to skip one stance, you can indicate which stance you would like to
	echo ** with the NOEVASION, NOPARRY, or NOSHIELD keywords.  This will skip the indicated
	echo ** stance.  You may only skip one stance.
	echo ** 
	echo ** Note: You must have the EXP plugin for this function to work
	echo **************************************************************************************
	echo
	pause 5
	goto HELP

HELP_SWAP:
	echo
	echo **************************************************************************************
	echo ** The script can be set-up to use swappable weapons.
	echo ** "Swap X" must be followed by the weapon.
	echo **
	echo ** SYNTAX: .geniehunter SWAP {1/2/E/B/PI/HA/SS/QS} {weapon} (shield)
	echo **
	echo ** 1 = 1 handed for weapons that swap between 1 and 2 hands.
	echo ** 2 = 2 handed for weapons that swap between 1 and 2 hands.
	echo ** E = Edged for weapons that swap between edged and blunt.
	echo ** B = Blunt for weapons that swap between edged and blunt.
	echo ** PI = Use this weapon as a Pike.
	echo ** HA = Use this weapon as a Halberd.
	echo ** SS = Use this weapon as a Short Staff.
	echo ** QS = Use this weapon as a Quarter Staff.
	echo **
	echo ** EXAMPLES: .geniehunter SWAP 1 sword shield - uses a sword in 1-handed mode
	echo **           .geniehunter SWAP PI spear - uses a spear in pike mode
	echo **************************************************************************************
	echo
	pause 3
	goto HELP

HELP_SYNTAX:
	echo
	echo **************************************************************************************
	echo **    This is a brief (for me anyway) description of how the script works
	echo ** and what order commands come in, as well as a list of all the commands
	echo ** the script has.
	echo ** 
	echo **    There are many options settings and methods of using the script,
	echo ** all of which have been programed in and can be called forth using the
	echo ** correct comamnds. Knowing those commands and how to use them is what
	echo ** this section is for.
	echo ** 
	echo **    'Command' refers to anything that follows .geniehunter when starting the script.
	echo ** There are several types of commands:
	echo ** 
	echo **    'General Commands' have to come before anything else, but can
	echo ** be placed in any order amongst themselves. These are basic systems
	echo ** that toggle on or off specific non-combat features.
	echo ** 
	echo **    'Combat Methods' come after 'General Commands' but before 
	echo ** 'Combat Systems'. Methods alter a System in very specifc but minor
	echo ** ways, and can usually only be used with a specific System.
	echo ** 
	echo **    'Combat Systems' come After Methods, and Immediately before your
	echo ** Equipment. Systems decide how the script is going to fight. This is usually
	echo ** defined by your Equipment, but occasionlly a System is used that redefines
	echo ** how combat is undergone with Certain Equipment.
	echo ** 
	echo **    'Equipment' is always the last command. When the script finds your
	echo ** Equipment (usually a weapon) it begins combat after equiping you.
	echo ** Equipment is defined as the in game items you will be using to hunt with.
	echo ** 
	echo **    'Special' commands are.. special. They are usually systems that have
	echo ** nothing to do with combat itself, but were placed into the script as extras
	echo ** They are also the commands used to set-up some of the more complex features
	echo ** of the script.
	echo ** 
	echo ** Command List:
	echo ** General Commands: Appraise, Arrange, Block, Bundle, Count, Custom, Dance, Default,
	echo **                   Dodge, Evade, Exp, Lootall, Lootbox, Lootcoin, Lootgem, Retreat,
	echo **                   Junk, Multi, Parry, Roam, Target, Timer, Train
	echo ** Combat Methods: Ambush, Snapfire, Stack
	echo ** Combat Systems: Backstab, Brawl, Empath, Offhand, Snipe, Swap, Throw, TM/PM/Magic
	echo ** Spcl. Commands: MSET and MULTI (multi weapons), DSET (Default Setting), HELP,
	echo **                 DMSET and DMULTI (multi weapons with default settings)
	echo ** 
	echo ** SYNTAX ORDER: [] = Special Commands () = General Commands || = Combat Methods
	echo **               /\ = Combat Systems {} = Equipment
	echo ** 
	echo ** Basic: .geniehunter {weapon} {shield}
	echo ** Advan: .geniehunter () || /\ {}
	echo ** Spcl.: .geniehunter []
	echo ** 
	echo ** For more specifc information please refer to the individual HELP sections.
	echo ** 
	echo **************************************************************************************
	echo
	pause 20
	goto HELP

HELP_TARGET:
	echo
	echo **************************************************************************************
	echo ** So say, you want to behead all your enemies. Well geniehunter will help you out.
	echo ** The TARGET variable let's you specify a body part to attack. This will work with all
	echo ** types of weapons and magic.
	echo **
	echo ** SYNTAX: .geniehunter TARGET <body part> {weapon} (shield)
	echo ** EXAMPLE: .geniehunter TARGET head scimitar
	echo ** EXAMPLE: .geniehunter TARGET right.arm scimitar
	echo **
	echo ** Note: If the body part is multi-word (left arm), use a period (.) to separate the
	echo ** two words
	echo **************************************************************************************
	echo
	pause 5
	goto HELP

HELP_TEND:
	echo
	echo **************************************************************************************
	echo ** Enables tending of body parts.  Currently experimental
	echo ** Does NOT unwrap for optimum EXP, or when wound starts bleeding worse
	echo **
	echo ** SYNTAX: .geniehunter TEND
	echo **************************************************************************************
	echo
	pause 3
	goto HELP
	
HELP_THROWN:
	echo
	echo **************************************************************************************
	echo ** Like to throw things? geniehunter can satisfy your needs!
	echo ** The system is also set up to use and handle stacks of throwing weapons. It is not
	echo ** needed to specify THROW if you are using a STACK, the script knows.
	echo ** 
	echo ** SYNTAX: .geniehunter THROW {weapon} (shield)
	echo ** SYNTAX: .geniehunter STACK {weapon} (shield)
	echo **************************************************************************************
	echo
	pause 3
	goto HELP

HELP_TIMER:
	echo
	echo **************************************************************************************
	echo ** Geniehunter allows for timed hunting rounds.  With the TIMER variable you can set
	echo ** a limit to how long you want to use a weapon. The timer defaults to 10 minutes, 
	echo ** or 600 seconds, so you can just use that or input your own amount of time.
	echo **
	echo ** SYNTAX: .geniehunter TIMER <time in seconds> {weapon} (shield)
	echo ** EXAMPLE: .geniehunter TIMER 900 scimitar - will kill with the scimitar for 15 minutes
	echo ** EXAMPLE: .geniehunter TIMER scimitar - will kill with the scimitar for 10 minutes
	echo **************************************************************************************
	echo
	pause 5
	goto HELP

DYING:
	var DYING ON
	return

INCLUDES:
	#include gh_buff.cmd
	#include gh_armor.cmd
	#include tend.cmd

QUIT:
	put sheath right
	put quit