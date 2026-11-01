# Rubin 정답 점검 v1 — 검토자 원문 대조 결과 — 2026-10-31

대상: `2026-10-31-rubin-inspection-sheet-v1.csv` (GT `rubin-gt-v1.1`; not_established 35건 전부 + supported 116/1,152, seed 20261031; 생성 `scripts/make_rubin_inspection.py`).
점검자: 저자가 지정한 검토자. 성명·소속, 저자 여부: **미기재**(원고 표기 동의 회신 대기). 원문 LSE-61 v6.2·LDM-148 v8.1 PDF만 사용. 시트에 AI 사전 판정 없음.
검토자 판정을 저자가 대화로 전달했다(2026-10-31). 판정 열이 채워진 시트 파일은 아직 받지 않았다.

## 판정 (검토자 회신 원문 요지)

| 집합 | 결과 |
|---|---|
| 지지 표본 S001–S116 | 일치 115, 불일치 1 (S110) |
| 미확정 NE001–NE035 | 미확정 맞음 35, 연결 가능 0 |

- **S110 불일치.** LSE-61 PDF 84쪽 DMS-REQ-0158은 Specification이 없는 composite다. 시트의 Specification 문장은 자식 DMS-REQ-0306 Task Configuration의 것이다.
- **미확정 사유 확인.** 제목 불일치(24 hrs vs Specified Time 등): LSE-61에 ID는 있으나 제목이 달라 잇지 않음. 접미 ID(0336b 등): LDM-148 §15.2의 정확한 ID가 아님.
- **사유 문구 오류.** DMS-REQ-0155/0156 7건: LSE-61 PDF 80·82쪽에 ID와 제목이 있다. Specification 없는 상위 묶음이라 미확정은 유지. 시트 사유 "identifier not defined in LSE-61 v6.2"는 원문과 다르다.

## 처리 (ACCESS-057)

- 원인: `build_gt_rubin.py`의 정의 파서가 "ID:" 뒤 200자 안의 첫 Specification을 가져왔다. 0158은 자식 0306의 Specification이 200자 안에 있어 잘못 붙었고, 0155/0156은 200자 밖이라 정의 없음으로 기록됐다.
- 규칙 수정 → GT v1.2 (`v1.2` 옵션): 다음 "ID:"보다 뒤에 있는 Specification은 쓰지 않고, 그런 ID는 사유 "composite requirement without a Specification in LSE-61 v6.2"로 미확정. 전수 검사 결과 LSE-61의 composite는 0155·0156·0158 셋뿐이다.
- 변화: 1,187건 중 8건만 다름. 상태 변경 1건(RUBIN-1159, DMS-REQ-0158, supported → not_established), 사유 변경 7건. supported 1,152 → 1,151, not_established 35 → 36. Rubin-X(`rubin-x-gt-v1.2`)도 같은 8건. 모델 입력 문서는 바이트 단위로 동일. v1.1과 Rubin-X v1의 재생성은 동결 파일과 바이트 단위로 동일하다.
- 재채점(모델 호출 없음): 모든 full recall 변화 ≤ 0.001, 모든 사전 지정 대비의 부호와 구간 판정 불변. NE 연결 수는 0158을 출력한 팔에서 +0.3~1.0 증가(B0, M2R, M3; 이 팔들은 0158에 자식 문장을 붙여 냈다). 출력 `experiments/outputs/rubin-analysis-gt12.json`, `rubin-analysis-sens-gt12.json`, `rubin-x-analysis-gt12.json`, `rubin-x-joincost-gt12.json`.
- 점검 결과 지지 표본의 정밀도 추정: 115/116 (0.991).
