ScriptName Maso_MCM Extends SKI_ConfigBase
{Mod Configuration Menu for Simple Sadism and Masochism}

;Import StorageUtil;
maso_Util Property util Auto;
{Handles various functions}


Bool Property bUseMarginal = True Auto;
{Whether or not to include the change in health in the effect}
Bool Property bUseTotal = True Auto;
{Whether or not to include the total damage in the effect}
Bool Property bUseMarginalPercentage = False Auto;
{Whether to use the percentage of health lost or raw number for the marginal calculation}
Bool Property bUseTotalPercentage = True Auto;
{Whether to use the percentage of health lost or raw number for the total calculation}

Float Property fMarginalScale = 1.0 Auto;
{Multiplier on value of damage taken to arousal}
Float Property fTotalScale = 0.3 Auto;
{Multiplier on total damage taken to arousal}

Bool Property bThreshold = False Auto;
{Stop arousal increasing below a percentage of health}
Float Property fThresholdVal = 10.0 Auto;
{Value to set the threshold}

Bool Property absValues = False Auto;
{Determines whether negative values are treated as positive or ignored}

Float Property fUpdateTime = 7.5 Auto;
{Controls how frequently the update Event happens outside of combat}
Float Property fCombatUpdateTime = 2.0 Auto;
{How frequently the update events fire while the player is in combat}

Bool Property bOrgasm = False Auto;
{Cum at a certain percentage of health}
Float Property fOrgasmChance = 20.0 Auto;
{chance to cum}
;NOTE: THIS FEATURE NOT YET IMPLEMENTED

Bool Property bTotalModsRate = False Auto;
{Whether or not the total damage modifies the exposure rate}
Float Property fTotalRateScale = 0.1 Auto;
{Scale this applies at}
;NOTE: THIS FEATURE UNTESTED

Bool Property TraceLog = False Auto;
{Determines whether to print debug messages}

Bool Property bSurrender = False Auto;
{Whether the defeat integration is enabled}
Float Property fSurrenderChance = 100.0 Auto;
{Chance of surrendering after being hit at max arousal}

Bool Property bPlayerMasochism = True Auto;
{Player is a masochist or not}
Bool Property bPlayerSadism = True Auto;
{Player is a sadist or not}
Bool Property bNPCMasochism = True Auto;
{NPC's can be masochists or not}
Bool Property bNPCSadism = True Auto;
{NPC's can be sadists or not}
Float Property fMasochismProb = 25.0 Auto;
{Probablity of an NPC being a masochist}
Float Property fSadismProb = 25.0 Auto;
{Probability of an NPC being a sadist}

Float Property fSadismScale = 1.0 Auto;
{Multiplier applied to all Sadism Arousal changes}
Float Property fMasochismScale = 1.0 Auto;
{Multiplier applied to all Masochism Arousal changes}

String[] Property TargetActors Auto;

Int Property Version = 300 Auto;
{In case anyone writes a mod using this specific version}


String MasoKey = "SimpleSM.Masochist";
String SadoKey = "SimpleSM.Sadist";
String SpecialKey = "SimpleSM.Special";


Event OnConfigOpen()

	SelectedActor = 0;

	TargetActors = New String[17]
	
	If util.xHairTargetAlias.GetActorReference()
		TargetActors[0] = "Targeted: " + util.xHairTargetAlias.GetActorReference().GetBaseObject().GetName();
	Else
		TargetActors[0] = "No Target"
	EndIf
	
	If SpecialActor01.GetActorReference()
		TargetActors[1] = SpecialActor01.GetActorReference().GetBaseObject().GetName();
	Else
		TargetActors[1] = "None"
	EndIf
	If SpecialActor02.GetActorReference()
		TargetActors[2] = SpecialActor02.GetActorReference().GetBaseObject().GetName();
	Else
		TargetActors[2] = "None"
	EndIf
	If SpecialActor03.GetActorReference()
		TargetActors[3] = SpecialActor03.GetActorReference().GetBaseObject().GetName();
	Else
		TargetActors[3] = "None"
	EndIf
	If SpecialActor04.GetActorReference()
		TargetActors[4] = SpecialActor04.GetActorReference().GetBaseObject().GetName();
	Else
		TargetActors[4] = "None"
	EndIf
	If SpecialActor05.GetActorReference()
		TargetActors[5] = SpecialActor05.GetActorReference().GetBaseObject().GetName();
	Else
		TargetActors[5] = "None"
	EndIf
	If SpecialActor06.GetActorReference()
		TargetActors[6] = SpecialActor06.GetActorReference().GetBaseObject().GetName();
	Else
		TargetActors[6] = "None"
	EndIf
	If SpecialActor07.GetActorReference()
		TargetActors[7] = SpecialActor07.GetActorReference().GetBaseObject().GetName();
	Else
		TargetActors[7] = "None"
	EndIf
	If SpecialActor08.GetActorReference()
		TargetActors[8] = SpecialActor08.GetActorReference().GetBaseObject().GetName();
	Else
		TargetActors[8] = "None"
	EndIf
	If SpecialActor09.GetActorReference()
		TargetActors[9] = SpecialActor09.GetActorReference().GetBaseObject().GetName();
	Else
		TargetActors[9] = "None"
	EndIf
	If SpecialActor10.GetActorReference()
		TargetActors[10] = SpecialActor10.GetActorReference().GetBaseObject().GetName();
	Else
		TargetActors[10] = "None"
	EndIf
	If SpecialActor11.GetActorReference()
		TargetActors[11] = SpecialActor11.GetActorReference().GetBaseObject().GetName();
	Else
		TargetActors[11] = "None"
	EndIf
	If SpecialActor12.GetActorReference()
		TargetActors[12] = SpecialActor12.GetActorReference().GetBaseObject().GetName();
	Else
		TargetActors[12] = "None"
	EndIf
	If SpecialActor13.GetActorReference()
		TargetActors[13] = SpecialActor13.GetActorReference().GetBaseObject().GetName();
	Else
		TargetActors[13] = "None"
	EndIf
	If SpecialActor14.GetActorReference()
		TargetActors[14] = SpecialActor14.GetActorReference().GetBaseObject().GetName();
	Else
		TargetActors[14] = "None"
	EndIf
	If SpecialActor15.GetActorReference()
		TargetActors[15] = SpecialActor15.GetActorReference().GetBaseObject().GetName();
	Else
		TargetActors[15] = "None"
	EndIf
	If SpecialActor16.GetActorReference()
		TargetActors[16] = SpecialActor16.GetActorReference().GetBaseObject().GetName();
	Else
		TargetActors[16] = "None"
	EndIf

EndEvent

Event OnPageReset(String Page)
	
	If (Page == "")
		;Display Splash
		LoadCustomContent("SimpleMasochism/SimpleMasochism_Flash.dds", 0, 41)
		;X = 376 - (width/2) = 376 - 752/2 = 376 - 376 = 0
		;Y = 223 - (height/2) = 223 - 364/2 = 223 - 182 = 41
	Else
		UnloadCustomContent();
	EndIf
	If (Page == "Options")
		SetCursorPosition(0);
		SetCursorFillMode(LEFT_TO_RIGHT);
		
		AddHeaderOption("Global Settings");
		AddEmptyOption();
		AddSliderOptionST("SadismScale", "Sadism Scale", fSadismScale, "{1}") ;;FIXME
		AddSliderOptionST("MasochismScale", "Masochism Scale", fMasochismScale, "{1}") ;;FIXME
		AddEmptyOption();
		AddEmptyOption();
		;Update Times
		AddSliderOptionST("UpdateTimeSlider", "Normal Update Frequency", fUpdateTime, "{1}");
		AddSliderOptionST("UpdateCombatSlider", "Combat Update Frequency", fCombatUpdateTime, "{1}");
		AddEmptyOption();
		AddEmptyOption();
		;Total and Marginal options
		AddToggleOptionST("UseMarginal", "Use Marginal Value", bUseMarginal);
		AddToggleOptionST("UseTotal", "Use Total Value", bUseTotal);
		AddSliderOptionST("MarginalScale", "Scale", fMarginalScale, "{2}");
		AddSliderOptionST("TotalScale", "Scale", fTotalScale, "{2}");
		AddToggleOptionST("MarginalPercent", "Use Percentage Lost", bUseMarginalPercentage);
		AddToggleOptionST("TotalPercent", "Use Percentage Lost", bUseTotalPercentage);
		AddEmptyOption();
		AddEmptyOption();
		
		
		;Orgasm settings, when implemented
		;AddToggleOptionST("OrgasmToggle", "Allow Orgasm", bOrgasm);
		;AddSliderOptionST("OrgasmChance", "Chance of Orgasm", fOrgasmChance, "{0}");
		;Threshold, when implemented
		;AddToggleOptionST("Threshold", "Use Threshold", bThreshold);
		;AddSliderOptionST("ThresholdVal", "Scale", fThresholdVal, "{0}");
		;AddEmptyOption();
		;AddEmptyOption();
		AddEmptyOption();
		AddEmptyOption();
		
		;Player Settings
		AddHeaderOption("Player Settings");
		AddEmptyOption();
		;Player flagged as Sadist or Masochist
		AddToggleOptionST("PlayerSadism", "Player Sadism", bPlayerSadism);
		AddToggleOptionST("PlayerMasochism", "Player Masochism", bPlayerMasochism);
		;Surrender chance
		AddHeaderOption("Defeat Integration");
		AddEmptyOption();
		AddToggleOptionST("SurrenderState", "Enable Surrendering", bSurrender);
		AddSliderOptionST("SurrenderSlider", "Surrender Chance", fSurrenderChance, "{0}");
		AddEmptyOption();
		AddEmptyOption();
		AddEmptyOption();
		AddEmptyOption();
		
		;NPC Options
		AddHeaderOption("NPC Settings");
		AddEmptyOption();
		;Enable calculations
		AddToggleOptionST("NPCSadism", "NPC Sadism", bNPCSadism);
		AddToggleOptionST("NPCMasochism", "NPC Masochism", bNPCMasochism);
		;Probablity of either being assigned
		AddSliderOptionST("NPCSadismChance", "NPC Sadism Chance", fSadismProb)
		AddSliderOptionST("NPCMasochismChance", "NPC Masochism Chance", fMasochismProb)
		
		;TraceLog
		AddEmptyOption();
		AddEmptyOption();
		AddEmptyOption();
		AddEmptyOption();
		AddHeaderOption("Debug Options")
		AddToggleOptionST("TraceToggle", "Debug Logging", TraceLog);
		AddToggleOptionST("absToggle", "Use Absolute Values", absValues)
		
	ElseIf (Page == "NPC Settings")
		SetCursorPosition(0);
		SetCursorFillMode(LEFT_TO_RIGHT);
		
		AddHeaderOption("Targeted NPC Settings")
		AddEmptyOption()
		
		AddMenuOptionST("TargetMenu", "Target Selection", TargetActors[0])
		SelectedActor = 0;
		
		If util.xHairTargetAlias.GetActorReference()
			AddEmptyOption()
			TargetSpecial = (StorageUtil.GetIntValue(util.xHairTargetAlias.GetActorReference(), SpecialKey, 0) == 1)
			TargetSado = (StorageUtil.GetIntValue(util.xHairTargetAlias.GetActorReference(), SadoKey, 0) == 1)
			TargetMaso = (StorageUtil.GetIntValue(util.xHairTargetAlias.GetActorReference(), MasoKey, 0) == 1)
			AddToggleOptionST("TargSpecialToggle", "Special Actor", TargetSpecial)
			AddToggleOptionST("TargSadoToggle", "Sadist", TargetSado)
			AddToggleOptionST("TargMasoToggle", "Masochist", TargetMaso)
			AddEmptyOption()
			AddEmptyOption()
			AddEmptyOption()
			AddTextOptionST("ApplySettings", "Apply Settings", "Click Me")
		Else
			AddHeaderOption("Please select or target an actor")
		EndIf
	EndIf
EndEvent

Function Log(string msg)

	If(TraceLog)
		Debug.Trace("Simple Masochims: " + msg)
	EndIf

EndFunction


Function ResetTargetPage()
	SetCursorPosition(0);
	SetCursorFillMode(LEFT_TO_RIGHT);
	
	AddHeaderOption("Targeted NPC Settings")
	AddEmptyOption()
	
	AddMenuOptionST("TargetMenu", "Target Selection", TargetActors[SelectedActor])
	
	Actor targ;
	;beginfold
	If SelectedActor == 0
		targ = util.xHairTargetAlias.GetActorReference()
	ElseIf SelectedActor == 1
		targ = SpecialActor01.GetActorReference()
	ElseIf SelectedActor == 2
		targ = SpecialActor02.GetActorReference()
	ElseIf SelectedActor == 3
		targ = SpecialActor03.GetActorReference()
	ElseIf SelectedActor == 4
		targ = SpecialActor04.GetActorReference()
	ElseIf SelectedActor == 5
		targ = SpecialActor05.GetActorReference()
	ElseIf SelectedActor == 6
		targ = SpecialActor06.GetActorReference()
	ElseIf SelectedActor == 7
		targ = SpecialActor07.GetActorReference()
	ElseIf SelectedActor == 8
		targ = SpecialActor08.GetActorReference()
	ElseIf SelectedActor == 9
		targ = SpecialActor09.GetActorReference()
	ElseIf SelectedActor == 10
		targ = SpecialActor10.GetActorReference()
	ElseIf SelectedActor == 11
		targ = SpecialActor11.GetActorReference()
	ElseIf SelectedActor == 12
		targ = SpecialActor12.GetActorReference()
	ElseIf SelectedActor == 13
		targ = SpecialActor13.GetActorReference()
	ElseIf SelectedActor == 14
		targ = SpecialActor14.GetActorReference()
	ElseIf SelectedActor == 15
		targ = SpecialActor15.GetActorReference()
	ElseIf SelectedActor == 16
		targ = SpecialActor16.GetActorReference()
	EndIf
	;endfold
	
	If targ != None
		AddEmptyOption()
		TargetSpecial = (StorageUtil.GetIntValue(targ, SpecialKey, 0) == 1)
		TargetSado = (StorageUtil.GetIntValue(targ, SadoKey, 0) == 1)
		TargetMaso = (StorageUtil.GetIntValue(targ, MasoKey, 0) == 1)
		AddToggleOptionST("TargSpecialToggle", "Special Actor", TargetSpecial)
		AddToggleOptionST("TargSadoToggle", "Sadist", TargetSado)
		AddToggleOptionST("TargMasoToggle", "Masochist", TargetMaso)
		AddEmptyOption()
		AddEmptyOption()
		AddEmptyOption()
		AddTextOptionST("ApplySettings", "Apply Settings", "Click Me")
	Else
		AddHeaderOption("Please select or target an actor")
	EndIf
EndFunction

Function ApplyActorSettings()
	;Got to get the actor using SelectedActor. So this is a bit of a mess:
	Actor targ;
	;beginfold
	If SelectedActor == 0
		targ = util.xHairTargetAlias.GetActorReference()
	ElseIf SelectedActor == 1
		targ = SpecialActor01.GetActorReference()
	ElseIf SelectedActor == 2
		targ = SpecialActor02.GetActorReference()
	ElseIf SelectedActor == 3
		targ = SpecialActor03.GetActorReference()
	ElseIf SelectedActor == 4
		targ = SpecialActor04.GetActorReference()
	ElseIf SelectedActor == 5
		targ = SpecialActor05.GetActorReference()
	ElseIf SelectedActor == 6
		targ = SpecialActor06.GetActorReference()
	ElseIf SelectedActor == 7
		targ = SpecialActor07.GetActorReference()
	ElseIf SelectedActor == 8
		targ = SpecialActor08.GetActorReference()
	ElseIf SelectedActor == 9
		targ = SpecialActor09.GetActorReference()
	ElseIf SelectedActor == 10
		targ = SpecialActor10.GetActorReference()
	ElseIf SelectedActor == 11
		targ = SpecialActor11.GetActorReference()
	ElseIf SelectedActor == 12
		targ = SpecialActor12.GetActorReference()
	ElseIf SelectedActor == 13
		targ = SpecialActor13.GetActorReference()
	ElseIf SelectedActor == 14
		targ = SpecialActor14.GetActorReference()
	ElseIf SelectedActor == 15
		targ = SpecialActor15.GetActorReference()
	ElseIf SelectedActor == 16
		targ = SpecialActor16.GetActorReference()
	EndIf
	;endfold
	
	;Set Each of the 3 flags
	If TargetSpecial && StorageUtil.GetIntValue(targ, SpecialKey, 0) != 1
		
		If util.AddSpecial(targ)
			StorageUtil.SetIntValue(targ, SpecialKey, 1)
		Else
			Debug.MessageBox("Actor not flagged as special because the maximum number of actors have been flagged")
		EndIf
		
	ElseIf !TargetSpecial && StorageUtil.GetIntValue(targ, SpecialKey, 0) == 1
		;NPC was special but no longer
		util.RemoveSpecial(targ)
		StorageUtil.SetIntValue(targ, SpecialKey, 0)
		
	Else
		StorageUtil.SetIntValue(targ, SpecialKey, 0)
	EndIf
	
	If TargetSado
		StorageUtil.SetIntValue(targ, SadoKey, 1)
	Else
		StorageUtil.SetIntValue(targ, SadoKey, 0)
	EndIf
	
	If TargetMaso
		StorageUtil.SetIntValue(targ, MasoKey, 1)
	Else
		StorageUtil.SetIntValue(targ, MasoKey, 0)
	EndIf
	
EndFunction

;Begin MCM States

;GlobalOptions

State SadismScale
	Event OnSliderOpenST()
		SetSliderDialogStartValue(fSadismScale)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.1, 3.0)
		SetSliderDialogInterval(0.1)
	EndEvent
	
	Event OnSliderAcceptST(Float val)
		fSadismScale = val;
		SetSliderOptionValueST(fSadismScale, "{1}")
	EndEvent
	
	Event OnDefaultST()
		fSadismScale = 1.0
		SetSliderOptionValueST(fSadismScale, "{1}")
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("Multiplier applied to all arousal increases caused by Sadism")
	EndEvent
EndState

State MasochismScale
	Event OnSliderOpenST()
		SetSliderDialogStartValue(fMasochismScale)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.1, 3.0)
		SetSliderDialogInterval(0.1)
	EndEvent
	
	Event OnSliderAcceptST(Float val)
		fSadismScale = val;
		SetSliderOptionValueST(fMasochismScale, "{1}")
	EndEvent
	
	Event OnDefaultST()
		fSadismScale = 1.0
		SetSliderOptionValueST(fMasochismScale, "{1}")
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("Multiplier applied to all arousal increases caused by Masochism")
	EndEvent
EndState

State UpdatetimeSlider
	Event OnSliderOpenST()
		SetSliderDialogStartValue(fUpdateTime)
		SetSliderDialogDefaultValue(7.5)
		SetSliderDialogRange(2.0, 15.0)
		SetSliderDialogInterval(0.5)
	EndEvent
	
	Event OnSliderAcceptST(Float val)
		fUpdateTime = val;
		SetSliderOptionValueST(fUpdateTime, "{1}");		
	EndEvent
	
	Event OnDefaultST()
		fUpdateTime = 7.5
		SetSliderOptionValueST(fUpdateTime, "{1}");		
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("Sets the time interval between update events when not in combat")
	EndEvent
EndState

State UpdateCombatSlider
	Event OnSliderOpenST()
		SetSliderDialogStartValue(fCombatUpdateTime)
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.5, 5.0)
		SetSliderDialogInterval(0.5)
	EndEvent
	
	Event OnSliderAcceptST(Float val)
		fUpdateTime = val;
		SetSliderOptionValueST(fCombatUpdateTime, "{1}");		
	EndEvent
	
	Event OnDefaultST()
		fUpdateTime = 2.0
		SetSliderOptionValueST(fCombatUpdateTime, "{1}");		
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("Sets the time interval between update events when in combat")
	EndEvent
EndState

State UseMarginal
	Event OnSelectST()
		bUseMarginal = !bUseMarginal;
		SetToggleOptionValueST(bUseMarginal);
	EndEvent
	
	Event OnDefaultST()
		bUseMarginal = True;
		SetToggleOptionValueST(bUseMarginal);
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("Takes the damage taken from the last attack into consideration when increasing arousal")
	EndEvent
EndState

State UseTotal
	Event OnSelectST()
		bUseTotal = !bUseTotal;
		SetToggleOptionValueST(bUseTotal);
	EndEvent
	
	Event OnDefaultST()
		bUseTotal = True;
		SetToggleOptionValueST(bUseTotal);
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("Takes total damage taken into consideration when increasing arousal")
	EndEvent
EndState

State MarginalScale
	Event OnSliderOpenST()
		SetSliderDialogStartValue(fMarginalScale)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.05, 2.0)
		SetSliderDialogInterval(0.05)
	EndEvent
	
	Event OnSliderAcceptST(Float val)
		fMarginalScale = val;
		SetSliderOptionValueST(fMarginalScale, "{1}");		
	EndEvent
	
	Event OnDefaultST()
		fMarginalScale = 1.0
		SetSliderOptionValueST(fMarginalScale, "{1}");		
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("The multiplier applied to the marginal damage taken when increasing arousal")
	EndEvent
EndState

State TotalScale
	Event OnSliderOpenST()
		SetSliderDialogStartValue(fTotalScale)
		SetSliderDialogDefaultValue(0.25)
		SetSliderDialogRange(0.05, 2.0)
		SetSliderDialogInterval(0.05)
	EndEvent
	
	Event OnSliderAcceptST(Float val)
		fTotalScale = val;
		SetSliderOptionValueST(fTotalScale, "{1}");		
	EndEvent
	
	Event OnDefaultST()
		fTotalScale = 0.25
		SetSliderOptionValueST(fTotalScale, "{1}");		
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("The multiplier applied to the total damage taken when increasing arousal")
	EndEvent
EndState

State MarginalPercent
	Event OnSelectST()
		bUseMarginalPercentage = !bUseMarginalPercentage;
		SetToggleOptionValueST(bUseMarginalPercentage);
	EndEvent
	
	Event OnDefaultST()
		bUseMarginalPercentage = False;
		SetToggleOptionValueST(bUseMarginalPercentage)
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("Whether to use actual health lost or percentage of total health for the calculations")
	EndEvent
EndState

State TotalPercent
	Event OnSelectST()
		bUseTotalPercentage = !bUseTotalPercentage;
		SetToggleOptionValueST(bUseTotalPercentage);
	EndEvent
	
	Event OnDefaultST()
		bUseTotalPercentage = True;
		SetToggleOptionValueST(bUseTotalPercentage);
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("Whether to use actual health lost or percentage of total health for the calculations")
	EndEvent
EndState

State OrgasmToggle
	Event OnSelectST()
		bOrgasm = !bOrgasm
		SetToggleOptionValueST(bOrgasm)
	EndEvent
	
	Event OnDefaultST()
		bOrgasm = False
		SetToggleOptionValueST(bOrgasm)
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("Causes the player to orgasm if at full arousal and struck")
	EndEvent
EndState

State OrgasmChance
	Event OnSliderOpenST()
		SetSliderDialogStartValue(fOrgasmChance)
		SetSliderDialogDefaultValue(20.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(5.0)
	EndEvent
	
	Event OnSliderAcceptST(Float val)
		fOrgasmChance = val
		SetSliderOptionValueST(fOrgasmChance, "{1}")
	EndEvent
	
	Event OnDefaultST()
		fOrgasmChance = 20.0
		SetSliderOptionValueST(fOrgasmChance, "{1}")
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("Chance the player orgasms after being hit at full arousal")
	EndEvent
EndState

State Threshold
	Event OnSelectST()
		bThreshold = !bThreshold;
		SetToggleOptionValueST(bThreshold);
	EndEvent
	
	Event OnDefaultST()
		bThreshold = True;
		SetToggleOptionValueST(bThreshold);
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("Stops arousal from increasing below a certain percentage of health")
	EndEvent
EndState

State ThresholdVal
	Event OnSliderOpenST()
		SetSliderDialogStartValue(fThresholdVal)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(5.0)
	EndEvent
	
	Event OnSliderAcceptST(Float val)
		fThresholdVal = val;
		SetSliderOptionValueST(fThresholdVal, "{1}");		
	EndEvent
	
	Event OnDefaultST()
		fThresholdVal = 10
		SetSliderOptionValueST(fThresholdVal, "{1}");		
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("If health falls below this percentage arousal will stop increasing")
	EndEvent
EndState

;Player Options

State PlayerSadism
	Event OnSelectST()
		bPlayerSadism = !bPlayerSadism
		SetToggleOptionValueST(bPlayerSadism)
	EndEvent
	
	Event OnDefaultST()
		bPlayerSadism = True
		SetToggleOptionValueST(bPlayerSadism)
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("Enables Sadism functionality for the player character")
	EndEvent
EndState

State PlayerMasochism
	Event OnSelectST()
		bPlayerMasochism = !bPlayerMasochism
		SetToggleOptionValueST(bPlayerMasochism)
	EndEvent
	
	Event OnDefaultST()
		bPlayerMasochism = True
		SetToggleOptionValueST(bPlayerMasochism)
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("Enables Masochism functionality for the player character")
	EndEvent
EndState

State SurrenderState
	Event OnSelectST()
		bSurrender = !bSurrender;
		SetToggleOptionValueST(bSurrender);
	EndEvent
	
	Event OnDefaultST()
		bSurrender = True;
		SetToggleOptionValueST(bSurrender);
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("Toggles defeat integration")
	EndEvent
EndState

State SurrenderSlider
	Event OnSliderOpenST()
		SetSliderDialogStartValue(fSurrenderChance)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	
	Event OnSliderAcceptST(Float val)
		fSurrenderChance = val;
		SetSliderOptionValueST(fSurrenderChance);		
	EndEvent
	
	Event OnDefaultST()
		fSurrenderChance = 100.0
		SetSliderOptionValueST(fSurrenderChance);		
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("Likelihood of surrendering via defeat after reaching maximum arousal in combat.")
	EndEvent
EndState 

;NPC Options

State NPCSadism
	Event OnSelectST()
		bNPCSadism = !bNPCSadism
		SetToggleOptionValueST(bNPCSadism)
	EndEvent
	
	Event OnDefaultST()
		bNPCSadism = True
		SetToggleOptionValueST(bNPCSadism)
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("Enables Sadism functionality for NPC's")
	EndEvent
EndState

State NPCMasochism
	Event OnSelectST()
		bNPCMasochism = !bNPCMasochism
		SetToggleOptionValueST(bNPCMasochism)
	EndEvent
	
	Event OnDefaultST()
		bNPCMasochism = True
		SetToggleOptionValueST(bNPCMasochism)
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("Enables Masochism functionality for NPC's")
	EndEvent
EndState

State NPCSadismChance
	Event OnSliderOpenST()
		SetSliderDialogStartValue(fSadismProb)
		SetSliderDialogDefaultValue(25.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	
	Event OnSliderAcceptST(Float val)
		fSadismProb = val;
		SetSliderOptionValueST(fSadismProb)
	EndEvent
	
	Event OnDefaultST()
		fSadismProb = 25.0
		SetSliderOptionValueST(fSadismProb)
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("Chance an NPC is flagged as a sadist")
	EndEvent
EndState

State NPCMasochismChance
	Event OnSliderOpenST()
		SetSliderDialogStartValue(fMasochismProb)
		SetSliderDialogDefaultValue(25.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	
	Event OnSliderAcceptST(Float val)
		fMasochismProb = val;
		SetSliderOptionValueST(fMasochismProb)
	EndEvent
	
	Event OnDefaultST()
		fMasochismProb = 25.0
		SetSliderOptionValueST(fMasochismProb)
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("Chance an NPC is flagged as a masochist")
	EndEvent
EndState
;Debug Options

State TraceToggle
	Event OnSelectST()
		TraceLog = !TraceLog;
		SetToggleOptionValueST(TraceLog);
	EndEvent
	
	Event OnDefaultST()
		TraceLog = False;
		SetToggleOptionValueST(TraceLog);
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("Toggles papyrus logging for debugging reasons");
	EndEvent
EndState

State absToggle
	Event OnSelectST()
		absValues = !absValues;
		SetToggleOptionValueST(absValues);
	EndEvent
	
	Event OnDefaultST()
		absValues = False;
		SetToggleOptionValueST(absValues);
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("If enabled negative values will be treated as positive, if disabled they will be ignore. Implemented for testing purposes.");
	EndEvent
EndState

;Target Settings

State TargetMenu
	Event OnMenuOpenST()
		SetMenuDialogOptions(TargetActors)
		SetMenuDialogStartIndex(0)
		SetMenuDialogDefaultIndex(0)
	EndEvent
	
	Event OnMenuAcceptST(int Index)
		SelectedActor = Index;
		ResetTargetPage();
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("Select the actor to modify settings on")
	EndEvent
EndState

State TargSpecialToggle
	Event OnSelectST()
		TargetSpecial = !TargetSpecial
		SetToggleOptionValueST(TargetSpecial)
	EndEvent
	
	Event OnDefaultST()
		TargetSpecial = False
		SetToggleOptionValueST(TargetSpecial)
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("Flag this actor as Special. Calculations continue to run on selected actors even if turned off globally for NPCs")
	EndEvent
EndState

State TargSadoToggle
	Event OnSelectST()
		TargetSado = !TargetSado
		SetToggleOptionValueST(TargetSado)
	EndEvent
	
	Event OnDefaultST()
		TargetSado = True;
		SetToggleOptionValueST(TargetSado)
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("Flag the actor as a sadist")
	EndEvent
EndState

State TargMasoToggle
	Event OnSelectST()
		TargetMaso = !TargetMaso
		SetToggleOptionValueST(TargetMaso)
	EndEvent
	
	Event OnDefaultST()
		TargetMaso = False
		SetToggleOptionValueST(TargetMaso)
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("Flag the actor as a masochist")
	EndEvent
EndState

State ApplySettings
	Event OnSelectST()
		ApplyActorSettings()
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("Apply the selected settings to the target actor")
	EndEvent
EndState

;End MCM States 



;Extra properties for internal reasons

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

Bool Property TargetSpecial Auto;
Bool Property TargetSado Auto;
Bool Property TargetMaso Auto;

Int SelectedActor = 0;