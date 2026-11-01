package 'System' {
  requirement def 'R6.6.0(2)' { doc /* If the drug loaded into the drug reservoir is not present in the drug library, that the drug is unknown is indicated by the user interface, and recorded in the Fault Log. Pump remains stopped. (UC1.9 §4.1.1) */ }
  requirement def 'R7.3.0(3)' { doc /*  */ }
  requirement def 'R7.3.0(1)' { doc /* The PCA pump shall detect power supply voltage out-of-range, issue a voltage out-of-range warning, and switch to battery backup when out-of-range. */ }
  requirement def 'R7.3.0(2)' { doc /*  */ }
  requirement def 'R6.3.0(1)' { doc /* The PCA pump shall use a physician’s prescription as device parameters. (UC1 §4.1.1 UC2 §4.1.2 UC3 §4.1.3) */ }
  requirement def 'R5.2.0(2)' { doc /* A patient-requested bolus shall be delivered at its prescribed rate, Fbolus, in addition to the prescribed basal flow rate, Fbasal, but no more than the maximum flow rate for the pump, Fmax. (UC2.3 §4.1.2) */ }
  requirement def 'R6.5.0(2)' { doc /* The PCA pump shall have a start button. */ }
  requirement def 'R7.1.0(1)' { doc /* The PCA pump shall implement a safety architecture that separates normal operation from fault detection and response. */ }
  requirement def 'R7.2.0(1)' { doc /*  */ }
  requirement def 'R7.3.0(4)' { doc /* If the estimated battery life remaining is less than ∆ lba = 3 minutes, the pump shall issue a low-battery warning. */ }
  requirement def 'R6.6.0(1)' { doc /* The PCA pump shall maintain an electronic event log to record each action taken by the pump and each event sensed of its environment. */ }
  requirement def 'R6.2.0(1)' { doc /* The mechanical pump shall pump drug at prescribed flow rates for basal, bolus, and KVO infusion when commanded. (UC1 §4.1.1 UC2 §4.1.2 UC3 §4.1.3) */ }
  requirement def 'R6.2.0(2)' { doc /* The mechanical pump shall halt pumping when commanded, or caused in response to an alarm condition.(many EC) */ }
  requirement def 'R5.2.0(3)' { doc /* Patient-requested bolus shall not be delivered more often than a prescribed minimum time between patient-requested bolus, ∆prb. (UC2.2 §4.1.2) */ }
  requirement def 'R5.1.0(1)' { doc /* The basal flow rate, Fbasal, is prescribed by a physician, and entered into the PCA pump by scanning the prescription from the drug container label as it is loaded into the reservoir. (UC1.7 §4.1.1) */ }
  requirement def 'R5.1.0(3)' { doc /* The pump shall deliver basal infusion at the prescribed basal rate within a basal infusion flow tolerance of Fbasal tol = 0.5 ml/hr of the prescribed basal rate. (UC1.12 §4.1.1) */ }
  requirement def 'R5.1.0(2)' { doc /* The pump shall be able to deliver basal infusion at flows throughout the basal infusion flow range of Fbasal min = 1 to Fbasal max = 10 ml/hr. (UC1 §4.1.1) */ }
  requirement def 'R5.1.0(4)' { doc /* Any alarm stops basal rate delivery either halting pump or switching to KVO rate as defined in Table 4. (many EC) */ }
  requirement def 'R6.5.0(1)' { doc /* The control panel shall display helpful messages. */ }
  requirement def 'R6.5.0(3)' { doc /* Upon the clinician’s pressing of the start button, start infusion prescribed. */ }
  requirement def 'R6.5.0(4)' { doc /* The control panel shall display helpful messages. */ }
  requirement def 'R6.1.0(1)' { doc /* The PCA pump shall measure drug flow within a tolerance of Fmd f tol = 0 .1 ml/hr. (many EC) */ }
  requirement def 'R6.4.0(7)' { doc /* If delivered clinician-requested bolus flow rate is less than the calculated square bolus rate by more than its allowed tolerance over a period of more than 5 minutes, or immediately if the flow stops, the pump shall issue a square bolus under-infusion warning (EC4.2.8). */ }
  requirement def 'R6.2.0(3)' { doc /* The mechanical pump shall not allow reverse flow from the patient into the pump. (FDA ??) */ }
  requirement def 'R6.4.0(1)' { doc /* The PCA pump shall issue alarms and warnings that require clinician attention. (many EC) */ }
  requirement def 'R6.4.0(2)' { doc /* If delivered basal flow rate exceeds the prescribed basal rate setting by more than its allowed tolerance over a period of more than 5 minutes, or immediately if the pump goes into free flow, the pump shall issue an basal over-infusion alarm (EC7 §4.2.7). */ }
  requirement def 'R6.4.0(3)' { doc /* If delivered basal flow rate is less than the prescribed basal rate setting by more than its allowed tolerance over a period of more than 5 minutes, or immediately if the flow stops, the pump shall issue an basal under-infusion warning (EC4.2.8). */ }
  requirement def 'R6.4.0(4)' { doc /* If delivered patient-requested bolus flow rate exceeds the prescribed patient-requested bolus rate setting by more than its allowed tolerance over a period of more than 1 minutes, or immediately if the pump goes into free flow, the pump shall issue a bolus over-infusion alarm (EC4.2.7). */ }
  requirement def 'R6.4.0(5)' { doc /* If delivered patient-requested bolus flow rate is less than the prescribed bolus rate setting by more than its allowed tolerance over a period of more than 1 minutes, or immediately if the flow stops, the pump shall issue a bolus under-infusion warning (EC4.2.8). */ }
  requirement def 'R6.4.0(6)' { doc /* If delivered clinician-requested bolus flow rate exceeds the calculated square bolus rate by more than its allowed tolerance over a period of more than 5 minutes, or immediately if the pump goes into free flow, the pump shall issue a square bolus over-infusion alarm (EC4.2.7). */ }
  part def 'Labeling of Nonfunctional Requirements Def';
  part 'Labeling of Nonfunctional Requirements' : 'Labeling of Nonfunctional Requirements Def';
  satisfy 'R6.6.0(2)' by 'Labeling of Nonfunctional Requirements';
  part def 'ICE Bus Adaptor Def';
  part 'ICE Bus Adaptor' : 'ICE Bus Adaptor Def';
  satisfy 'R7.3.0(3)' by 'ICE Bus Adaptor';
  part def 'Maintenance Processor Def';
  part 'Maintenance Processor' : 'Maintenance Processor Def';
  satisfy 'R7.3.0(1)' by 'Maintenance Processor';
  satisfy 'R7.3.0(2)' by 'Maintenance Processor';
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
  part def '10.5.4 Rate Controller Thread Def';
  part '10.5.4 Rate Controller Thread' : '10.5.4 Rate Controller Thread Def';
  satisfy 'R5.2.0(2)' by '10.5.4 Rate Controller Thread';
  satisfy 'R6.5.0(2)' by '10.5.4 Rate Controller Thread';
  part def '10.5.5 Prescription Checker Thread Def';
  part '10.5.5 Prescription Checker Thread' : '10.5.5 Prescription Checker Thread Def';
  part def '10.5.6 ICE Thread Def';
  part '10.5.6 ICE Thread' : '10.5.6 ICE Thread Def';
  part def '10.5.7 Security Thread Def';
  part '10.5.7 Security Thread' : '10.5.7 Security Thread Def';
  satisfy 'R7.1.0(1)' by '10.5.7 Security Thread';
  part def '10.5.8 Max Drug Per Hour Thread Def';
  part '10.5.8 Max Drug Per Hour Thread' : '10.5.8 Max Drug Per Hour Thread Def';
  part def '10.5.9 Patient Bolus Checker Def';
  part '10.5.9 Patient Bolus Checker' : '10.5.9 Patient Bolus Checker Def';
  part def '10.5.10 Drug Library Thread Def';
  part '10.5.10 Drug Library Thread' : '10.5.10 Drug Library Thread Def';
  part def '10.5.11 Event Logger Thread Def';
  part '10.5.11 Event Logger Thread' : '10.5.11 Event Logger Thread Def';
  part def '10.5.12 Patient Button Def';
  part '10.5.12 Patient Button' : '10.5.12 Patient Button Def';
  part def '10.5.13 Scanner Def';
  part '10.5.13 Scanner' : '10.5.13 Scanner Def';
  part def '10.6 Security Subsystem Def';
  part '10.6 Security Subsystem' : '10.6 Security Subsystem Def';
  satisfy 'R7.1.0(1)' by '10.6 Security Subsystem';
  satisfy 'R7.2.0(1)' by '10.6 Security Subsystem';
  satisfy 'R7.3.0(3)' by '10.6 Security Subsystem';
  satisfy 'R7.3.0(4)' by '10.6 Security Subsystem';
  part def '10.7 Fluid Subsystem Def';
  part '10.7 Fluid Subsystem' : '10.7 Fluid Subsystem Def';
  satisfy 'R6.6.0(1)' by '10.7 Fluid Subsystem';
  part def '10.7.1 Pump Def';
  part '10.7.1 Pump' : '10.7.1 Pump Def';
  satisfy 'R5.2.0(2)' by '10.7.1 Pump';
  satisfy 'R6.2.0(1)' by '10.7.1 Pump';
  satisfy 'R6.2.0(2)' by '10.7.1 Pump';
  satisfy 'R5.2.0(3)' by '10.7.1 Pump';
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
  satisfy 'R6.5.0(1)' by 'Drug Reservoir';
  satisfy 'R6.5.0(3)' by 'Drug Reservoir';
  satisfy 'R6.5.0(4)' by 'Drug Reservoir';
  part def 'Safety Subsystem Def';
  part 'Safety Subsystem' : 'Safety Subsystem Def';
  satisfy 'R6.1.0(1)' by 'Safety Subsystem';
  part def 'Failure LED Def';
  part 'Failure LED' : 'Failure LED Def';
  satisfy 'R6.4.0(7)' by 'Failure LED';
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
  part def 'Fault Logger Def';
  part 'Fault Logger' : 'Fault Logger Def';
  satisfy 'R6.4.0(5)' by 'Fault Logger';
  satisfy 'R6.4.0(6)' by 'Fault Logger';
}