ScriptName Maso_MCM Extends SKI_ConfigBase

Bool Property bUseMarginal = True Auto;
{Whether or not to include the change in health in the effect}
Bool Property bUseTotal = True Auto;
{Whether or not to include the total damage in the effect}

Float Property fMarginalScale = 1.0 Auto;
{Multiplier on value of damage taken to arousal}
Float Property fTotalScale = 0.25 Auto;
{Multiplier on total damage taken to arousal}

Bool Property bThreshold = False Auto;
{Stop arousal increasing below a percentage of health}
Float Property fThresholdVal = 10.0 Auto;
{Value to set the threshold}

Bool Property bOrgasm = False Auto;
{Cum at a certain percentage of health}
Float Property fOrgasmVal = 20.0 Auto;
{Value to cum}
;NOTE: THIS FEATURE NOT YET IMPLEMENTED

Bool Property bTotalModsRate = False Auto;
{Whether or not the total damage modifies the exposure rate}
Float Property fTotalRateScale = 0.1 Auto;
{Scale this applies at}
;NOTE: THIS FEATURE UNTESTED

Bool Property TraceLog = False Auto;
{Determines whether to print debug messages}

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
		AddHeaderOption("Exposure Modifiers");
		AddEmptyOption();
		AddToggleOptionST("UseMarginal", "Use Marginal Value", bUseMarginal);
		AddSliderOptionST("MarginalScale", "Scale", fMarginalScale);
		AddToggleOptionST("UseTotal", "Use Total Value", bUseTotal);
		AddSliderOptionST("TotalScale", "Scale", fTotalScale);
		AddEmptyOption();
		AddEmptyOption();
		AddHeaderOption("Threshold");
		AddEmptyOption();
		AddToggleOptionST("Threshold", "Use Threshold", bThreshold);
		AddSliderOptionST("ThresholdVal", "Scale", fThresholdVal);
		AddEmptyOption();
		AddEmptyOption();
		;AddHeaderOption("Exposure Rate Modifiers");
		;AddEmptyOption();
		;AddToggleOptionST("Threshold", "Use Threshold", bThreshold);
		;AddSliderOptionST("MarginalScale", "Scale", fThresholdVal);
		AddToggleOptionST("TraceToggle", "Debug Logging", TraceLog);
	EndIf
EndEvent

Function Log(string msg)

	If(TraceLog)
		Debug.Trace("Simple Masochims: " + msg)
	EndIf

EndFunction

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


State MarginalScale
	Event OnSliderOpenST()
		SetSliderDialogStartValue(fMarginalScale)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.05, 2.0)
		SetSliderDialogInterval(0.05)
	EndEvent
	
	Event OnSliderAcceptST(Float val)
		fMarginalScale = val;
		SetSliderOptionValueST(fMarginalScale);		
	EndEvent
	
	Event OnDefaultST()
		fMarginalScale = 1.0
		SetSliderOptionValueST(fMarginalScale);		
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("The multiplier applied to the marginal damage taken when increasing arousal")
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


State TotalScale
	Event OnSliderOpenST()
		SetSliderDialogStartValue(fTotalScale)
		SetSliderDialogDefaultValue(0.25)
		SetSliderDialogRange(0.05, 2.0)
		SetSliderDialogInterval(0.05)
	EndEvent
	
	Event OnSliderAcceptST(Float val)
		fTotalScale = val;
		SetSliderOptionValueST(fTotalScale);		
	EndEvent
	
	Event OnDefaultST()
		fTotalScale = 0.25
		SetSliderOptionValueST(fTotalScale);		
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("The multiplier applied to the total damage taken when increasing arousal")
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
		SetSliderDialogDefaultValue(0.1)
		SetSliderDialogRange(0.05, 1.0)
		SetSliderDialogInterval(0.05)
	EndEvent
	
	Event OnSliderAcceptST(Float val)
		fThresholdVal = val;
		SetSliderOptionValueST(fThresholdVal);		
	EndEvent
	
	Event OnDefaultST()
		fThresholdVal = 0.1
		SetSliderOptionValueST(fThresholdVal);		
	EndEvent
	
	Event OnHighlightST()
		SetInfoText("If health falls below this percentage arousal will stop increasing")
	EndEvent
EndState
