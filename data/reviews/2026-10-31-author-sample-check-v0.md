# 저자 표본 점검 v0 — 정렬 불일치 항목 — 2026-10-31

대상: 스크리닝 보고서(`reports/2026-10-31-data-screening-v0.md`)에서 스크립트 정렬이 실패한 항목 전부. **작성: Claude Code(AI)가 원문을 대조해 판정 초안을 작성했다. 저자 확인 완료(2026-10-31).** 박철영이 F1–F5·P1–P4에 동의했다. P2·P3 PDF 육안은 Peter(2026-10-31)와 일치한다. 독립 검토자 없음(ACCESS-005). 점검은 GT를 바꾸지 않는다. 불일치로 인한 GT v1.1은 없다.

판정 범주: `resolvable_by_rule`(정렬 규칙 보강으로 결정적 해소 가능) / `doc_model_drift`(문서와 모델이 실제로 다름) / `extraction_artifact`(PDF→텍스트 변환 문제) / `not_established`(원문에 근거 없음).

## 1. F Prime — SDD 포트 표 64행 중 미해소 4행

| # | 컴포넌트 | SDD 행 | FPP 실제 | 판정 | 근거·처리 | 저자 확인 |
|---|---|---|---|---|---|---|
| F1 | TlmPacketizer | `allocate` (Fw::BufferGet, Output) | `Svc/Interfaces/BufferAllocation.fpp` 5행 `output port allocate: Fw.BufferGet`; `TlmPacketizer.fpp` 74행 `import Svc.BufferAllocation` | resolvable_by_rule | 포트가 **임포트된 인터페이스**에 선언됨. 정렬 규칙에 `import <Interface>` 전개를 추가하면 해소. | 동의 |
| F2 | TlmPacketizer | `deallocate` (Fw::BufferSend, Output) | 같은 인터페이스 8행 | resolvable_by_rule | F1과 동일. | 동의 |
| F3 | TlmPacketizer | `pingIn / pingOut` (한 행에 두 포트) | `pingIn`, `pingOut` 각각 선언 | resolvable_by_rule | SDD 표 작성 관행(슬래시 병기). 셀을 `/`로 분리하면 2행 모두 일치. | 동의 |
| F4 | Health | `Wdog` (Svc::WatchDog, Output) | `Health.fpp` 20행 `output port WdogStroke: Svc.WatchDog` | **doc_model_drift** | 이름이 다르다(`Wdog` vs `WdogStroke`). 타입·방향은 일치. 어느 쪽이 갱신됐는지 shallow clone(깊이 1)으로는 확인 불가. GT에서는 포트 타입·방향 명제는 `supported`, 이름 동일성은 `not_established`로 분리 기록. | 동의 |
| F5 | FatalHandler | `FatalReceive` (Svc::Fatal, Input) | `FatalHandler.fpp` 7행 `sync input port FatalReceive: Svc.FatalEvent` | **doc_model_drift** | 포트 이름·방향은 일치. 타입 이름 `Svc::Fatal` vs `Svc.FatalEvent`. 타입 동일성은 `not_established`. | 동의 |

처리 후 기대 일치: 64행 중 63행(F4만 미해소).

## 2. Open PCA — 할당 목록 167항목 중 장 번호 이동 후 미해소 8항목 + 제목 불일치 1항목

| # | 할당 ID(10장) | 제목 | 본문 확인 | 판정 | 근거·처리 | 저자 확인 |
|---|---|---|---|---|---|---|
| P1 | R5.5.0(8) ×2 (§10.5.1 Control Panel 등) | prescription confirmation | §6.5 항목 **(8) "(removed)"**. "prescription confirmation"은 §6.8 각주 `R6.8.0(6)`에만 정의되며, 할당 목록도 `R5.8.0(6)`을 별도로 가짐 | **doc_model_drift** | 할당이 **삭제된 요구사항**을 가리킨다. ID 기준 `not_established`; 제목 기준으로 R6.8.0(6)과 같은 명제인지는 본문에 근거 없음 → 병합하지 않음. | 동의 |
| P2 | R5.9.0(5) ×3 | hard limit | §6.9 각주 `R6.9.0(1)~(4)`뿐. PDF 인쇄 -65-(파일 75쪽)에 (5) 없음. 표 6 열 이름은 ID가 아님 | not_established (ID 수준) | Peter 육안(2026-10-31): 각주 111–115만. 추출 누락 아님. | 동의 (Peter와 일치) |
| P3 | R5.9.0(6) ×3 | soft limit | P2와 동일. "soft limit"은 §6.5(9)·EC2에 서술되나 R6.9.0(6)은 없음 | not_established (ID 수준) | Peter 육안(2026-10-31): R6.9.0(6) 각주 없음. | 동의 (Peter와 일치) |
| P4 | R7.3.0(1) | "provisioning jack R7.3.0(2) protected jack" | 본문 각주 `R7.3.0(1) provisioning jack`, `R7.3.0(2) protected jack` 각각 존재 | extraction_artifact | PDF 텍스트 변환에서 두 항목이 한 줄로 합쳐짐. 정렬 스크립트에서 ID 토큰 재분할하면 두 항목 모두 제목 일치. | 동의 |

처리 후 기대: 167항목 중 ID 이동 규칙 + 토큰 재분할로 160항목 해소, 8항목(P1~P3, 중복 포함)은 `not_established`.

## 3. 장 번호 이동 규칙의 정당화

- 본문 각주 143개는 모두 해당 장 번호(3~8장)와 일치한다(`R6.5.0(n)`은 §6.5).
- 10장과 AADL의 `R5.5.0(n)`은 본문 어디에도 정의되지 않고, `+1` 이동 후 159/167이 ID·제목 모두 일치한다.
- 따라서 이동은 문서 작성 중 장 번호 재배열(1장 삽입)로 추정되며, **추정은 GT에 쓰지 않는다.** GT 정렬은 "이동 후 ID 일치 AND 제목 문자열 일치"의 두 조건을 모두 요구한다. 하나만 만족하면 `not_established`.

## 4. 남은 확인

- [x] F1·F2: `Svc/Interfaces/BufferAllocation.fpp`에 `allocate`/`deallocate` 선언. 저자 확인 **일치**(resolvable_by_rule).
- [x] F3: SDD `pingIn / pingOut` 병기. 저자 확인 **일치**(resolvable_by_rule).
- [x] F4: SDD `Wdog`, FPP `WdogStroke`, 타입 `Svc.WatchDog`. 저자 확인 **일치**(doc_model_drift). 전체 히스토리 변경 시점은 동결 커밋에서 미확인 → 이름 동일성은 계속 not_established.
- [x] F5: SDD `Svc::Fatal`, FPP `Svc.FatalEvent`. 저자 확인 **일치**(doc_model_drift).
- [x] P1: §6.5(8) `(removed)`. 저자 확인 **일치**(doc_model_drift).
- [x] P2·P3: 원본 PDF 65~66쪽 육안 확인. **없음.** 인쇄 **-65-**(파일 75쪽) §6.9 각주는 R6.9.0(1)–(4)만(111–115). R6.9.0(5)·R6.9.0(6) 각주 없음. 인쇄 **-66-**(파일 76쪽) 표 6에 hard/soft limit **열 이름**은 있으나 요구사항 ID가 아니다. 확인자 **Peter**, 2026-10-31. 저자 확인과 일치. 판정 열은 그대로 둠.
- [x] P4: 할당 목록 `R7.3.0(1) provisioning jack R7.3.0(2) protected jack` 한 줄. 본문 각주는 분리. 저자 확인 **일치**(extraction_artifact).
- [ ] Open PCA AADL zip 내부 날짜·버전 문자열 확인(문서 1.0.0과의 정합). 이번 표본 점검 범위 밖.

## 5. 2차 실행 — 정렬 스크립트 v0 적용 후 (`scripts/align_fprime.py`, `scripts/align_openpca.py`, 출력 `experiments/outputs/alignment-v0/`)

F Prime (규칙 보강: 인터페이스 import 전개, `module` 한정자 보정, 특수 포트·internal 포트 인식, 슬래시 병기 분리, 토폴로지 포트·Config 모듈을 만족 주체로 인정):
- D 인터페이스: 65행 중 **63 supported, 2 not_established** — F4 `Health.Wdog`(이름 drift)와 신규 **F5 `FatalHandler.FatalReceive` 타입: SDD `Svc::Fatal` vs FPP `Svc.FatalEvent`**(`Svc/Fatal/Fatal.fpp` 4행에 `port FatalEvent` 정의; `doc_model_drift`, 포트 이름·방향은 일치).
- A 할당: 95행 중 **86 supported, 9 not_established** — 모두 서브토폴로지 추적 매트릭스에서 "deployment-provided" 인스턴스를 가리키는 행(ComCcsds 3, ComFprime 3, DataProducts 1, DpCompression 1, FileHandling 1). 해당 fpp에 `instance` 선언이 없으므로 규칙상 미확정이 맞다.

Open PCA (토큰 재분할 적용): 할당 168항목 중 **160 supported(모두 +1 이동 + 제목 일치), 8 not_established**(P1~P3). AADL 인용 73개(정규식 보강으로 65→73), 할당 목록과 연결된 행 87. 본문–할당 거리: 최소 1,272 / 중앙값 6,814 / 최대 12,132 토큰.
