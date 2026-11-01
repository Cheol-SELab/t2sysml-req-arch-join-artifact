package 'System' {
  requirement def 'R3.4.0(1)' { doc /* The PCA pump should be able to operate within a temperature range of Tlo = 10C to Thi = 50C. */ }
  requirement def 'R3.4.0(2)' { doc /* The pump should be able to withstand and operate under atmospheric pressure ranging from Pmin = 20”Hg to Pmax = 35”Hg. */ }
  requirement def 'R3.4.0(3)' { doc /* The (external) pump should be able to operate at relative humidity ranging from Hmin = 0% to Hmax = 100% (non-condensing). */ }
  requirement def 'R3.4.0(4)' { doc /* The PCA pump shall withstand splashing (but not immersion) with water or bodily fluids. */ }
  requirement def 'R6.8.0(4)' { doc /* All filled prescriptions (liquid, narcotic pain-killer dispensed by the hospital pharmacy) must be labeled at least visibly with a. Patient name b. Drug code c. Name of drug d. Concentration e. Initial volume of drug f. Basal flow rate g. VTBI h. Minimum time between bolus i. Date prescription filled j. Prescribing physician's name k. Pharmacist name */ }
  requirement def 'R7.6.0(2)' { doc /* The PCA pump shall be cleaned and disinfected after use. */ }
  requirement def 'R7.3.0(7)' { doc /* The PCA pump must not leak current greater than 10 mA. */ }
  requirement def 'R7.3.0(8)' { doc /* Component failure must not harm patient (beyond stopping function). */ }
  requirement def 'R7.3.0(9)' { doc /* The PCA pump must be electromagnetically compatible according to IEC 60601-1-2 (2001) Medical Electrical Equipment, Part 1: General Requirements for Safety, 2. Collateral Standard: Electromagnetic Compatibility - Requirements and Tests. (IEC 60601-1-2 2.3.1) */ }
  requirement def 'R7.3.0(10)' { doc /* The PCA pump must withstand electrostatic discharge. */ }
  requirement def 'R7.3.0(11)' { doc /* The PCA pump must filter power interference from mains. */ }
  requirement def 'R6.4.0(1)' { doc /* The PCA pump shall issue alarms and warnings that require clinician attention. */ }
  requirement def 'R6.7.0(1)' { doc /* The ICE Interface shall transmit current operating status and infusion rate to the ICE system. */ }
  requirement def 'R6.7.0(2)' { doc /* The ICE interface shall transmit events, alarms, and warnings to the ICE system. */ }
  requirement def 'R6.7.0(3)' { doc /* The ICE interface shall allow a clinician to set the duration of clinician-requested boluses through an ICE supervisor user interface. */ }
  requirement def 'R6.7.0(4)' { doc /* The PCA pump shall switch to KVO infusion rate when commanded through its ICE interface. */ }
  requirement def 'R6.7.0(5)' { doc /* The PCA pump shall resume prescribed infusion when commanded through its ICE interface. */ }
  requirement def 'R8.3.0(3)' { doc /* Provisioning (or re-provisioning) shall not be possible through an ICE network. */ }
  requirement def 'R8.3.0(1)' { doc /* Provisioning of initial security keys which form a root of trust must require physical connection to a jack distinct from normal operation. */ }
  requirement def 'R8.3.0(2)' { doc /* The provisioning jack must be physically inaccessible, except to authorized technical personnel. */ }
  requirement def 'R7.3.0(6)' { doc /* The PCA pump shall detect power supply voltage out-of-range, issue a voltage out-of-range warning, and switch to battery backup when out-of-range. */ }
  requirement def 'R6.4.2(1)' { doc /* If a visual indicator is necessary for the clinician to identify the equipment or part of the equipment that requires clinician response or awareness, at least one visual alarm signal shall be provided that: 1. indicates the priority of the highest priority alarm condition; and 2. can be perceived correctly at a distance of 4 m from the PCA pump. */ }
  requirement def 'R6.4.2(2)' { doc /* The alarm indicator appearance shall comply with color, flashing frequency, and duty cycle given in Table 5. */ }
  requirement def 'R6.4.2(3)' { doc /* At least one visual alarm signal shall be provided that identifies the specific alarm condition and its priority. This signal shall be perceived correctly (be legible) at a distance of 1 m from the equipment or part of the equipment or from the clinician's position. */ }
  requirement def 'R6.4.2(4)' { doc /* Visual alarms shall display alarm symbols from Table D.201 Graphical symbols for ALARM SYSTEMS of standard IEC 60601-1-8. */ }
  requirement def 'R6.4.3(1)' { doc /* Alarms shall cause audible alarms signals that meet the requirements of Tables 203 and 204 of standard IEC 60601-1-8 for alarm pulses, bursts, and harmonics. */ }
  requirement def 'R6.4.3(2)' { doc /* The auditory volume of audible alarms signals shall conform to Section 201.3.3.2 Volume of auditory ALARM SIGNALS and INFORMATION SIGNALS of standard IEC 60601-1-8. */ }
  requirement def 'R6.4.3(3)' { doc /* The alarm melody of audible alarms signals shall conform to Table AAA.1 of standard IEC 60601-1-8 for drug or fluid delivery. */ }
  requirement def 'R6.5.0(2)' { doc /* The PCA pump shall have a start button. */ }
  requirement def 'R6.5.0(5)' { doc /* The PCA pump shall have a stop button. */ }
  requirement def 'R6.5.0(7)' { doc /* The control panel shall allow clinician bolus request and choice of duration. */ }
  requirement def 'R6.5.0(9)' { doc /* Prescriptions that violate the soft limits of the drug in the drug library shall issue a visible and audible warning requiring a soft limit confirmation by the clinician. */ }
  requirement def 'R6.5.0(11)' { doc /* The Control Panel shall show alarm condition as described in Section 6.4.2. */ }
  requirement def 'R6.5.0(12)' { doc /* The Control Panel shall audibly sound alarm condition as described in Section 6.4.3. */ }
  requirement def 'R6.5.0(13)' { doc /* Pressing the stop button silences all alarms and terminates any alarm signal inactivation. */ }
  requirement def 'R6.5.0(14)' { doc /* The Control Panel shall provide means to inactivate audible alarms indefinitely. */ }
  requirement def 'R6.5.0(15)' { doc /* The Control Panel shall provide means to inactivate audible alarms temporarily for a predefined period of time. */ }
  requirement def 'R6.5.0(16)' { doc /* The Control Panel shall provide means to cancel alarm signal inactivation. */ }
  requirement def 'R6.5.0(17)' { doc /* When auditory alarms are inactive the control panel shall display an inactive auditory alarm symbol from Table D.201 Graphical symbols for ALARM SYSTEMS of standard IEC 60601-1-8. */ }
  requirement def 'R6.5.0(18)' { doc /* If the same alert-stop-start sequence occurs 3 or more times in ten minutes, infusion will be stopped, and an audible alarm sounded. */ }
  requirement def 'R6.5.0(19)' { doc /* The Control Panel confirms operation after power-on self-test of sound of audible alarm, */ }
  requirement def 'R6.5.0(20)' { doc /* The Control Panel confirms operation after power-on self-test of display of visual information, and */ }
  requirement def 'R6.5.0(21)' { doc /* The Control Panel confirms operation after power-on self-test of tactile response (button press). */ }
  requirement def 'R6.5.0(22)' { doc /* The PCA pump shall resume prescribed infusion when the Start button is pressed. */ }
  requirement def 'R6.5.0(23)' { doc /* The PCA pump shall display infusion rate currently pumping. */ }
  requirement def 'R6.8.0(6)' { doc /* A clinician must personally confirm the prescription is for the patient to be infused. */ }
  requirement def 'R5.1.0(1)' { doc /* The basal flow rate, Fbasal, is prescribed by a physician, and entered into the PCA pump by scanning the prescription from the drug container label as it is loaded into the reservoir. */ }
  requirement def 'R5.1.0(5)' { doc /* The pump shall maintain a minimum KVO flow rate of FKVO = 1 ml/hr at all times during infusion, even during alarms, unless the alarm also stops flow, or the stop button is pressed. Table 4 defines which alarms also stop drug flow completely. */ }
  requirement def 'R5.2.0(2)' { doc /* A patient-requested bolus shall be delivered at its prescribed rate, Fbolus, in addition to the prescribed basal flow rate, Fbasal, but no more than the maximum flow rate for the pump, Fmax. */ }
  requirement def 'R5.1.0(4)' { doc /* Any alarm stops basal rate delivery either halting pump or switching to KVO rate as defined in Table 4. */ }
  requirement def 'R5.2.0(6)' { doc /* Any alarm stops patient-requested bolus delivery either halting pump or switching to KVO rate as defined in Table 4. */ }
  requirement def 'R6.2.0(2)' { doc /* The mechanical pump shall halt pumping when commanded, or caused in response to an alarm condition. */ }
  requirement def 'R6.5.0(3)' { doc /* Upon the clinician’s pressing of the start button, start infusion prescribed. */ }
  requirement def 'R6.5.0(6)' { doc /* Upon the clinician’s pressing of the stop button, stop infusion. */ }
  requirement def 'R7.5.0(2)' { doc /* Before infusion, the door must be closed and locked. (UC1.10 §4.1.1) */ }
  requirement def 'R5.2.0(4)' { doc /* Prescribed VTBI and rate shall not exceed the maximum VTBI limit set by the drug library from the hospital pharmacy for the drug loaded in the PCA pump. */ }
  requirement def 'R6.3.0(1)' { doc /* The PCA pump shall use a physician's prescription as device parameters. */ }
  requirement def 'R6.5.0(10)' { doc /* Prescriptions that violate a hard limit of the drug in the drug library shall be rejected with visible and audible indication when confirmation is attempted by the clinician. */ }
  requirement def 'R6.7.0(6)' { doc /* When the PCA pump is not connected to an ICE network, or the ICE network connection fails, the PCA pump shall operate as a singular, stand-alone device. */ }
  requirement def 'R6.7.0(7)' { doc /* The ICE interface may inactivate alarms. */ }
  requirement def 'R8.1.0(3)' { doc /* Drug container must have a valid prescription for the particular patient to be infused by the PCA pump. */ }
  requirement def 'R8.1.0(4)' { doc /* Drug library information shall be authenticated before it is accepted. */ }
  requirement def 'R5.2.0(5)' { doc /* Patient-requested bolus shall not be delivered if infusing prescribed VTBI will exceed hard limits retrieved from the drug library for the volume of drug infused over a period of time. Pump rate shall be reduced to KVO and a max dose warning be issued. */ }
  requirement def 'R5.2.0(3)' { doc /* Patient-requested bolus shall not be delivered more often than a prescribed minimum time between patient-requested bolus, ∆prb. */ }
  requirement def 'R6.8.0(8)' { doc /* The drug loaded into the reservoir must also be found in the PCA pump's drug in library. */ }
  requirement def 'R6.8.0(5)' { doc /* Prior to, or coincident with, loading the drug reservoir must also enter prescription on the drug container's label using the scanner. */ }
  requirement def 'R6.10.0(1)' { doc /* The scanner shall read and authenticate information from the patient’s wristband. */ }
  requirement def 'R6.10.0(2)' { doc /* The scanner shall read and authenticate information from the clinician’s badge. */ }
  requirement def 'R6.10.0(3)' { doc /* The scanner shall read and authenticate information from the drug’s package label. */ }
  requirement def 'R8.2.0(1)' { doc /* Patient information must be restricted to those providing care for the patient, and the patient. */ }
  requirement def 'R8.3.0(4)' { doc /* Provisioning shall be a single, unitary block-transfer. */ }
  requirement def 'R7.6.0(1)' { doc /* All materials that contact fluid shall be biocompatible. */ }
  requirement def 'R5.1.0(2)' { doc /* The pump shall be able to deliver basal infusion at flows throughout the basal infusion flow range of Fbasal min = 1 to Fbasal max = 10 ml/hr. */ }
  requirement def 'R5.1.0(3)' { doc /* The pump shall deliver basal infusion at the prescribed basal rate within a basal infusion flow tolerance of Fbasal tol = 0.5 ml/hr of the prescribed basal rate. */ }
  requirement def 'R6.2.0(1)' { doc /* The mechanical pump shall pump drug at prescribed flow rates for basal, bolus, and KVO infusion when commanded. */ }
  requirement def 'R7.2.0(1)' { doc /* When the stop button is pressed, the current pump stroke shall be completed prior to stopping the pump. */ }
  requirement def 'R7.2.0(2)' { doc /* During normal use and/or single fault condition of the equipment, continuous reverse delivery shall not be possible. */ }
  requirement def 'R7.2.0(6)' { doc /* When an occlusion alarm occurs, the pump shall be stopped immediately without completing the current pump stroke. */ }
  requirement def 'R6.2.0(3)' { doc /* The mechanical pump shall not allow reverse flow from the patient into the pump. */ }
  requirement def 'R6.1.0(1)' { doc /* The PCA pump shall measure drug flow within a tolerance of Fmdftol = 0.1 ml/hr. */ }
  requirement def 'R6.1.0(3)' { doc /* The PCA pump shall detect upstream occlusion. */ }
  requirement def 'R6.1.0(2)' { doc /* The PCA pump shall detect downstream occlusion. */ }
  requirement def 'R6.1.0(4)' { doc /* The PCA pump shall detect air-in-line embolism (bubble). */ }
  requirement def 'R6.8.0(1)' { doc /* The drug reservoir holds liquid pain-killer supplied by the hospital pharmacy and loaded into the PCA pump by the clinician. */ }
  requirement def 'R6.8.0(2)' { doc /* The drug reservoir shall measure its contents. */ }
  requirement def 'R6.8.0(3)' { doc /* The measured drug volume shall be within Vrt = 1 ml of the actual drug volume. */ }
  requirement def 'R7.2.0(7)' { doc /* When an empty-reservoir alarm occurs, the current pump stroke shall be completed prior to stopping the pump. */ }
  requirement def 'R7.5.0(1)' { doc /* Because the drugs used for analgesia are often narcotic, requiring Drug Enforcement Agency (DEA) tracking if used in the United States, the drug reservoir and means to change prescriptions during infusion must be inhibited with a locked, tamper-resistant door. */ }
  requirement def 'R7.5.0(3)' { doc /* Hospital procedures must endow the attending clinician access to the door key, yet prevent other persons' access. */ }
  requirement def 'R7.5.0(4)' { doc /* The PCA pump case must be at least difficult to breech as its tamper-resistant door. Breaking the case shall not be easier to access the drug reservoir than breeching the door. */ }
  requirement def 'R7.2.0(8)' { doc /* An open door alarm shall be triggered when the reservoir door is opened while the pump is not stopped. */ }
  requirement def 'R7.1.0(1)' { doc /* The PCA pump shall implement a safety architecture that separates normal operation from fault detection and response. */ }
  requirement def 'R7.4.0(7)' { doc /* Hardware faults that prevent operation of the Control Panel shall illuminate a hardware fault indicator (light-emitting diode). (EC22f §4.2.22) */ }
  requirement def 'R6.4.0(2)' { doc /* If delivered basal flow rate exceeds the prescribed basal rate setting by more than its allowed tolerance over a period of more than 5 minutes, or immediately if the pump goes into free flow, the pump shall issue an basal over-infusion alarm. */ }
  requirement def 'R6.4.0(3)' { doc /* If delivered basal flow rate is less than the prescribed basal rate setting by more than its allowed tolerance over a period of more than 5 minutes, or immediately if the flow stops, the pump shall issue an basal under-infusion warning. */ }
  requirement def 'R6.4.0(4)' { doc /* If delivered patient-requested bolus flow rate exceeds the prescribed patient-requested bolus rate setting by more than its allowed tolerance over a period of more than 1 minutes, or immediately if the pump goes into free flow, the pump shall issue a bolus over-infusion alarm. */ }
  requirement def 'R6.4.0(5)' { doc /* If delivered patient-requested bolus flow rate is less than the prescribed bolus rate setting by more than its allowed tolerance over a period of more than 1 minutes, or immediately if the flow stops, the pump shall issue a bolus under-infusion warning. */ }
  requirement def 'R6.4.0(6)' { doc /* If delivered clinician-requested bolus flow rate exceeds the calculated square bolus rate by more than its allowed tolerance over a period of more than 5 minutes, or immediately if the pump goes into free flow, the pump shall issue a square bolus over-infusion alarm. */ }
  requirement def 'R7.2.0(3)' { doc /* An air-in-line alarm shall be triggered by the pump if detectable air bubbles are infused into the patient. */ }
  requirement def 'R7.2.0(4)' { doc /* An upstream occlusion alarm shall be triggered when the pump senses an upstream (drug reservoir side) occlusion exceeding Puo = 1 psi. */ }
  requirement def 'R7.2.0(5)' { doc /* A downstream occlusion alarm shall be triggered if the pump senses a downstream (patient side) occlusion exceeding Pdo = 10 psi. */ }
  requirement def 'R7.4.0(1)' { doc /* The PCA pump shall perform a power-on self-test (POST) to assure system integrity after being turned on, yet before any infusion begins. Failure of POST shall raise a POST alarm, stop pump, record it in the Fault Log, and display the reason for failure on the user interface. (EC4 §4.2.4) */ }
  requirement def 'R7.4.0(2)' { doc /* The PCA pump shall perform periodic self-tests to assure system integrity during long periods of use. Failure of a self-test shall raise a self-test alarm, stop pump, record it in the Fault Log, and display the reason for failure on the user interface. (EC22c §4.2.22) */ }
  requirement def 'R7.4.0(3)' { doc /* The PCA pump shall have continuous fault-detection and masking. Hardware monitors of thread heartbeat, memory error correction codes are examples. (EC22d §4.2.22) */ }
  requirement def 'R7.4.0(4)' { doc /* Occurrence of unavoidable single-event upsets caused by cosmic-ray-induced high- and thermal-energy neutrons must be either masked, or detected to fail-stop. (EC22d §4.2.22) */ }
  requirement def 'R7.4.0(5)' { doc /* Successfully masked faults shall be recorded in the Fault Log, but not raise an alarm. (EC22e §4.2.22) */ }
  requirement def 'R7.4.0(6)' { doc /* All unmasked hardware detected faults shall raise a fault alarm, stop pump, record it in the Fault Log, and display the reason for fault on the user interface. (EC22 §4.2.22) */ }
  requirement def 'R6.6.0(8)' { doc /* A real-time clock must produce timestamps accurate to 10 ms. */ }
  part def 'Labeling of Nonfunctional Requirements Def';
  part 'Labeling of Nonfunctional Requirements' : 'Labeling of Nonfunctional Requirements Def';
  satisfy 'R3.4.0(1)' by 'Labeling of Nonfunctional Requirements';
  satisfy 'R3.4.0(2)' by 'Labeling of Nonfunctional Requirements';
  satisfy 'R3.4.0(3)' by 'Labeling of Nonfunctional Requirements';
  satisfy 'R3.4.0(4)' by 'Labeling of Nonfunctional Requirements';
  satisfy 'R6.8.0(4)' by 'Labeling of Nonfunctional Requirements';
  satisfy 'R7.6.0(2)' by 'Labeling of Nonfunctional Requirements';
  satisfy 'R7.3.0(7)' by 'Labeling of Nonfunctional Requirements';
  satisfy 'R7.3.0(8)' by 'Labeling of Nonfunctional Requirements';
  satisfy 'R7.3.0(9)' by 'Labeling of Nonfunctional Requirements';
  satisfy 'R7.3.0(10)' by 'Labeling of Nonfunctional Requirements';
  satisfy 'R7.3.0(11)' by 'Labeling of Nonfunctional Requirements';
  part def 'ICE Bus Adaptor Def';
  part 'ICE Bus Adaptor' : 'ICE Bus Adaptor Def';
  satisfy 'R6.4.0(1)' by 'ICE Bus Adaptor';
  satisfy 'R6.7.0(1)' by 'ICE Bus Adaptor';
  satisfy 'R6.7.0(2)' by 'ICE Bus Adaptor';
  satisfy 'R6.7.0(3)' by 'ICE Bus Adaptor';
  satisfy 'R6.7.0(4)' by 'ICE Bus Adaptor';
  satisfy 'R6.7.0(5)' by 'ICE Bus Adaptor';
  satisfy 'R8.3.0(3)' by 'ICE Bus Adaptor';
  part def 'Maintenance Processor Def';
  part 'Maintenance Processor' : 'Maintenance Processor Def';
  satisfy 'R8.3.0(1)' by 'Maintenance Processor';
  satisfy 'R8.3.0(2)' by 'Maintenance Processor';
  part def 'Power Supply Def';
  part 'Power Supply' : 'Power Supply Def';
  satisfy 'R7.3.0(6)' by 'Power Supply';
  part def 'Battery Def';
  part 'Battery' : 'Battery Def';
  part def 'Power Control Def';
  part 'Power Control' : 'Power Control Def';
  satisfy 'R7.3.0(6)' by 'Power Control';
  part def 'Control Panel Def';
  part 'Control Panel' : 'Control Panel Def';
  satisfy 'R6.4.0(1)' by 'Control Panel';
  satisfy 'R6.4.2(1)' by 'Control Panel';
  satisfy 'R6.4.2(2)' by 'Control Panel';
  satisfy 'R6.4.2(3)' by 'Control Panel';
  satisfy 'R6.4.2(4)' by 'Control Panel';
  satisfy 'R6.4.3(1)' by 'Control Panel';
  satisfy 'R6.4.3(2)' by 'Control Panel';
  satisfy 'R6.4.3(3)' by 'Control Panel';
  satisfy 'R6.5.0(2)' by 'Control Panel';
  satisfy 'R6.5.0(5)' by 'Control Panel';
  satisfy 'R6.5.0(7)' by 'Control Panel';
  satisfy 'R6.5.0(9)' by 'Control Panel';
  satisfy 'R6.5.0(11)' by 'Control Panel';
  satisfy 'R6.5.0(12)' by 'Control Panel';
  satisfy 'R6.5.0(13)' by 'Control Panel';
  satisfy 'R6.5.0(14)' by 'Control Panel';
  satisfy 'R6.5.0(15)' by 'Control Panel';
  satisfy 'R6.5.0(16)' by 'Control Panel';
  satisfy 'R6.5.0(17)' by 'Control Panel';
  satisfy 'R6.5.0(18)' by 'Control Panel';
  satisfy 'R6.5.0(19)' by 'Control Panel';
  satisfy 'R6.5.0(20)' by 'Control Panel';
  satisfy 'R6.5.0(21)' by 'Control Panel';
  satisfy 'R6.5.0(22)' by 'Control Panel';
  satisfy 'R6.5.0(23)' by 'Control Panel';
  satisfy 'R6.8.0(6)' by 'Control Panel';
  part def 'Rate Controller Thread Def';
  part 'Rate Controller Thread' : 'Rate Controller Thread Def';
  satisfy 'R5.1.0(1)' by 'Rate Controller Thread';
  satisfy 'R5.1.0(5)' by 'Rate Controller Thread';
  satisfy 'R5.2.0(2)' by 'Rate Controller Thread';
  satisfy 'R5.1.0(4)' by 'Rate Controller Thread';
  satisfy 'R5.2.0(6)' by 'Rate Controller Thread';
  satisfy 'R6.2.0(2)' by 'Rate Controller Thread';
  satisfy 'R6.5.0(3)' by 'Rate Controller Thread';
  satisfy 'R6.5.0(6)' by 'Rate Controller Thread';
  satisfy 'R7.5.0(2)' by 'Rate Controller Thread';
  part def 'Prescription Checker Thread Def';
  part 'Prescription Checker Thread' : 'Prescription Checker Thread Def';
  satisfy 'R5.2.0(4)' by 'Prescription Checker Thread';
  satisfy 'R6.3.0(1)' by 'Prescription Checker Thread';
  satisfy 'R6.5.0(10)' by 'Prescription Checker Thread';
  satisfy 'R6.5.0(9)' by 'Prescription Checker Thread';
  satisfy 'R6.8.0(6)' by 'Prescription Checker Thread';
  part def 'ICE Thread Def';
  part 'ICE Thread' : 'ICE Thread Def';
  satisfy 'R6.7.0(1)' by 'ICE Thread';
  satisfy 'R6.7.0(2)' by 'ICE Thread';
  satisfy 'R6.7.0(3)' by 'ICE Thread';
  satisfy 'R6.7.0(4)' by 'ICE Thread';
  satisfy 'R6.7.0(5)' by 'ICE Thread';
  satisfy 'R6.7.0(6)' by 'ICE Thread';
  satisfy 'R6.7.0(7)' by 'ICE Thread';
  part def 'Security Thread Def';
  part 'Security Thread' : 'Security Thread Def';
  satisfy 'R8.1.0(3)' by 'Security Thread';
  satisfy 'R8.1.0(4)' by 'Security Thread';
  part def 'Max Drug Per Hour Thread Def';
  part 'Max Drug Per Hour Thread' : 'Max Drug Per Hour Thread Def';
  satisfy 'R5.2.0(5)' by 'Max Drug Per Hour Thread';
  part def 'Patient Bolus Checker Def';
  part 'Patient Bolus Checker' : 'Patient Bolus Checker Def';
  satisfy 'R5.2.0(3)' by 'Patient Bolus Checker';
  part def 'Drug Library Thread Def';
  part 'Drug Library Thread' : 'Drug Library Thread Def';
  satisfy 'R6.8.0(8)' by 'Drug Library Thread';
  part def 'Event Logger Thread Def';
  part 'Event Logger Thread' : 'Event Logger Thread Def';
  part def 'Patient Button Def';
  part 'Patient Button' : 'Patient Button Def';
  satisfy 'R5.2.0(2)' by 'Patient Button';
  part def 'Scanner Def';
  part 'Scanner' : 'Scanner Def';
  satisfy 'R5.1.0(1)' by 'Scanner';
  satisfy 'R6.3.0(1)' by 'Scanner';
  satisfy 'R6.8.0(5)' by 'Scanner';
  satisfy 'R6.10.0(1)' by 'Scanner';
  satisfy 'R6.10.0(2)' by 'Scanner';
  satisfy 'R6.10.0(3)' by 'Scanner';
  part def 'Security Subsystem Def';
  part 'Security Subsystem' : 'Security Subsystem Def';
  satisfy 'R8.1.0(3)' by 'Security Subsystem';
  satisfy 'R8.1.0(4)' by 'Security Subsystem';
  satisfy 'R8.2.0(1)' by 'Security Subsystem';
  satisfy 'R8.3.0(3)' by 'Security Subsystem';
  satisfy 'R8.3.0(4)' by 'Security Subsystem';
  part def 'Fluid Subsystem Def';
  part 'Fluid Subsystem' : 'Fluid Subsystem Def';
  satisfy 'R7.6.0(1)' by 'Fluid Subsystem';
  part def 'Pump Def';
  part 'Pump' : 'Pump Def';
  satisfy 'R5.1.0(2)' by 'Pump';
  satisfy 'R5.1.0(3)' by 'Pump';
  satisfy 'R6.2.0(1)' by 'Pump';
  satisfy 'R6.2.0(2)' by 'Pump';
  satisfy 'R7.2.0(1)' by 'Pump';
  satisfy 'R7.2.0(2)' by 'Pump';
  satisfy 'R7.2.0(6)' by 'Pump';
  satisfy 'R6.2.0(3)' by 'Pump';
  part def 'Upstream Monitor Def';
  part 'Upstream Monitor' : 'Upstream Monitor Def';
  satisfy 'R6.1.0(1)' by 'Upstream Monitor';
  satisfy 'R6.1.0(3)' by 'Upstream Monitor';
  part def 'Downstream Monitor Def';
  part 'Downstream Monitor' : 'Downstream Monitor Def';
  satisfy 'R6.1.0(1)' by 'Downstream Monitor';
  satisfy 'R6.1.0(2)' by 'Downstream Monitor';
  satisfy 'R6.1.0(4)' by 'Downstream Monitor';
  part def 'Drug Reservoir Def';
  part 'Drug Reservoir' : 'Drug Reservoir Def';
  satisfy 'R6.8.0(1)' by 'Drug Reservoir';
  satisfy 'R6.8.0(2)' by 'Drug Reservoir';
  satisfy 'R6.8.0(3)' by 'Drug Reservoir';
  satisfy 'R7.2.0(7)' by 'Drug Reservoir';
  satisfy 'R7.5.0(1)' by 'Drug Reservoir';
  satisfy 'R7.5.0(3)' by 'Drug Reservoir';
  satisfy 'R7.5.0(4)' by 'Drug Reservoir';
  satisfy 'R7.2.0(8)' by 'Drug Reservoir';
  part def 'Safety Subsystem Def';
  part 'Safety Subsystem' : 'Safety Subsystem Def';
  satisfy 'R7.1.0(1)' by 'Safety Subsystem';
  part def 'Failure LED Def';
  part 'Failure LED' : 'Failure LED Def';
  satisfy 'R7.4.0(7)' by 'Failure LED';
  part def 'Alarm Thread Def';
  part 'Alarm Thread' : 'Alarm Thread Def';
  satisfy 'R6.4.0(1)' by 'Alarm Thread';
  satisfy 'R6.4.0(2)' by 'Alarm Thread';
  satisfy 'R6.4.0(3)' by 'Alarm Thread';
  satisfy 'R6.4.0(4)' by 'Alarm Thread';
  satisfy 'R6.4.0(5)' by 'Alarm Thread';
  satisfy 'R6.4.0(6)' by 'Alarm Thread';
  satisfy 'R7.2.0(3)' by 'Alarm Thread';
  satisfy 'R7.2.0(4)' by 'Alarm Thread';
  satisfy 'R7.2.0(5)' by 'Alarm Thread';
  satisfy 'R7.2.0(6)' by 'Alarm Thread';
  satisfy 'R7.2.0(7)' by 'Alarm Thread';
  part def 'Flow Rate Checker Def';
  part 'Flow Rate Checker' : 'Flow Rate Checker Def';
  satisfy 'R6.4.0(2)' by 'Flow Rate Checker';
  satisfy 'R6.4.0(3)' by 'Flow Rate Checker';
  satisfy 'R6.4.0(4)' by 'Flow Rate Checker';
  satisfy 'R6.4.0(5)' by 'Flow Rate Checker';
  satisfy 'R6.4.0(6)' by 'Flow Rate Checker';
  part def 'Error Detector Def';
  part 'Error Detector' : 'Error Detector Def';
  satisfy 'R7.4.0(1)' by 'Error Detector';
  satisfy 'R7.4.0(2)' by 'Error Detector';
  satisfy 'R7.4.0(3)' by 'Error Detector';
  satisfy 'R7.4.0(4)' by 'Error Detector';
  part def 'Fault Logger Def';
  part 'Fault Logger' : 'Fault Logger Def';
  satisfy 'R7.4.0(5)' by 'Fault Logger';
  satisfy 'R7.4.0(6)' by 'Fault Logger';
  satisfy 'R6.6.0(8)' by 'Fault Logger';
}