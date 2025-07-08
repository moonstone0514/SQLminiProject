



-- 해당 database 내에 존재하는 table들 검색
SELECT * FROM tab;


-- emp와 dept라는 table이 혹여 존재할 경우 삭제하는 명령어
drop table emp;
drop table dept;

-- dept table 생성
-- 한부서 표현 속성 : 부서번호(중복불허)/ 부서명 / 지역 
CREATE TABLE dept (
    deptno               number(4)  NOT NULL,
    dname                varchar2(20),
    loc                  varchar2(20),
    CONSTRAINT pk_dept PRIMARY KEY (deptno)
);
-- mysql에선 정상 실행, dbeaver 에서만 oracle db에 실행시 에러
-- 해결책 : 다른 tool에선 정상 실행
-- table 구조 확인 명령어
-- DESC dept;
SELECT * FROM dept;

/*사본 중복 불허, 검색 기준 데이터 - 기본 데이터
 * 	-기본 데이터(기본키값), primary key
 * 
 * number(7,2) : 숫자 전체 7자리, 단 정수 최대 5자리, 소수점이하 2자리
 * number(4) : 숫자 전체 4자리
 * 
 * empno == mgr 
 * deptno : dept table의 deptno에 종속적인 데이터
 */
CREATE TABLE emp (
    empno                number(4),
    ename                varchar2(20),
    job                  varchar2(20),
    mgr                  NUMBER(4),
    hiredate             date,
    sal                  number(7,2),
    comm                 number(7,2),
    deptno               NUMBER(4),
    CONSTRAINT pk_emp PRIMARY KEY (empno)
 );
 
SELECT * FROM emp;

/* emp의 deptno컬럼은 dept table의 deptno에 종속성 부여
 * 부서번호가 없는 부서에 속한 직원은 존재 불가(제약으로 설정)
 * 
 * DDL : Data Define Language
 * 
 * ALERT : 이미 존재하는 table의 구조 변경 명령어
 * create : table생성
 * drop table : 이미 존재하는 table 영구 삭제
 * 
 * 
 * 
 * 
 * 주종 관계(부모 자식 관계) : 주 - dept / 종 - emp
 * 결론 : dept에 존재하는 deptno값에 한해서만 emp의 deptno에 저장 가능
 */
ALTER TABLE emp 
ADD CONSTRAINT fk_emp_dept 
FOREIGN KEY (deptno)
REFERENCES dept(deptno);
-- ON DELETE NO ACTION ON UPDATE NO ACTION;

 -- alter table emp change ename ename varchar(20) binary;


-- 존재하는 table에 데이터 저장
insert into dept values(10, 'ACCOUNTING', 'NEW YORK');
insert into dept values(20, 'RESEARCH', 'DALLAS');
insert into dept values(30, 'SALES', 'CHICAGO');
insert into dept values(40, 'OPERATIONS', 'BOSTON');

-- dept table의 모든 데이터 검색
SELECT * FROM dept;
  
-- db는 자체적으로 데이터를 쉽게 가공가능하게 다양한 내장 함수들 제공

--insert into emp values(7839, 'KING', 'PRESIDENT', null, '1981-11-17', 5000, null, 10);
--insert into emp values(7698, 'BLAKE', 'MANAGER', 7839, '1-5-1981', 2850, null, 30);
--insert into emp values(7782, 'CLARK', 'MANAGER', 7839, '9-6-1981', 2450, null, 10);
--insert into emp values(7566, 'JONES', 'MANAGER', 7839, '2-4-1981', 2975, null, 20);
--insert into emp values(7788, 'SCOTT', 'ANALYST', 7566, '13-7-1987', 3000, null, 20);
--insert into emp values(7902, 'FORD', 'ANALYST', 7566, '3-12-1981', 3000, null, 20);
--insert into emp values(7369, 'SMITH', 'CLERK', 7902, '17-12-1980', 800, null, 20);
--insert into emp values(7499, 'ALLEN', 'SALESMAN', 7698, '20-2-1981', 1600, 300, 30);
--insert into emp values( 7521, 'WARD', 'SALESMAN', 7698, '22-2-1981', 1250, 500, 30);
--insert into emp values( 7654, 'MARTIN', 'SALESMAN', 7698, '28-09-1981', 1250, 1400, 30);
--insert into emp values( 7844, 'TURNER', 'SALESMAN', 7698, '8-9-1981', 1500, 0, 30);
--insert into emp values( 7876, 'ADAMS', 'CLERK', 7788, '13-7-1987', 1100, null, 20);
--insert into emp values( 7900, 'JAMES', 'CLERK', 7698, '3-12-1981', 950, null, 30);
--insert into emp values( 7934, 'MILLER', 'CLERK', 7782, '23-1-1982', 1300, null, 10);

INSERT INTO emp VALUES (7839, 'KING', 'PRESIDENT', NULL, TO_DATE('1981-11-17', 'YYYY-MM-DD'), 5000, NULL, 10);
INSERT INTO emp VALUES (7698, 'BLAKE', 'MANAGER', 7839, TO_DATE('01-05-1981', 'DD-MM-YYYY'), 2850, NULL, 30);
INSERT INTO emp VALUES (7782, 'CLARK', 'MANAGER', 7839, TO_DATE('09-06-1981', 'DD-MM-YYYY'), 2450, NULL, 10);
INSERT INTO emp VALUES (7566, 'JONES', 'MANAGER', 7839, TO_DATE('02-04-1981', 'DD-MM-YYYY'), 2975, NULL, 20);
INSERT INTO emp VALUES (7788, 'SCOTT', 'ANALYST', 7566, TO_DATE('13-07-1987', 'DD-MM-YYYY'), 3000, NULL, 20);
INSERT INTO emp VALUES (7902, 'FORD', 'ANALYST', 7566, TO_DATE('03-12-1981', 'DD-MM-YYYY'), 3000, NULL, 20);
INSERT INTO emp VALUES (7369, 'SMITH', 'CLERK', 7902, TO_DATE('17-12-1980', 'DD-MM-YYYY'), 800, NULL, 20);
INSERT INTO emp VALUES (7499, 'ALLEN', 'SALESMAN', 7698, TO_DATE('20-02-1981', 'DD-MM-YYYY'), 1600, 300, 30);
INSERT INTO emp VALUES (7521, 'WARD', 'SALESMAN', 7698, TO_DATE('22-02-1981', 'DD-MM-YYYY'), 1250, 500, 30);
INSERT INTO emp VALUES (7654, 'MARTIN', 'SALESMAN', 7698, TO_DATE('28-09-1981', 'DD-MM-YYYY'), 1250, 1400, 30);
INSERT INTO emp VALUES (7844, 'TURNER', 'SALESMAN', 7698, TO_DATE('08-09-1981', 'DD-MM-YYYY'), 1500, 0, 30);
INSERT INTO emp VALUES (7876, 'ADAMS', 'CLERK', 7788, TO_DATE('13-07-1987', 'DD-MM-YYYY'), 1100, NULL, 20);
INSERT INTO emp VALUES (7900, 'JAMES', 'CLERK', 7698, TO_DATE('03-12-1981', 'DD-MM-YYYY'), 950, NULL, 30);
INSERT INTO emp VALUES (7934, 'MILLER', 'CLERK', 7782, TO_DATE('23-01-1982', 'DD-MM-YYYY'), 1300, NULL, 10);


-- 영구 저장   
commit;

SELECT * from emp;

select * from dept;
