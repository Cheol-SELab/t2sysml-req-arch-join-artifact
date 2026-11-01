# 저자 표본 점검 v1 — supported 10% 무작위 표본 (규약 v1 §6)

추출: seed 20261031, Open PCA 16/160, F Prime 15/149. AI 사전 점검(Claude Code)은 원문 문자열 대조만 수행했다. **저자 확인: 박철영, 2026-10-31.** 원문 `requirements.txt`·PDF 65쪽(인쇄), F Prime SDD/FPP. 점검은 GT를 바꾸지 않는다.

## Open PCA

| gt_id | 구성요소 | 할당 인용 | 본문 ID | 본문 요구사항(앞 120자) | AI 사전 점검 | 저자 확인 |
|---|---|---|---|---|---|---|
| OPCA-085 | Patient Bolus Checker | R4.2.0(3) minimum time between patient-requested bolus | R5.2.0(3) | Patient-requested bolus shall not be delivered more often than a prescribed minimum time between patient-requested bolus | 제목이 본문 문장에 포함 | 일치 |
| OPCA-065 | Prescription Checker Thread | R5.3.0(1) device parameters | R6.3.0(1) | The PCA pump shall use a physician’s prescription as device parameters41. (UC1 §4.1.1 UC2 §4.1.2 UC3 §4.1.3) | 제목이 본문 문장에 포함 | 일치 |
| OPCA-103 | Security Subsystem | R7.1.0(2) patient authentication | R8.1.0(2) | Patient’s identity and admittance to the hospital must be authenticated. 157 (UC1.6 §4.1.1) | 제목 비포함(각주 제목과만 일치) | 일치. 본문 문장에 할당 제목 없음. 각주 157 표제어 patient authentication만 일치(R4). |
| OPCA-019 | Control Panel | R5.4.2(1) visual alarm signal | R6.4.2(1) | If a visual indicator is necessary for the clinician to identify the equipment or part of the equipment that requires cl | 제목이 본문 문장에 포함 | 일치 |
| OPCA-138 | Alarm Thread | R5.4.0(4) bolus over-infusion alarm | R6.4.0(4) | If delivered patient-requested bolus flow rate exceeds the prescribed patient-requested bolus rate setting by more than  | 제목이 본문 문장에 포함 | 일치 |
| OPCA-011 | Battery | R6.3.0(1) battery backup | R7.3.0(1) | The PCA pump shall continue to infuse for 10 minutes during interruption of mains electricity supply using battery backu | 제목이 본문 문장에 포함 | 일치 |
| OPCA-057 | Rate Controller Thread | R4.3.0(7) max dose warning | R5.3.0(7) | Clinician-commanded bolus shall be halted when continuing to infuse exceeds prescribed volume of drug infused over a per | 제목이 본문 문장에 포함 | 일치 |
| OPCA-068 | Prescription Checker Thread | R5.5.0(9) soft limit confirmation | R6.5.0(9) | Prescriptions that violate the soft limits of the drug in the drug library shall issue a visible and audible warning req | 제목이 본문 문장에 포함 | 일치 |
| OPCA-128 | Drug Reservoir | R5.8.0(10) empty-reservoir alarm | R6.8.0(10) | If the drug volume in the reservoir measures less than Vers =0.5 ml, and an infusion is in progress, an empty-reservoir  | 제목이 본문 문장에 포함 | 일치 |
| OPCA-060 | Rate Controller Thread | R5.5.0(6) stop infusion | R6.5.0(6) | Upon the clinician’s pressing of the stop button, stop infusion 67. (UC1.16 §4.1.1) | 제목이 본문 문장에 포함 | 일치 |
| OPCA-042 | Control Panel | R5.5.0(20) display of visual information | R6.5.0(20) | display of visual information 82, and (UC1.2 §4.1.1) | 제목이 본문 문장에 포함 | 일치 |
| OPCA-028 | Control Panel | R5.5.0(2) start button | R6.5.0(2) | The PCA pump shall have a start button 63. (UC1.14 §4.1.1 UC7.1 §4.1.7) | 제목이 본문 문장에 포함 | 일치 |
| OPCA-155 | Flow Rate Checker | R5.4.0(5) bolus under-infusion warning | R6.4.0(5) | If delivered patient-requested bolus flow rate is less than the prescribed bolus rate setting by more than its allowed t | 제목이 본문 문장에 포함 | 일치 |
| OPCA-159 | Error Detector | R6.4.0(2) periodic self-tests | R7.4.0(2) | The PCA pump shall perform periodic self-tests 143 to assure system integrity during long periods of use. Failure of a s | 제목이 본문 문장에 포함 | 일치 |
| OPCA-009 | Maintenance Processor | R7.3.0(2) protected jack | R8.3.0(2) | The provisioning jack must be physically inaccessible, except to authorized technical personnel.162 Jacks for test equip | 제목 비포함(각주 제목과만 일치) | 일치. 본문은 provisioning jack 접근 제한. 각주 162 표제어 protected jack만 할당 제목과 일치(R4). |
| OPCA-076 | ICE Thread | R5.7.0(4) ice kvo rate | R6.7.0(4) | The PCA pump shall switch to KVO infusion rate when commanded through its ICE interface.97 (UC4.4 §4.1.4) | 제목 비포함(각주 제목과만 일치) | 일치. 본문에 ice kvo rate 구 없음. 각주 97 표제어 ICE KVO rate(대소문자만 다름). |

## F Prime

| 유형 | 구성요소 | 대상 | 모델 근거 | 문서 근거 | AI 사전 점검 | 저자 확인 |
|---|---|---|---|---|---|---|
| A allocation | PrmDb | PRMDB-004 | Svc\PrmDb\PrmDb.fpp | Svc\PrmDb\docs\sdd.md:16 | 식별자 일치(스크립트) | 일치 |
| D interface | PassiveConsoleTextLogger | TextLogger | Svc\PassiveConsoleTextLogger\PassiveConsoleTextLogger.fpp:7 | Svc\PassiveConsoleTextLogger\docs\sdd.md:27 | 식별자 일치(스크립트) | 일치 |
| A allocation | TlmChan | TLC-004 | Svc\TlmChan\TlmChan.fpp | Svc\TlmChan\docs\sdd.md:19 | 식별자 일치(스크립트) | 일치 |
| D interface | CmdDispatcher | seqCmdStatus | Svc\CmdDispatcher\CmdDispatcher.fpp:21 | Svc\CmdDispatcher\docs\sdd.md:39 | 식별자 일치(스크립트) | 일치 |
| A allocation | DataProducts | SVC-DATAPRODUCTS-002 | Svc\Subtopologies\DataProducts\DataProducts.fpp:95 | Svc\Subtopologies\DataProducts\docs\sdd.md:113 | 식별자 일치(스크립트) | 일치 |
| A allocation | ActiveRateGroup | ARG-004 | Svc\ActiveRateGroup\ActiveRateGroup.fpp | Svc\ActiveRateGroup\docs\sdd.md:18 | 식별자 일치(스크립트) | 일치 |
| D interface | Health | Run | Svc\Health\Health.fpp:17 | Svc\Health\docs\sdd.md:39 | 식별자 일치(스크립트) | 일치 |
| D interface | PassiveRateGroup | RateGroupMemberOut | Svc\PassiveRateGroup\PassiveRateGroup.fpp:10 | Svc\PassiveRateGroup\docs\sdd.md:37 | 식별자 일치(스크립트) | 일치 |
| A allocation | CdhCore | SVC-CDHCORE-009 | Svc\Subtopologies\CdhCore\CdhCoreConfig\CdhCoreConfig.fpp | Svc\Subtopologies\CdhCore\docs\sdd.md:166 | 식별자 일치(스크립트) | 일치 |
| A allocation | Health | HTH-003 | Svc\Health\Health.fpp | Svc\Health\docs\sdd.md:15 | 식별자 일치(스크립트) | 일치 |
| A allocation | EventManager | AL-001 | Svc\EventManager\EventManager.fpp | Svc\EventManager\docs\sdd.md:15 | 식별자 일치(스크립트) | 일치 |
| A allocation | CmdDispatcher | CD-003 | Svc\CmdDispatcher\CmdDispatcher.fpp | Svc\CmdDispatcher\docs\sdd.md:15 | 식별자 일치(스크립트) | 일치 |
| A allocation | FileHandling | SVC-FILEHANDLING-003 | Svc\Subtopologies\FileHandling\FileHandling.fpp:67 | Svc\Subtopologies\FileHandling\docs\sdd.md:118 | 식별자 일치(스크립트) | 일치 |
| A allocation | ActiveRateGroup | ARG-002 | Svc\ActiveRateGroup\ActiveRateGroup.fpp | Svc\ActiveRateGroup\docs\sdd.md:16 | 식별자 일치(스크립트) | 일치 |
| D interface | PolyDb | getValue | Svc\PolyDb\PolyDb.fpp:7 | Svc\PolyDb\docs\sdd.md:34 | 식별자 일치(스크립트) | 일치 |
