## 👨‍💻Team
|<img src="https://avatars.githubusercontent.com/u/56614731?v=4" width="100" height="100"/>|<img src="https://avatars.githubusercontent.com/u/117507439?v=4" width="100" height="100"/>|<img src="https://avatars.githubusercontent.com/u/188286798?v=4" width="100" height="100"/>|
|:-:|:-:|:-:|
|[이용훈](https://github.com/dldydgns)|[김문석](https://github.com/moonstone0514)|[황지환](https://github.com/jihwan77)|<br/>[@](https://github.com/ddd)|

<br></br>
## 📊 1. 기획

- 계기 :
      주어진 데이터 셋으로 실제 국가에서 걷는 구간별 세금 적용 비율을 이해하고, 이를 적용시켜서
      세후 얼마의 급여를 받게 되는지 알고 싶어짐. 

  
- 주요 목표:
    - 입사일이 상반기, 하반기인 직원을 조회
    - 월급과 커미션 비율을 측정
    - 세금 적용 후 급여 산출
    - 과세표준 구간별 세액 계산

- 사용 DB:
    - MySQL
    - Oracle

<br>

## 🧩 2. 설계

- SQL 쿼리를 플랫폼별로 처리(MySQL / Oracle)
- 급여, 커미션, 세금 로직 명확히 구분
- 조건에 맞는 데이터 선별 및 가공
- 결과 데이터를 쉽게 검토할 수 있도록 alias 지정:
  - `이름`
  - `사번`
  - `세전 급여`
  - `세후 급여`
  - `커미션 비율`
  - `연봉`
  - `초과금액`
  - `산출세액`
- 과세표준 구간 로직을 예제와 함께 문서화


## ⚙️ 3. 개발


### 📅 생일(입사일)이 특정 월에 해당하는 직원 조회


```
-- @MySQL
-- 7월 이전 입사자
SELECT *
FROM emp
WHERE MONTH(hiredate) < 7;

-- 7월 이후 입사자
SELECT *
FROM emp
WHERE MONTH(hiredate) > 7;

-- @ORACLE
-- 7월 이전 입사자
SELECT *
FROM emp
WHERE EXTRACT(MONTH FROM hiredate) < 7;

-- 7월 이후 입사자
SELECT *
FROM emp
WHERE EXTRACT(MONTH FROM hiredate) > 7;
```
<br></br>


### 💼 월급 대비 커미션 비율이 20% 이상인 직원 조회
```
SELECT
  ename AS 이름,
  job AS 직업,
  sal AS 급여,
  comm / sal AS "커미션 비율"
FROM emp
WHERE comm IS NOT NULL
  AND comm / sal > 0.2;
  ```
<br></br>


### 💰 세금이 20%일 때 세후 월급여가 2000 이상인 직원 조회

```sql
SELECT 
  ename AS 이름,
  empno AS 사번,
  sal AS "세전 급여",
  (sal - sal * 0.2) AS "세후 급여"
FROM emp
WHERE (sal - sal * 0.2) >= 2000
ORDER BY sal ASC;
```


###  과세표준 8000만원 ~ 1억 2천만원 구간인 직원 조회

>과세표준기본세율(단위 만원)<br>
>5,000 ~ 8,800 -> 624만원 + (5,000만원 초과금액의 24%)<br>
>8,800 ~ 15,000 -> 1,536만원 + (8,800만원 초과금액의 35%)<br>
>15,001 ~ 30,000 -> 3,706만원 + (1억5천만원 초과금액의 38%)

###  🧾 과세표준 계산 예시

과세표준이 1억 2천만원인 경우:

8,800만원 초과 구간 (35% 세율) 적용

초과금액: 1억2천 - 8,800만원 = 3,200만원 

산출세액 = 1,536만원 + (3,200만원 × 0.35) = 2,656만원

```
-- @MYSQL
SELECT
  ename AS 이름,
  sal * 12 + IFNULL(comm, 0) AS 연봉,
  (sal * 12 + IFNULL(comm, 0) - 8800) AS 초과금액,
  (sal * 12 + IFNULL(comm, 0) - 8800) * 0.35 + 1536 AS 산출세액
FROM emp
WHERE sal * 12 + IFNULL(comm, 0) BETWEEN 8800 AND 15000;

-- @ORACLE
SELECT
  ename AS 이름,
  sal * 12 + NVL(comm, 0) AS 연봉,
  (sal * 12 + NVL(comm, 0) - 8800) AS 초과금액,
  (sal * 12 + NVL(comm, 0) - 8800) * 0.35 + 1536 AS 산출세액
FROM emp
WHERE sal * 12 + NVL(comm, 0) BETWEEN 8800 AND 15000;

```

## 🏗️ MySQL vs Oracle



## 📌 트러블 슈팅

### 문제 상황
다음 SQL을 실행했을 때, 기대했던 결과가 나오지 않음:

```
SELECT hiredate
FROM emp
WHERE hiredate = TO_DATE('81/09/28','YY/MM/DD');
```
hiredate에 1981-09-28이 저장되어 있음.


결과 행이 출력되지 않음.

### 🎯 원인 분석
TO_DATE() 함수의 연도 포맷(YY) 처리 방식 때문.

YY는 현재 세기의 2자리 연도를 나타냄:

81 → 2081년으로 해석됨.

따라서 조건이 아래와 같아짐:


WHERE hiredate = DATE '2081-09-28'
hiredate 값이 1981년이므로 비교 결과 불일치.

### ✅ 해결 방법
연도 포맷을 정확하게 지정해야 함.

아래 방법 중 하나를 사용:

1️⃣ YYYY (4자리 연도)

SELECT hiredate
FROM emp
WHERE hiredate = TO_DATE('1981/09/28','YYYY/MM/DD');
→ 1981년으로 정확히 인식.

---

