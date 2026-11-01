package 'System' {
  requirement def 'R6.3.0(1)' { doc /* The PCA pump shall use a physician’s prescription as device parameters. */ }
  requirement def 'R5.2.0(2)' { doc /* A patient-requested bolus shall be delivered at its prescribed rate, Fbolus, in addition to the prescribed basal flow rate, Fbasal, but no more than the maximum flow rate for the pump, Fmax. */ }
  requirement def 'R6.5.0(2)' { doc /* The PCA pump shall have a start button. */ }
  requirement def 'R7.1.0(1)' { doc /* The PCA pump shall implement a safety architecture that separates normal operation from fault detection and response. */ }
  requirement def 'R7.2.0(1)' { doc /* When the stop button is pressed, the current pump stroke shall be completed prior to stopping the pump. */ }
  requirement def 'R6.2.0(1)' { doc /* The mechanical pump shall pump drug at prescribed flow rates for basal, bolus, and KVO infusion when commanded. */ }
  requirement def 'R6.2.0(2)' { doc /* The mechanical pump shall halt pumping when commanded, or caused in response to an alarm condition. */ }
  requirement def 'R5.2.0(3)' { doc /* Patient-requested bolus shall not be delivered more often than a prescribed minimum time between patient-requested bolus, ∆prb. */ }
  requirement def 'R5.1.0(1)' { doc /* The basal flow rate, Fbasal, is prescribed by a physician, and entered into the PCA pump by scanning the prescription from the drug container label as it is loaded into the reservoir. */ }
  requirement def 'R5.1.0(3)' { doc /* The pump shall deliver basal infusion at the prescribed basal rate within a basal infusion flow tolerance of Fbasal tol = 0.5 ml/hr of the prescribed basal rate. */ }
  requirement def 'R5.1.0(2)' { doc /* The pump shall be able to deliver basal infusion at flows throughout the basal infusion flow range of Fbasal min = 1 to Fbasal max = 10 ml/hr. */ }
  requirement def 'R5.1.0(4)' { doc /* Any alarm stops basal rate delivery either halting pump or switching to KVO rate as defined in Table 4. */ }
  requirement def 'R6.5.0(3)' { doc /* Upon the clinician’s pressing of the start button, start infusion prescribed. */ }
  requirement def 'R6.5.0(4)' { doc /* The control panel shall display helpful messages. */ }
  requirement def 'R6.1.0(1)' { doc /* The PCA pump shall measure drug flow within a tolerance of Fmd f tol = 0 .1 ml/hr. */ }
  requirement def 'R6.2.0(3)' { doc /* The mechanical pump shall not allow reverse flow from the patient into the pump. */ }
  requirement def 'R6.4.0(1)' { doc /* The PCA pump shallissue alarms and warnings that require clinician attention. */ }
  requirement def 'R6.4.0(2)' { doc /* If delivered basal flow rate exceeds the prescribed basal rate setting by more than its allowed tolerance over a period of more than 5 minutes, or immediately if the pump goes into free flow, the pump shall issue an basal over-infusion alarm (EC7 §4.2.7). */ }
  requirement def 'R6.4.0(3)' { doc /* If delivered basal flow rate is less than the prescribed basal rate setting by more than its allowed tolerance over a period of more than 5 minutes, or immediately if the flow stops, the pump shall issue an basal under-infusion warning (EC4.2.8). */ }
  requirement def 'R6.4.0(4)' { doc /* If delivered patient-requested bolus flow rate exceeds the prescribed patient-requested bolus rate setting by more than its allowed tolerance over a period of more than 1 minutes, or immediately if the pump goes into free flow, the pump shall issue a bolus over-infusion alarm (EC4.2.7). */ }
  requirement def 'R6.4.0(5)' { doc /* If delivered patient-requested bolus flow rate is less than the prescribed bolus rate setting by more than its allowed tolerance over a period of more than 1 minutes, or immediately if the flow stops, the pump shall issue a bolus under-infusion warning (EC4.2.8). */ }
  requirement def 'R6.4.0(6)' { doc /* If delivered clinician-requested bolus flow rate exceeds the calculated square bolus rate by more than its allowed tolerance over a period of more than 5 minutes, or immediately if the pump goes into free flow, the pump shall issue a square bolus over-infusion alarm (EC4.2.7). */ }
  part def 'Labeling of Nonfunctional Requirements Def';
  part 'Labeling of Nonfunctional Requirements' : 'Labeling of Nonfunctional Requirements Def';
  part def 'ICE Bus Adaptor Def';
  part 'ICE Bus Adaptor' : 'ICE Bus Adaptor Def';
  part def 'Maintenance Processor Def';
  part 'Maintenance Processor' : 'Maintenance Processor Def';
  part def 'Power Supply Def';
  part 'Power Supply' : 'Power Supply Def';
  part def 'Battery Def';
  part 'Battery' : 'Battery Def';
  satisfy 'R6.3.0(1)' by 'Battery';
  part def 'Power Control Def';
  part 'Power Control' : 'Power Control Def';
  part def 'Control Panel Def';
  part 'Control Panel' : 'Control Panel Def';
  part def 'Rate Controller Thread Def';
  part 'Rate Controller Thread' : 'Rate Controller Thread Def';
  satisfy 'R5.2.0(2)' by 'Rate Controller Thread';
  satisfy 'R6.5.0(2)' by 'Rate Controller Thread';
  part def 'Prescription Checker Thread Def';
  part 'Prescription Checker Thread' : 'Prescription Checker Thread Def';
  part def 'ICE Thread Def';
  part 'ICE Thread' : 'ICE Thread Def';
  part def 'Security Thread Def';
  part 'Security Thread' : 'Security Thread Def';
  satisfy 'R7.1.0(1)' by 'Security Thread';
  part def 'Max Drug Per Hour Thread Def';
  part 'Max Drug Per Hour Thread' : 'Max Drug Per Hour Thread Def';
  part def 'Patient Bolus Checker Def';
  part 'Patient Bolus Checker' : 'Patient Bolus Checker Def';
  part def 'Drug Library Thread Def';
  part 'Drug Library Thread' : 'Drug Library Thread Def';
  part def 'Event Logger Thread Def';
  part 'Event Logger Thread' : 'Event Logger Thread Def';
  part def 'Patient Button Def';
  part 'Patient Button' : 'Patient Button Def';
  part def 'Scanner Def';
  part 'Scanner' : 'Scanner Def';
  part def 'Security Subsystem Def';
  part 'Security Subsystem' : 'Security Subsystem Def';
  satisfy 'R7.1.0(1)' by 'Security Subsystem';
  satisfy 'R7.2.0(1)' by 'Security Subsystem';
  part def 'Fluid Subsystem Def';
  part 'Fluid Subsystem' : 'Fluid Subsystem Def';
  part def 'Pump Def';
  part 'Pump' : 'Pump Def';
  satisfy 'R5.2.0(2)' by 'Pump';
  satisfy 'R6.2.0(1)' by 'Pump';
  satisfy 'R6.2.0(2)' by 'Pump';
  satisfy 'R5.2.0(3)' by 'Pump';
  part def 'Upstream Monitor Def';
  part 'Upstream Monitor' : 'Upstream Monitor Def';
  satisfy 'R5.1.0(1)' by 'Upstream Monitor';
  satisfy 'R5.1.0(3)' by 'Upstream Monitor';
  part def 'Downstream Monitor Def';
  part 'Downstream Monitor' : 'Downstream Monitor Def';
  satisfy 'R5.1.0(1)' by 'Downstream Monitor';
  satisfy 'R5.1.0(2)' by 'Downstream Monitor';
  satisfy 'R5.1.0(4)' by 'Downstream Monitor';
  part def 'Drug Reservoir Def';
  part 'Drug Reservoir' : 'Drug Reservoir Def';
  satisfy 'R6.5.0(3)' by 'Drug Reservoir';
  satisfy 'R6.5.0(4)' by 'Drug Reservoir';
  part def 'Safety Subsystem Def';
  part 'Safety Subsystem' : 'Safety Subsystem Def';
  satisfy 'R6.1.0(1)' by 'Safety Subsystem';
  part def 'F ailure LED Def';
  part 'F ailure LED' : 'F ailure LED Def';
  part def 'Alarm Thread Def';
  part 'Alarm Thread' : 'Alarm Thread Def';
  satisfy 'R6.2.0(3)' by 'Alarm Thread';
  part def 'Flow Rate Checker Def';
  part 'Flow Rate Checker' : 'Flow Rate Checker Def';
  part def 'Error Detector Def';
  part 'Error Detector' : 'Error Detector Def';
  satisfy 'R6.4.0(1)' by 'Error Detector';
  satisfy 'R6.4.0(2)' by 'Error Detector';
  satisfy 'R6.4.0(3)' by 'Error Detector';
  satisfy 'R6.4.0(4)' by 'Error Detector';
  part def 'F ault Logger Def';
  part 'F ault Logger' : 'F ault Logger Def';
  satisfy 'R6.4.0(5)' by 'F ault Logger';
  satisfy 'R6.4.0(6)' by 'F ault Logger';
}