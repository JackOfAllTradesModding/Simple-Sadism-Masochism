ScriptName Maso_SpecialScript Extends ReferenceAlias
{Handles NPC's flagged as special}

maso_MCM Property config Auto;
{MCM, for user configuration}
maso_Util Property util Auto;
{Utility Script for various functions}
ReferenceAlias Property core Auto;
{The script attached to the player, handles player sadism}
ReferenceAlias Property xHairTargetAlias Auto
{Alias for the crosshair target}
slaframeworkscr Property SLA Auto;
{SexlabArouses}

Actor Property PlayerREF Auto;
{The Player, for player sadism}


Float Property Health Auto;
{This actors health, used to find difference after hits}

String MasoKey = "SimpleSM.Masochist";
String SadoKey = "SimpleSM.Sadist";
String SpecialKey = "SimpleSM.Special";

Actor Property Me Auto;

Event OnInit()
	If (Self.GetReference() as Actor)
		Me = (Self.GetReference() as Actor); Sets the Me Property for ease of use and expected performance

		If StorageUtil.GetIntValue(Me, MasoKey, 2) == 2
			util.AssignTraits(Me);
		EndIf
		
		If util.PlayerIsInCombat
			RegisterForSingleUpdate(config.fCombatUpdateTime)
		Else
			RegisterForSingleUpdate(config.fUpdateTime)
		EndIf
	EndIf
EndEvent

Event OnPlayerLoadGame()
	If (Self.GetReference() as Actor)
		Me = (Self.GetReference() as Actor); Sets the Me Property for ease of use and expected performance

		If StorageUtil.GetIntValue(Me, MasoKey, 2) == 2
			util.AssignTraits(Me);
		EndIf
		
		If util.PlayerIsInCombat
			RegisterForSingleUpdate(config.fCombatUpdateTime)
		Else
			RegisterForSingleUpdate(config.fUpdateTime)
		EndIf
	EndIf
EndEvent

Event OnUpdate()
If (Self.GetReference() as Actor)
	Me = (Self.GetReference() as Actor); Sets the Me Property for ease of use and expected performance
	Health = Me.GetActorValue("Health");
	;If(Health != 1.0)
	If util.PlayerIsInCombat
		RegisterForSingleUpdate(config.fCombatUpdateTime)
	Else
		RegisterForSingleUpdate(config.fUpdateTime)
	EndIf
EndIf
EndEvent


Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, Bool abPowerAttack, Bool abSneakAttack, Bool abBashAttack, Bool abHitBlocked)
	
	config.Log("Special: NPC OnHit Event Starting.");
	Float newHealth = Me.GetActorValue("Health");
	
	;If damage was dealt, and not the crosshair target
	If (newHealth < Health)
		
		;Player Sadism
		If ((akAggressor as Actor) == PlayerREF) && (config.bPlayerSadism)
			config.Log("Special: Player Sadism function call...")
			(core as maso_Core).PlayerSadism(Health, newHealth, Me.GetBaseActorValue("Health"));
		
		;NPC Sadism
		ElseIf (StorageUtil.GetIntValue((akAggressor as Actor), SadoKey, 0) == 1) && (StorageUtil.GetIntValue((akAggressor as Actor), SpecialKey, 0) == 1 || config.bNPCSadism)
			config.Log("Special: NPC Sadism function call...")
			ActorSadism((akAggressor as Actor), Health, newHealth, Me.GetBaseActorValue("Health"))
		
		EndIf
		
		;Special NPC Masochism
		If StorageUtil.GetIntValue(Me, MasoKey, 0) == 1 && (config.bNPCMasochism || StorageUtil.GetIntValue(Me, SpecialKey, 0) == 1)
			config.Log("Special: NPC Masochism function call...")
			ActorMasochism(Health, newHealth, Me.GetBaseActorValue("Health"))
		EndIf
		
		Health = newHealth;
		
	EndIf
	
EndEvent

Function ActorMasochism(Float oldHealth, Float newHealth, Float baseHealth)
	config.Log("Actor arousal before being hit: " + SLA.GetActorArousal(Me))
	
	Int Exposure = ((SM_Exposure(oldHealth, newHealth, baseHealth) as Float) * config.fSadismScale) as Int; This is disgusting I know but it's kind of necessary
	config.Log("Actor Exposure:" + Exposure)
	
	SLA.SetActorExposure(Me, Exposure);
	int newArousal = SLA.GetActorArousal(Me);
	config.Log("Actor arousal updated to: " + newArousal);
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
