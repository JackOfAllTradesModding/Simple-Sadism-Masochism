ScriptName maso_Util Extends Quest
{Handles a few important features such as reassigning the aliases}

maso_MCM Property config Auto;
{MCM For user configuration settings}

slaframeworkscr Property SLA Auto;
{SexlabArouses}

Quest Property maso_AliasQuest Auto;
{Quest housing the aliases that allow for player sadism and NPC masochism/sadism}

Bool Property PlayerIsInCombat = False Auto;

Bool Property DefeatInstalled = False Auto;

ReferenceAlias Property DefeatPlayerAlias Auto;

ReferenceAlias Property xHairTargetAlias Auto;
{Current actor target by player}

String MasoKey = "SimpleSM.Masochist";
String SadoKey = "SimpleSM.Sadist";

Event OnUpdate()
	config.Log("Period quest reset called to refill aliases.")
	ResetQuest();
EndEvent

Event OnInit()
	RegisterForCrosshairRef()
	ResetQuest()
	If PlayerIsInCombat
		RegisterForSingleUpdate(5*config.fCombatUpdateTime)
	Else
		RegisterForSingleUpdate(5*config.fUpdateTime)
	EndIf
EndEvent

Event OnPlayerLoadGame()
	RegisterForCrosshairRef()
	ResetQuest()
	If PlayerIsInCombat
		RegisterForSingleUpdate(5*config.fCombatUpdateTime)
	Else
		RegisterForSingleUpdate(5*config.fUpdateTime)
	EndIf
EndEvent

Event OnCrosshairRefChange(ObjectReference ref)
	If (ref as Actor)
		;Force new target to alias
		xHairTargetAlias.ForceRefTo(ref)
	Else
		;Clears the target alias
		xHairTargetAlias.Clear()
	EndIf
EndEvent


Function ResetQuest()
{Stops and Restarts the quest to reassign aliases. Should trigger whenever the player enters combat. And on two timers, one in and one out of combat}
	config.Log("Resetting quests...")
	maso_AliasQuest.Stop();
	maso_AliasQuest.Start();
	config.Log("Quests reset!")
EndFunction

Function ChangeCombatState(bool inCombat)
	PlayerIsInCombat = inCombat;
	ResetQuest()
	If PlayerIsInCombat
		RegisterForSingleUpdate(5*config.fCombatUpdateTime)
	Else
		RegisterForSingleUpdate(5*config.fUpdateTime)
	EndIf
EndFunction

Function AssignTraits(Actor aTarget)
{Randomly reassigns Sadism and Masochism traits based on user configuration}
	
	config.Log("Assigning traits on " + aTarget.GetActorBase().GetName());
	;Sadism
	If config.bNPCSadism
		If Utility.RandomInt(0,99) < config.fSadismProb
			config.Log("Actor flagged as Sadist")
			StorageUtil.SetIntValue(aTarget, SadoKey, 1)
		Else
			StorageUtil.SetIntValue(aTarget, SadoKey, 0)
			config.Log("Actor not flagged as Sadist")
		EndIf
	EndIf
	;Masochism
	If config.bNPCMasochism
		If Utility.RandomInt(0,99) < config.fMasochismProb
			config.Log("Actor flagged as Masochist")
			StorageUtil.SetIntValue(aTarget, MasoKey, 1)
		Else
			StorageUtil.SetIntValue(aTarget, MasoKey, 0)
			config.Log("Actor not flagged as Masochist")
		EndIf
	EndIf	
	config.Log("Traits assigned to " + aTarget.GetActorBase().GetName());

EndFunction

Bool Function AddSpecial(Actor aTarget)

	If SpecialActor01.GetActorReference() == None
		SpecialActor01.ForceRefTo(aTarget)
		Return True;
	ElseIf SpecialActor02.GetActorReference() == None
		SpecialActor02.ForceRefTo(aTarget)
		Return True;
	ElseIf SpecialActor03.GetActorReference() == None
		SpecialActor04.ForceRefTo(aTarget)
		Return True;
	ElseIf SpecialActor04.GetActorReference() == None
		SpecialActor04.ForceRefTo(aTarget)
		Return True;
	ElseIf SpecialActor05.GetActorReference() == None
		SpecialActor05.ForceRefTo(aTarget)
		Return True;
	ElseIf SpecialActor06.GetActorReference() == None
		SpecialActor06.ForceRefTo(aTarget)
		Return True;
	ElseIf SpecialActor07.GetActorReference() == None
		SpecialActor07.ForceRefTo(aTarget)
		Return True;
	ElseIf SpecialActor08.GetActorReference() == None
		SpecialActor08.ForceRefTo(aTarget)
		Return True;
	ElseIf SpecialActor09.GetActorReference() == None
		SpecialActor09.ForceRefTo(aTarget)
		Return True;
	ElseIf SpecialActor10.GetActorReference() == None
		SpecialActor10.ForceRefTo(aTarget)
		Return True;
	ElseIf SpecialActor11.GetActorReference() == None
		SpecialActor11.ForceRefTo(aTarget)
		Return True;
	ElseIf SpecialActor12.GetActorReference() == None
		SpecialActor12.ForceRefTo(aTarget)
		Return True;
	ElseIf SpecialActor13.GetActorReference() == None
		SpecialActor13.ForceRefTo(aTarget)
		Return True;
	ElseIf SpecialActor14.GetActorReference() == None
		SpecialActor14.ForceRefTo(aTarget)
		Return True;
	ElseIf SpecialActor15.GetActorReference() == None
		SpecialActor15.ForceRefTo(aTarget)
		Return True;
	ElseIf SpecialActor16.GetActorReference() == None
		SpecialActor16.ForceRefTo(aTarget)
		Return True;
	Else
		Return False;
	EndIf
	
EndFunction

Bool Function RemoveSpecial(Actor aTarget)
	If SpecialActor01.GetActorReference() == aTarget
		SpecialActor01.Clear();
		Return True;
	ElseIf SpecialActor02.GetActorReference() == aTarget
		SpecialActor02.Clear();
		Return True;
	ElseIf SpecialActor03.GetActorReference() == aTarget
		SpecialActor03.Clear();
		Return True;
	ElseIf SpecialActor04.GetActorReference() == aTarget
		SpecialActor04.Clear();
		Return True;
	ElseIf SpecialActor05.GetActorReference() == aTarget
		SpecialActor05.Clear();
		Return True;
	ElseIf SpecialActor06.GetActorReference() == aTarget
		SpecialActor06.Clear();
		Return True;
	ElseIf SpecialActor07.GetActorReference() == aTarget
		SpecialActor07.Clear();
		Return True;
	ElseIf SpecialActor08.GetActorReference() == aTarget
		SpecialActor08.Clear();
		Return True;
	ElseIf SpecialActor09.GetActorReference() == aTarget
		SpecialActor09.Clear();
		Return True;
	ElseIf SpecialActor10.GetActorReference() == aTarget
		SpecialActor10.Clear();
		Return True;
	ElseIf SpecialActor11.GetActorReference() == aTarget
		SpecialActor11.Clear();
		Return True;
	ElseIf SpecialActor12.GetActorReference() == aTarget
		SpecialActor12.Clear();
		Return True;
	ElseIf SpecialActor13.GetActorReference() == aTarget
		SpecialActor13.Clear();
		Return True;
	ElseIf SpecialActor14.GetActorReference() == aTarget
		SpecialActor14.Clear();
		Return True;
	ElseIf SpecialActor15.GetActorReference() == aTarget
		SpecialActor15.Clear();
		Return True;
	ElseIf SpecialActor16.GetActorReference() == aTarget
		SpecialActor16.Clear();
		Return True;
	Else
		Return False;
	EndIf
EndFunction

Function Scan()
{Checks for Defeat. Currently only Defeat. maybe more in the future}
	
	config.Log("Checking for Defeat...")
	
	If Game.GetModByName("SexLabDefeat.esp") && !DefeatInstalled
		config.Log("Defeat found, setting up information.")
		;Its installed and not setup
		Quest getDefeat = Quest.GetQuest("DefeatPlayerQST");
		;Game.GetFormFromFile(0x000D62, "SexLabDefeat.esp");
		DefeatPlayerAlias = (getDefeat.GetAlias(0) as ReferenceAlias); This should work
		;Alternative solution: DefeatPlayerAlias = getDefeat.GetAliasByName("PlayerRef")
		DefeatInstalled = True
	ElseIf Game.GetModByName("SexLabDefeat.esp")
		config.Log("Defeat found, already set up")
		;Installed but we already knew that
	ElseIf DefeatInstalled
		;It was installed but isn't now
		config.Log("Defeat has been removed")
		DefeatInstalled = False;
	Else
		config.Log("Defeat not found")
		DefeatInstalled = False;
	EndIf
	
	config.Log("defeat check completed.")
	
EndFunction 




ReferenceAlias Property SpecialActor01 Auto;
ReferenceAlias Property SpecialActor02 Auto;
ReferenceAlias Property SpecialActor03 Auto;
ReferenceAlias Property SpecialActor04 Auto;
ReferenceAlias Property SpecialActor05 Auto;
ReferenceAlias Property SpecialActor06 Auto;
ReferenceAlias Property SpecialActor07 Auto;
ReferenceAlias Property SpecialActor08 Auto;
ReferenceAlias Property SpecialActor09 Auto;
ReferenceAlias Property SpecialActor10 Auto;
ReferenceAlias Property SpecialActor11 Auto;
ReferenceAlias Property SpecialActor12 Auto;
ReferenceAlias Property SpecialActor13 Auto;
ReferenceAlias Property SpecialActor14 Auto;
ReferenceAlias Property SpecialActor15 Auto;
ReferenceAlias Property SpecialActor16 Auto;