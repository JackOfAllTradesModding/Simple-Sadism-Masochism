ScriptName maso_CombatDetection Extends ActiveMagicEffect
{Runs on an effect that becomes active when the player enters combat and inactive when the player leaves}

maso_Util Property util Auto;
maso_MCM Property config Auto;

Event OnEffectStart(Actor akTarget, Actor akCaster)
{Player has entered combat}
	config.Log("Player GetCombatState != 0, Player has entered combat")
	util.ChangeCombatState(True);
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
{Player has exited combat}
	config.Log("Player GetCombatState == 0, Player has left combat")
	util.ChangeCombatState(False);
EndEvent 