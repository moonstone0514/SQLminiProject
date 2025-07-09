
|<img src="https://avatars.githubusercontent.com/u/56614731?v=4" width="100" height="100"/>|<img src="https://avatars.githubusercontent.com/u/117507439?v=4" width="100" height="100"/>|<img src="https://avatars.githubusercontent.com/u/188286798?v=4" width="100" height="100"/>|
|:-:|:-:|:-:|
|[이용훈](https://github.com/dldydgns)|[김문석](https://github.com/moonstone0514)|[황지환](https://github.com/jihwan77)|

<br>

## 📌 1. 개요

SQL 실습을 하면서 MySQL과 Oracle의 차이점을 비교해보고자 했다.  

<br>

## 📝 2. 기획

- **계기**  
  연봉, 세전/세후 급여를 계산하며 실무와 가까운 SQL을 연습하고 싶었음.

- **목표**
  - 입사일 기준 상/하반기 직원 분류
  - 월급과 커미션 비율 조회
  - 세금 적용 후 급여 계산
  - 연봉 기준 과세표준 구간별 세액 계산

- **사용 DB**  
  - MySQL  
  - Oracle

---

## 🧩 3. 설계

- SQL 쿼리를 플랫폼별로 처리(MySQL / Oracle)
- 필요한 항목에 alias 적용해 가독성 향상
- 계산식, 조건, 형식 등 명확히 구분해서 정리
- 과세표준 구간 로직을 예제와 함께 문서화

---

## ⚙️ 4. 개발

### 📅 상·하반기 입사자 조회
```sql
-- MySQL
SELECT * FROM emp WHERE MONTH(hiredate) < 7; -- 상반기
SELECT * FROM emp WHERE MONTH(hiredate) > 6; -- 하반기

-- Oracle
SELECT * FROM emp WHERE EXTRACT(MONTH FROM hiredate) < 7;
SELECT * FROM emp WHERE EXTRACT(MONTH FROM hiredate) > 6;
````

### 💼 커미션 비율이 20% 이상인 직원

```sql
SELECT
  ename AS 이름,
  sal AS 급여,
  comm / sal AS "커미션 비율"
FROM emp
WHERE comm IS NOT NULL AND comm / sal > 0.2;
```

### 💰 세후 급여가 2000 이상인 직원 (세율 20%)

```sql
SELECT 
  ename AS 이름,
  sal AS "세전 급여",
  sal * 0.8 AS "세후 급여"
FROM emp
WHERE sal * 0.8 >= 2000;
```

### 🧾 연봉 8800\~15000 구간의 산출세액 계산

```sql
-- MySQL
SELECT
  ename AS 이름,
  sal * 12 + IFNULL(comm, 0) AS 연봉,
  (sal * 12 + IFNULL(comm, 0) - 8800) AS 초과금액,
  (sal * 12 + IFNULL(comm, 0) - 8800) * 0.35 + 1536 AS 산출세액
FROM emp
WHERE sal * 12 + IFNULL(comm, 0) BETWEEN 8800 AND 15000;

-- Oracle
SELECT
  ename AS 이름,
  sal * 12 + NVL(comm, 0) AS 연봉,
  (sal * 12 + NVL(comm, 0) - 8800) AS 초과금액,
  (sal * 12 + NVL(comm, 0) - 8800) * 0.35 + 1536 AS 산출세액
FROM emp
WHERE sal * 12 + NVL(comm, 0) BETWEEN 8800 AND 15000;
```

---

## 🏗️ 5. MySQL vs Oracle

| 항목      | MySQL                   | Oracle                                      |   |              |
| ------- | ----------------------- | ------------------------------------------- | - | ------------ |
| 입사월 추출  | `MONTH(hiredate)`       | `EXTRACT(MONTH FROM hiredate)`              |   |              |
| null 처리 | `IFNULL(comm, 0)`       | `NVL(comm, 0)`                              |   |              |
| 날짜 비교   | `'YYYY-MM-DD'` 직접 비교 가능 | `TO_DATE('1981/09/28', 'YYYY/MM/DD')` 사용 필요 |   |              |


---

## 🛠️ 6. 트러블슈팅

### ❌ 문제

```sql
SELECT hiredate FROM emp
WHERE hiredate = TO_DATE('81/09/28','YY/MM/DD');
```

→ 결과 없음

### 🎯 원인

* `'YY'`는 현재 세기 기준으로 처리됨 → `2081년`으로 인식

### ✅ 해결

```sql
SELECT * FROM emp
WHERE hiredate = TO_DATE('1981/09/28','YYYY/MM/DD');
```
