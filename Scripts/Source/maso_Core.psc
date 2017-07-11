ScriptName Maso_Core Extends ReferenceAlias
{Handles the player Masochism and some NPC sadism}

slaframeworkscr Property SLA Auto;
Maso_MCM Property config Auto;
maso_Util Property util Auto;
Float Property Health Auto;
Actor Property PlayerREF Auto;
;Quest Property Defeat Auto;
ReferenceAlias Property DefeatPlayerAlias Auto;

Bool Property DefeatInstalled = False Auto;
{Whether Sexlab Defeat is installed or not}

String MasoKey = "SimpleSM.Masochist";
String SadoKey = "SimpleSM.Sadist";
String SpecialKey = "SimpleSM.Special";

Event OnInit()
	If util.PlayerIsInCombat
		RegisterForSingleUpdate(config.fCombatUpdateTime)
	Else
		RegisterForSingleUpdate(config.fUpdateTime)
	EndIf
	util.Scan();
EndEvent

Event OnPlayerLoadGame()
	If util.PlayerIsInCombat
		RegisterForSingleUpdate(config.fCombatUpdateTime)
	Else
		RegisterForSingleUpdate(config.fUpdateTime)
	EndIf
	util.Scan();
EndEvent

Event OnUpdate()
	Health = PlayerREf.GetActorValue("Health");
	;If(Health != 1.0)
	If util.PlayerIsInCombat
		RegisterForSingleUpdate(config.fCombatUpdateTime)
	Else
		RegisterForSingleUpdate(config.fUpdateTime)
	EndIf
	;EndIf
EndEvent 

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	config.Log("OnHit Event Starting.");
	Float newHealth = PlayerREf.GetActorValue("Health");
	If (newHealth < Health)	
		;Damage was dealt
		config.Log("Damage was dealt, event proper starting.")
		
		;Player Masochism
		If config.bPlayerMasochism
			config.Log("Player Masochism function call")
			PlayerMasochism(Health, newHealth, PlayerRef.GetBaseActorValue("Health"));
		EndIf
		
		;Aggressor Sadism
		If (config.bNPCSadism || StorageUtil.GetIntValue((akAggressor as Actor), SpecialKey, 0) == 1) && (akAggressor as Actor)
			config.Log("NPC sadism function call")
			Actor aggressor = (akAggressor as Actor);
			If StorageUtil.GetIntValue(aggressor, MasoKey, 2) == 2
				util.AssignTraits(aggressor);
			EndIf
			If StorageUtil.GetIntValue(aggressor, SadoKey, 0) == 1
				ActorSadism(aggressor, Health, newHealth, PlayerRef.GetBaseActorValue("Health"));
			EndIf
		EndIf
		
		Health = newHealth; Update Health
		
	Else
		config.Log("No damage dealt")
	EndIf
	RegisterForSingleUpdate(config.fUpdateTime);
	
EndEvent 



;Functions for Masochism and Sadism Calls:

Function PlayerMasochism(Float oldHealth, Float newHealth, Float baseHealth)
{Handles player masochism, takes damage taken and user settings into account and then increases player arousal}
	
	config.Log("Player arousal before being hit: " + SLA.GetActorArousal(PlayerREF))
	
	Int Exposure = ((SM_Exposure(oldHealth, newHealth, baseHealth) as Float) * config.fSadismScale) as Int; This is disgusting I know but it's kind of necessary
	config.Log("Player Exposure:" + Exposure)
	
	SLA.SetActorExposure(PlayerREF, Exposure);
	int newArousal = SLA.GetActorArousal(PlayerREF);
	config.Log("Player arousal updated to: " + newArousal);
	
		
		;;FIXME
	;Defeat ----------------
	If config.bSurrender && util.DefeatInstalled
		If SLA.GetActorArousal(PlayerREF) >= 99 && (Utility.RandomFloat(0.0, 100.0) < config.fSurrenderChance)
			(util.DefeatPlayerAlias as DefeatPlayer).Surrender(); Holy shit I can't believe this works
		EndIf		
	EndIf

	;Possible orgasm -------
EndFunction

Function PlayerSadism(Float oldHealth, Float newHealth, Float baseHealth) 
{Handles Player Sadism (obviously). Takes damage dealt and user settings into acocunt, and then increases player arousal}
	config.Log("Player arousal before landing hit: " + SLA.GetActorArousal(PlayerREF))
	
	Int Exposure = ((SM_Exposure(oldHealth, newHealth, baseHealth) as Float) * config.fSadismScale) as Int;
	config.Log("Player Exposure:" + Exposure)
	
	SLA.SetActorExposure(PlayerREF, Exposure);
	int newArousal = SLA.GetActorArousal(PlayerREF);
	config.Log("Player arousal updated to: " + newArousal);
EndFunction


Function ActorSadism(Actor Target, Float oldHealth, Float newHealth, Float baseHealth)
{This one's a bit more complicated. Since we can't guarantee they'll have one of the scripts attached we run it external to any alias they might have running}
	config.Log("Aggressor arousal before landing hit: " + SLA.GetActorArousal(Target))
	
	Int Exposure = ((SM_Exposure(oldHealth, newHealth, baseHealth) as Float) * config.fSadismScale) as Int;
	config.Log("Aggressor Exposure:" + Exposure)
	
	SLA.SetActorExposure(Target, Exposure);
	int newArousal = SLA.GetActorArousal(Target);
	config.Log("Aggressor arousal updated to: " + newArousal); I didn't say a lot more complicated, just a bit
EndFunction


Int Function SM_Exposure(Float oldHealth, Float newHealth, Float baseHealth)

	Int exp = 0;
	
	Float marginal;
	
	;MArginal percentage lost
	Float percentLostM = (((oldHealth - newHealth)/baseHealth) * 100.0);Damn I'm good
	
	If (config.absValues)
		If config.bUseMarginalPercentage
			marginal = Math.Abs(percentLostM)
		Else
			marginal = Math.Abs(oldHealth - newHealth);
		EndIf
	Else
		If config.bUseMarginalPercentage
			marginal = percentLostM;
		Else
			marginal = (oldHealth - newHealth);
		EndIf
		
		If (marginal < 0)
			marginal = 0;
		EndIf
	EndIf
	
	Float total;
	
	;Total Percent lost
	Float percentLostT = (((baseHealth - newHealth)/baseHealth) * 100.0);
	
	If config.bUseTotalPercentage
		Total = percentLostT;
	Else
		Total = baseHealth - newHealth;
	EndIf
	
	If (config.bUseMarginal)
		exp = exp + ((marginal * config.fMarginalScale) as Int);
	EndIf
	
	If (config.bUseTotal)
		exp = exp + ((total * config.fTotalScale) as Int);
	EndIf
	
	;;FIXME: Add option for percent or raw damage
	If (config.bThreshold && (percentLostM < config.fThresholdVal))
		exp = 0
	EndIf
	
	;config.Log("Difference in exposure is " + exp);
	exp = exp + SLA.GetActorExposure(PlayerREF);
	
	return exp;

EndFunction
