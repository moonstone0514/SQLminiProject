/* rdbms
*1. 정교한 데이터 저장 및 관리 솔루션
*2. 소통 언어 : sql
*3. 용어 
*		컬럼(속성) : 데이터(하나 하나의 데이터 의미)
*		row : 가로 행의 구조를 의미
*				사원 table의 경우 한 사람의 모든 정보를 하나의 row
*		레코드 : row 또는, 속성값 하나 자체를 레코드라고 함 (조각 조각)
*		
*
*/
-- mysql 용 문장
-- fisa라는 이름의 database내부에 진입해서 crud + ddl
/* crud(dml) : 존재하는 table에 작업
 * ddl : table 생성, 삭제, 구조 변경
 * 
 */
use fisa;

-- 테이블 명에서 대소문자는 구분 필수
-- 소문자명의 emp table 검색
SELECT * FROM emp; -- fisa 내부에서만 허용
select * from fisa.emp; -- fisa database외부에서도 검색

-- 대문자명의 emp table 검색 
-- select * from EMP;

-- 모든 table 검색
show tables;

