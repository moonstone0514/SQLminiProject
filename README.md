## 👨‍💻Team
|<img src="https://avatars.githubusercontent.com/u/56614731?v=4" width="100" height="100"/>|<img src="https://avatars.githubusercontent.com/u/117507439?v=4" width="100" height="100"/>|<img src="https://avatars.githubusercontent.com/u/87272634?v=4" width="100" height="100"/>|
|:-:|:-:|:-:|
|[이용훈](https://github.com/dldydgns)|[김문석](https://github.com/moonstone0514)|[황지환](https://github.com/jihwan77)|<br/>[@](https://github.com/ddd)|


## 📊 SQL Examples

아래는 Oracle SQL 예제입니다.

<br>




<br></br>
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
