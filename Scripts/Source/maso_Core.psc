ScriptName Maso_Core Extends ReferenceAlias
{The backbone (and only content) of this mod}

slaframeworkscr Property SLA Auto;
Maso_MCM Property config Auto;
Float Property Health Auto;
Actor Property PlayerREF Auto;


Event OnInit()
	RegisterForSingleUpdate(3.0);
EndEvent

Event OnPlayerLoadGame()
	RegisterForSingleUpdate(3.0);
EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	Float newHealth = PlayerREf.GetActorValuePercentage("Health") * 100;
	If (newHealth != Health)	
		;Damage was dealt
		SLA.SetActorExposure(PlayerREF, masoExposure(newHealth));
		Health = newHealth; Update health value
	EndIf
	;RegisterForSingleUpdate(3.0);
EndEvent 

Event OnUpdate()
	Health = PlayerREf.GetActorValuePercentage("Health") * 100;
	;If(Health != 1.0)
	;	RegisterForSingleUpdate();
	;EndIf
EndEvent 

Int Function masoExposure(float newHealth)

	Int exp = 0;
	Float marginal = Health - newHealth;
	Float total = 100 - (PlayerRef.GetActorValuePercentage("Health") * 100)
	
	If (config.bUseMarginal)
		exp = exp + ((marginal * config.fMarginalScale) as Int);
	EndIf
	
	If (config.bUseTotal)
		exp = exp + ((total * config.fTotalScale) as Int);
	EndIf
	
	If (config.bThreshold && PlayerRef.GetActorValuePercentage("Health") <= config.fThresholdVal)
		exp = 0
	EndIf

	exp = exp + SLA.GetActorExposure(PlayerREF);
	
	return exp;

EndFunction 