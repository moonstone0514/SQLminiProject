/* 주의 사항
 * 단일 line 주석 작성시 -- 와 내용 사이에 blank 필수
 * 
 * step01 - 기본 검색
 * select 절
 * from 절
 * : select앤 검색 컬럼, from절 table명
 * 
 * step02 - 정렬 검색
 * 	select절 from절 order by절
 * order by절엔 어떤 컬럼을 내림?오름? 정렬값 설정
 * 
 * step03 - 조건 검색
 * 	select절
 * 	from절
 * 	where절
 * 
 * step04 - 조건 & 정렬 검색
 * 	select절
 * 	from절
 * 	where절
 * 	order by절
 * 
 * *** mysql의 특징
 * 	- 데이터값의 대소문자 구분을 기본으로 하지 않음
 * 	- 데이터는 대소문자 구분은 필수로 해야 함
 *  - mysql db선택시
 * 		해결책1 : tabel 생성후 alter로 대소문자 구분하게 설정
 * 		해결책2 : select시 binary() 사용해서 처리
 * 		
 * 
 */

select * FROM tab;



select * from emp;
select * from dept;


-- 1. 해당 계정이 사용 가능한 모든 table 검색
show tables;

-- 2. emp table의 모든 내용(모든 사원(row), 속성(컬럼)) 검색
select * from emp;

-- 3. emp의 구조 검색 , describe
--desc emp;

-- 4. emp의 사번(empno)만 검색
-- 정렬이 미적용된 문장
select empno from emp;

-- 오름차순 정렬
-- 오름차순 : asc / 내림차순 : desc
select empno from emp ORDER by empno asc;
select empno from emp ORDER by empno desc;

-- 5. emp의 사번(empno), 이름(ename)만 검색
-- 하나 이상의 컬럼 검색시, 표기가 구분
select empno, ename from emp;


-- 6. emp의 사번(empno), 이름(ename)만 검색(별칭 적용)
-- "as 별칭" 문법 적용 / 컬럼 안보여주도록
select empno  AS 사번, ename  AS "사원 명" from emp;
-- 여백이 포함된 별칭 사용 시 "" 표기로 하나의 문자열 의미
-- select empno as 사번, ename as "사원 명" from emp ;

-- 7. 부서 번호(deptno) 검색
select deptno from emp;

select deptno from dept; -- 데이터 파악

-- 8. 중복 제거된 부서 번호 검색 / distinct
select distinct deptno from emp;

-- 9. 8 + 오름차순 정렬(order by)해서 검색
-- 오름 차순 : asc  / 내림차순 : desc
select distinct deptno from emp order by deptno asc; -- 어떤 데이터를 기준으로 정렬 할건지
select distinct deptno from emp order by deptno desc;

-- 10. ? 사번(empno)과 이름(ename) 검색 단 사번은 내림차순(order by desc) 정렬
select empno, ename from emp order by empno desc;

-- 11. ? dept table의 deptno 값만 검색 단 오름차순(asc)으로 검색
-- 정렬시 반드시 order by 절로 처리
select deptno from dept; -- 정렬이 보장되지 않은 검색결과
select deptno from dept order by deptno asc;

-- 12. ? 입사일(hiredate) 검색, 
-- 입사일이 오래된 직원부터 검색되게 해 주세요(오름차순 의미)
-- 고려사항 : date 타입도 정렬(order by) 가능 여부 확인
-- 데이터 탐색용 단순 검색

select hiredate from emp;
-- desc emp;

select hiredate from emp order by hiredate asc;


-- 13. ?모든 사원의 이름과 월 급여(sal)와 연봉 검색
select ename, sal from emp;

select ename as 사원명, sal as 월급여, sal*12 as 연봉 FROM  emp;

-- 14. ?모든 사원의 이름과 월급여(sal)와 연봉(sal*12) 검색
-- 단 comm 도 고려(+comm) = 연봉(sal*12) + comm

-- 모든 사원의 이름과 월급여(sal)와 연봉(sal*12)+comm 검색
select ename, sal, sal*12 from emp;
-- 탐색용 sql 문장 진행 작업
select ename, sal, sal*12, comm from emp;

-- comm이 null인 사원들 연산 불가
select ename as 사원명, sal AS 월급여, sal*12 + comm AS 연봉 from emp;
-- 대안책 : null은 연산 불가, 대체해서 연산, 대체값 0으로 치환
select ename as 사원명, sal AS 월급여, (sal*12 + NVL(comm, 0)) AS 연봉 from emp;

-- *** 조건식 ***
-- 15. comm이 null인 사원들의 이름과 comm만 검색
-- where 절 : 조건식 의미
select ename, comm from emp;

select ename, comm from emp where comm is null;


-- 16. comm이 null이 아닌 사원들의 이름과 comm만 검색
-- where 절 : 조건식 의미
-- 아니다 라는 부정 연산자 : not 
select ename, comm from emp where comm is not null;

-- ?모든 직원명, comm으로 내림 차순 정렬
select ename, comm from emp order by comm desc;

-- null값 보유컬럼 오름차순 정렬인 경우 null 부터 검색 
select ename, comm from emp order by comm asc;

-- 17. ? 사원명이 smith인 사원의 이름과 사번만 검색
-- = : db에선 동등비교 연산자
-- 참고 : 자바에선  == 동등비교 연산자 / = 대입연산자
select ename from emp;
select empno, ename from emp;
select empno, ename from emp where ename = 'SMITH';


-- 18. 부서번호가 10번 부서의 직원들 이름(ename), 사번(empno), 부서번호(deptno) 검색
-- 단, 사번은 내림차순 검색
select ename, empno, deptno from emp;

-- 실행순서 : from -> where -> select -> order by
select ename, empno, deptno from emp where deptno = 10 order by empno desc;


-- 두문제 만들고 보내고 승인받고 대화 나누고 문제 풀이
-- 19. ? 기본 syntax를 기반으로 
-- emp  table 사용하면서 문제 만들기
-- 세금이 20%일 때, 세후 월급여가 2000이 넘는 사람의 이름과 사번, 세후 급여를 오름차순으로 출력
select ename as 이름, empno as 사번, sal as "세전 급여", (sal - sal*0.2) as "세후 급여" from emp where (sal - sal*0.2) >= 2000 order by sal asc;

-- 1981-06-01보다 빨리 태어난 사람만 출력



-- ?부서 번호(deptno)는 오름 차순(asc) 
-- 단 해당부서(deptno)에 속한 직원번호(empno)도 오름차순(asc) 정렬


-- 결과가 맞는 문장인지의 여부 확인을 위한 추가 문장 개발해 보기 


-- 20. 급여(sal)가 900(>=)이상인 사원들 이름, 사번, 급여 검색 
select sal from emp;

select ename, empno, sal from emp where sal >= 900;

-- 20. 이름으로 오름차순
select ename, empno, sal from emp where sal >= 900 order by ename asc; -- A, B, C 순서

-- 20번 + sal 오름차순 정렬
select ename, empno, sal from emp where sal >= 900 order by sal asc;

-- 20번 + sal 오름차순 + 이름은 내림차순
select ename, empno, sal from emp where sal >= 900 order by sal asc, ename desc; -- 급여로 오름차순하고 그 결과로 이름 내림차순

-- 21. deptno 10, job 은 manager(대문자로) 이름, 사번, deptno, job 검색
select job from emp;
select job from emp where job = 'manager';


-- ename은 대소문자 구분 설정을 alter 명령어로 사전 셋팅
-- 대소문자 구분

-- 검색 불가
select job from emp where job = 'manager';
-- 검색 성공
select job from emp where job = 'MANAGER';

-- 대문자 : upper / 소문자 : lower   / uppercase (대문자의미)
select job from emp where job = upper('MANAGER');



-- smith 소문자를 대문자로 변경해서 비교
select ename from emp;
select ename from emp where ename = upper('smith');

-- 22.? deptno가 10 아닌 직원들 사번, 부서번호만 검색
-- 부정연산자 not / != / <>
select empno, deptno from emp;
select empno, deptno from emp where not deptno = 10;
select empno, deptno from emp where deptno != 10;
select empno, deptno from emp where deptno <> 10;


-- 23. sal이 2000이하(sal <= 2000) 이거나(or) 3000이상(sal >= 3000)인 사원명, 급여 검색
select sal from emp where sal <= 2000 or sal >= 3000;

-- 24.  comm이 300 or 500 or 1400인

-- in 연산식 사용해서 좀더 개선된 코드
select comm from emp;
select empno, comm from emp where comm in (300, 500, 1400);

-- 25. ?  comm이 300 or 500 or 1400이 아닌 사원명 검색
-- null값 미포함!!!
select comm from emp;
select empno, comm from emp where comm not in (300, 500, 1400);

-- 26. 81/09/28 날 입사한 사원 이름.사번 검색
-- date 타입 비교 학습
-- date 타입은 '' 표현식 가능 
-- yy/mm/dd 포멧은 차후에 변경 예정(함수)
select hiredate from emp;
select hiredate from emp where hiredate = TO_DATE('81/09/28','YY/MM/DD'); -- 명시적으로 현재 빈 날짜는 현재 날짜를 기준으로 하게 됨
SELECT TO_DATE('81/09/28','YY/MM/DD') FROM emp; -- TO_DATE() 형식에 YYYY로 직접 넣지 않으면 localtime 기준으로 앞의 20년을 붙여 포멧한다

select hiredate from emp where hiredate = TO_DATE('1981/09/28', 'YYYY/MM/DD');
select hiredate from emp where hiredate = TO_DATE('1981-09-28','YYYY-MM-DD');
select hiredate from emp where hiredate = TO_DATE('1981-09-28','YY-MM-DD');

-- 27. 날짜 타입의 범위를 기준으로 검색
-- 범위비교시 연산자 : between~and 1980-12-17~1981-09-28
select hiredate from emp order by hiredate asc;

-- 적힌 날짜까지 포함 (포함 관계)
select hiredate from emp where hiredate between '1980-12-17' and '1981-09-28';


-- 28. 검색시 포함된 모든 데이터 검색하는 기술
-- 참고 : 실행속도는 낮음 / 빠른 검색이 중요할 경우 검색 기능은 검색 기능은 검색 엔진이 내장된 sw들 사용을 권장

-- 순수 sql문장으로 검색
-- like 연산자 사용
-- % : 철자 개수 무관하게 검색 / _ : 철자 개수 하나를 의미

-- 29. 두번째 음절의 단어가 M(_M) (1,2) 인 모든 사원명 검색 
-- M 다음 글?
select ename from emp;
select ename from emp where ename like '_M%';

-- 두개의 글자, 단, 두번째는 M이여야 함
select ename from emp where ename like '_M'; 

-- 30. 단어가 M을 포함한 모든 사원명 검색 
select ename from emp where ename like '%M%';

-- '%'는 뭐가 와든 됨


-- 세금이 20%일 때, 세후 월급여가 2000이 넘는 사람의 이름과 사번, 세후 급여를 오름차순으로 출력
select ename as 이름, empno as 사번, sal as "세전 급여", (sal - sal*0.2) as "세후 급여"
from emp
where (sal - sal*0.2) >= 2000 order by sal asc;
select * from emp;
-- 생일이 특정 요일인 사람만 조회
select * from emp where EXTRACT(MONTH FROM hiredate) < 7;
select * from emp where EXTRACT(MONTH FROM hiredate) > 7;
-- 월급 대비 커미션 비율
select ename as 이름, job as 직업, sal as 급여, comm/sal as "커미션 비울" from emp where comm is not null and comm/sal > 0.2;
-- 예시 2: 과세표준이 1억2천만원인 경우
-- 8,800만원 초과이므로 35% 구간 적용
-- 초과금액: 1억2천만원 - 8,800만원 = 3,200만원
-- 세금 = 1,536만원 + (3,200만원 × 0.35) =
--  → 1,536만원 + 1,120만원 = 2,656만원
SELECT ename AS 이름,
sal*12 + NVL(comm, 0) AS 연봉,
(sal*12 + NVL(comm, 0) - 8800) AS 초과금액,
(sal*12 + NVL(comm, 0) - 8800)*0.24 + 1536 AS 산출세액
FROM emp
WHERE sal*12+NVL(comm, 0) BETWEEN 8800 AND 15000;


