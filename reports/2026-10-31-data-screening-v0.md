# 데이터 스크리닝 보고서 v0 — 2026-10-31

목표: 공식 모델이 함께 공개된 실제 시스템 문서를 찾아, 사람 검토자 없이 모델–문서 정렬로 GT를 만들 수 있는지 확인한다(연구 계획 §5, 결정 ACCESS-005).

판정: **F Prime과 Open PCA Pump를 1차 후보로 채택한다. openETCS/Subset-026은 2차 후보로 둔다.** 모든 수치는 스크립트로 센 값이며 저자 표본 점검은 아직 하지 않았다.

## 1. 후보별 결과

### 1.1 NASA F Prime (SRC-FPRIME-001/002) — 다중 문서 묶음 실험군 1순위

- 확보: `github.com/nasa/fprime` 커밋 `15ebbf3d` (2026-10-29), Apache-2.0.
- 문서: SDD 123개(약 221K 토큰). 요구사항 표(ID·설명·검증 방법)와 포트 표(타입·이름·방향·종류·용도)를 모두 가진 Svc 컴포넌트 14개, 컴포넌트 요구사항 행 50개. 서브토폴로지 SDD 7개는 요구사항 표 + **추적 매트릭스(요구사항 ID → 인스턴스)** 를 가진다. `docs/reference/system-functional/*.md`에 같은 서브토폴로지의 산문 설명이 별도 파일로 존재한다.
- 모델: FPP 342개 파일. 컴포넌트 정의(포트·명령·이벤트·텔레메트리), 서브토폴로지(인스턴스·연결·토폴로지 포트).
- 정렬 검증: 14개 컴포넌트의 SDD 포트 표 64행 중 **60행이 FPP의 `port <name>` 선언과 이름으로 결정적으로 대응**한다(TlmPacketizer 3행, Health 1행 불일치 — 표본 점검 대상). CdhCore 추적 매트릭스 10행은 모두 `CdhCore.fpp`의 인스턴스 이름으로 해소된다.
- 결합 유형 적합성: A 할당(추적 매트릭스) 강, C 계층·동일성(폴더명 `CmdDispatcher` / FPP 타입 `CommandDispatcher` / 인스턴스 `cmdDisp` 별칭) 강, D 인터페이스(포트 표 ↔ FPP) 매우 강, B 제약은 약함(수치가 설정 상수로 분리됨: Health의 warning/fatal 임계값 등).
- 위험: GitHub에 널리 퍼진 코드라 모델 암기 가능성. 일부 SDD가 최근 유지보수자에 의해 재작성됨(동결 전 `git blame` 확인).

### 1.2 Open PCA Pump (SRC-OPENPCA-001/002) — 단일 장문 실험군 1순위

- 확보: 요구사항 문서 PDF 1.0.0(2018-03-30, 103쪽, 약 32K 토큰, SHA256 `1bf625f5…`), AADL zip(SHA256 `636dff74…`, 30개 .aadl). 문서는 CC BY-SA 3.0 명시, zip에는 라이선스 파일 없음.
- 문서 구조: 3장 개요 → 4장 사용/예외 사례 → 5~8장 기능·인터페이스·안전·보안 요구사항(각주로 `R6.5.0(1)` 식 ID 143개 정의) → **10장 기능 아키텍처**(33개 구성요소 제목 아래 "Allocated Requirements" 목록 167항목, 132개 고유).
- 모델: AADL에 요구사항 인용 65개가 주석으로 존재(`--R5.5.0(18) alert-stop-start sequence`). **65개 모두 문서 10장 할당 목록에 나타난다.**
- 발견된 자연 동일성 문제: 10장과 AADL은 `R5.x.y(n)`, 본문 각주는 `R6.x.y(n)`으로 **장 번호가 1 어긋난다**. 할당 167항목 중 본문 ID와 그대로 일치하는 것은 32개뿐이고, 장 번호 +1 이동 후 159개가 일치하며 그중 158개는 제목 문자열까지 동일하다. 요구사항 본문(§6.5, 61쪽)과 할당(§10.5.1, 82쪽) 사이 거리는 약 26K 토큰이다.
- 결합 유형 적합성: A(할당 목록), B(조건·기간·한계치 요구사항이 많음), C(ID 이동을 제목으로 해소해야 하는 동일성), D(6장 인터페이스 요구사항 ↔ AADL 포트·연결) 모두 해당.
- 위험: 규모가 작아 단독으로는 통계적 근거가 되지 못한다. AADL zip 버전이 문서 1.0.0과 동일 시점인지 미확인.

### 1.3 openETCS / UNISIG Subset-026 (SRC-OPENETCS-001/002) — 2차 후보

- 확보: `github.com/openETCS/modeling` 커밋 `b1b6dc66` (2017-03-03). Subset-026 v3.3.0 8개 장이 .doc와 ReqIF로 포함(3장만 spec object 3,767개, implement 플래그 2,534개). Papyrus SysML 5개 모델(openETCS_EVC 983 블록), SCADE 모델 다수.
- 정렬 검증: Papyrus .uml에 requirement/satisfy 요소가 없다(5개 모델 모두 0). SCADE `.trace` 파일 32개는 모두 비어 있다. 조항 번호는 SCADE 주석에 자유 텍스트로만 나타난다(모듈별 0~111개).
- 판정: 조건·시간·수량 제약(B)에는 가장 풍부한 자료지만, **공식 추적이 기계판독 형태로 없어** GT를 이름 기반으로 재구성해야 한다. 추적 내보내기(ReqIF gateway)를 찾기 전까지 2차 후보.
- 라이선스: 저장소 루트에 LICENSE 없음. 프로젝트 산출물은 EUPL로 알려져 있으나 재배포 전 확인 필요. Subset-026 원문은 ERA가 공개하나 재배포 조건 확인 필요.

### 1.4 조사했으나 보류

- AUTOSAR: 추적이 가장 명시적이나 이용 약관 확인 전까지 보류.
- Rubin Observatory LSE 문서: 이전 연구에서 조사한 자료. 재사용 시 결정 로그 기록 필요.
- CubeSat 계열(GU Orbit Capella 등): 요구사항 문서와 모델의 대응 여부 미확인.

## 2. 모델 암기 검사 v0 (ACCESS-007)

`scripts/memorization_probe.py`, 모델 `gpt-6.1-sol`, 문서 미제공. 네 개 프로브(F Prime CmdDispatcher 포트, CdhCore 인스턴스·요구사항, Open PCA `PCA_Control_Panel` 선언·인용 ID, Subset-026 §3.13.2.2.1~5 원문) 모두 **"모른다"로 응답**했다. 단, 프롬프트가 추측 대신 기권을 허용했으므로 이는 하한이다. 동결 전에 ①기권 금지 변형 ②두 번째 모델(claude-opus-5-5)로 재검사한다. 원본 응답: `experiments/outputs/memorization-probe-v0/`.

## 3. 양방향 정렬 GT 설계에 주는 함의

- F Prime: GT의 (가) 모델→문서는 포트 이름·인스턴스 이름·요구사항 ID 정규식으로 결정적. (나) 문서→모델은 SDD 절 번호 + 파일 경로로 기록. 입력에서 **추적 매트릭스와 포트 표는 제외**하고 산문(§1 소개, §3.2 기능 설명, system-functional 산문)만 주는 조건과, 표를 포함하는 조건을 분리 실험군으로 둔다.
- Open PCA: 10장 할당 목록은 GT로 쓰고 입력에서 제외한다. 본문 각주 ID와 AADL ID의 장 번호 이동은 GT 정렬 스크립트가 제목 일치로 해소하되, **이동 사실 자체를 평가 명제로 남긴다**(방법이 두 ID를 다른 요구사항으로 취급하면 오류, 제목 근거 없이 병합해도 오류).
- 저자 표본 점검 대상: F Prime 불일치 4행, Open PCA 이동 후에도 불일치 8항목·제목 불일치 1항목.

## 4. 미해결·다음 단계

1. F Prime 불일치 4행과 Open PCA 불일치 9항목을 저자가 점검하고 `data/reviews/`에 기록한다.
2. 암기 검사 ②(기권 금지, 두 모델)를 실행한다.
3. 정렬 스크립트(`scripts/align_fprime.py`, `scripts/align_openpca.py`)를 작성해 case-registry를 자동 생성하고, 현재 수기 후보 8건(CASE-FPRIME-001~004, CASE-OPENPCA-001~003, CASE-OPENETCS-001)과 대조한다.
4. 세 번째 이상 독립 프로젝트를 찾는다(의료·우주 외 도메인). AUTOSAR 약관과 openETCS 추적 내보내기 확인.
5. 위 결과로 규약 v0을 v1로 고쳐 파일럿 전에 동결한다.

## 부록: 실행 기록

- 클론: `data/sources/fprime/clone.log`, `data/sources/openetcs/clone-modeling.log` (openETCS/model 저장소는 존재하지 않아 실패, `modeling`으로 대체).
- 다운로드 해시: source-registry.csv 참조.
- 원본은 `data/sources/.gitignore`로 커밋 제외.
