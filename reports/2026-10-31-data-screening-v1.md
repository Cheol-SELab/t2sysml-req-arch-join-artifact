# 데이터 스크리닝 보고서 v1 — 2026-10-31

v0(`2026-10-31-data-screening-v0.md`) 이후 ①~⑤를 수행한 결과. 수치는 스크립트 출력이며 저자 점검 기록은 `data/reviews/2026-10-31-author-sample-check-v0.md`.

## 판정

- **Open PCA Pump가 1차 시험 자료다.** 정렬 160/168 supported, 모델 암기 0/5·0/31.
- **F Prime은 개발·파일럿 자료로 내린다.** 정렬은 가장 깨끗하나(D 63/65, A 86/95) 두 모델이 FPP 포트·인스턴스를 문서 없이 재현한다(7/8, 4/4, 8/8).
- openETCS/Subset-026과 ALISA Isolette+FAA REMH는 2차 후보. AUTOSAR는 라이선스로 제외.
- 규약 v1을 동결했다(`protocol/annotation-v1.txt`, 해시 `data/frozen/protocol-v1.sha256`).

## ① 불일치 표본 점검

| 항목 | 판정 | 처리 |
|---|---|---|
| F Prime TlmPacketizer `allocate`/`deallocate` | resolvable_by_rule | `import Svc.BufferAllocation` 전개 → 해소 |
| F Prime TlmPacketizer `pingIn / pingOut` | resolvable_by_rule | 병기 분리 → 해소 |
| F Prime Health `Wdog` vs FPP `WdogStroke` | doc_model_drift | 타입·방향 supported, 이름 동일성 not_established |
| F Prime FatalHandler `Svc::Fatal` vs `Svc.FatalEvent` (2차에서 발견) | doc_model_drift | 위와 같이 분리 |
| Open PCA R5.5.0(8) prescription confirmation | doc_model_drift | 본문 (8) "(removed)" → not_established |
| Open PCA R5.9.0(5)/(6) hard/soft limit | not_established | §6.9 각주 (5)(6) 없음; 원본 PDF 육안 확인 대기 |
| Open PCA R7.3.0(1) 제목 불일치 | extraction_artifact | ID 토큰 재분할 → 해소 |

## ② 암기 검사 v2 (기권 금지, gpt-6.1-sol + claude-opus-5-5)

| 프로브 | 공식 항목 | gpt-6.1-sol | claude-opus-5-5 |
|---|---|---|---|
| F Prime CommandDispatcher 일반 포트 | 8 | 7 정확 (+7 특수 포트를 다른 이름으로) | 7 정확 (+7 특수 포트) |
| F Prime Health 일반 포트 | 4 | 4 | 4 |
| F Prime CdhCore 인스턴스 | 8 | 3 | **8** |
| Open PCA `PCA_Control_Panel` 구성요소 | 5 | 0 | 0 |
| Open PCA §10.5.1 할당 목록 | 31 | 0 | 0 |
| Subset-026 §3.13.2.2.x 원문 | — | 거부 | 명시적 패러프레이즈, 어휘 겹침 0 |

Open PCA 요구사항 ID 적중(2/29, 5/29)은 `R5.5.0(1),(2),…` 연번 열거로 설명되므로 재현으로 세지 않는다. CdhCore 파일은 2025-06~09에 생성됐는데도 재현되었다(GitHub API 커밋 날짜).

함의: F Prime으로 측정한 성능은 암기와 분리되지 않는다. F Prime은 파이프라인 개발과 파일럿(추출·통합·렌더링 오류, 비용)에 쓰고 본 실험 시험 집합에서는 제외한다.

## ③ 정렬 스크립트 결과 (`experiments/outputs/alignment-v0/`)

- `fprime_claims.csv` 160행: D 인터페이스 63 supported / 2 not_established; A 할당 86 / 9(모두 deployment-provided 인스턴스).
- `openpca_claims.csv` 168+행: A 할당(+C 동일성) 160 supported / 8 not_established; AADL 인용 73개 중 할당 목록 연결 87행; 본문–할당 거리 중앙값 6,814 토큰(최소 1,272, 최대 12,132).
- 수기 후보 8건(`data/case-registry.csv`)과의 대조: CASE-FPRIME-001/003/004, CASE-OPENPCA-001은 자동 결과에 포함된다. CASE-FPRIME-002(B 제약), CASE-OPENPCA-002(B)·003(D)은 현 스크립트가 다루지 않는 유형이라 수기로 남는다.

## ④ 세 번째 프로젝트 탐색

- AUTOSAR: 파트너십 회원 또는 서면 라이선스 필요, 복제 금지 → 제외(ACCESS-012).
- openETCS: 모듈별 `.rqtf`와 `.etp`가 ReqIF 파일을 참조하지만 요소 수준 링크는 저장소에 없다(RM 게이트웨이 데이터 미포함). 2차 유지.
- **ALISA Isolette(SEI, AADL+ReqSpec) + FAA REMH(DOT/FAA/AR-08/32, 146쪽, REQ-id 55개)**: 세 번째 도메인 후보로 추가. ReqSpec 100개 요구사항 중 41개가 `for <feature>`로 명시 할당되고 설명문에 수치 제약이 있다. 단 ID 체계가 핸드북과 다르고 ALISA 모델이 핸드북을 "FAA REMHB"로 주석에서만 인용하므로 정렬은 텍스트 기반이 된다. 2차.

세 번째 1차 자료는 아직 없다. 후속 탐색 방향: Open PCA처럼 **문서 안에 할당 절이 있는 단일 장문** 또는 모델에 요구사항 ID 주석이 있는 소규모 공개 프로젝트(의료·우주 외).

## ⑤ 규약 v1 동결

정렬 규칙 R1~R6, 암기 입장 조건(50% 임계), 저자 표본 점검(not_established 전수 + supported 10%)을 `protocol/annotation-v1.txt`로 고정했다. 변경은 v2와 결정 로그로만 한다.

## 미해결

- Open PCA §6.9 각주 (5)(6) 육안 확인; AADL zip(2018-02~04 파일 날짜) 라이선스 명시 요청.
- F Prime `Wdog`/`Fatal` drift의 이력 확인(전체 clone 필요).
- B·D 유형 자동 정렬(수치 제약 ↔ 모델 파라미터, 포트 방향 ↔ 인터페이스 요구사항)은 미구현.
- 세 번째 1차 프로젝트 미확보.
