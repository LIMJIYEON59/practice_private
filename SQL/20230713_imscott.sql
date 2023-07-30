--DISTINCT:중복 열 제거
SELECT DISTINCT DEPTNO --DEPTNO:부서 번호
FROM EMP;

SELECT JOB, DEPTNO --JOB:사원 직책
FROM EMP;

--연간 총 수입을 구해라(급여*12+추가수당). => SAL:급여 *12개월 + COMM:추가 수당
SELECT ENAME, SAL "급여" , SAL*12 "연봉", SAL*12+COMM "연간 총 수입" , COMM
FROM EMP;

SELECT *
FROM EMP
ORDER BY SAL; --기본 값인 ASC:오름차순

SELECT *
FROM EMP
ORDER BY EMPNO; --EMPNO:사원번호, 사원 번호 기준 오름차순이 되도록

-- 내림차순으로 사원번호 정렬
SELECT * 
FROM EMP
ORDER BY EMPNO DESC; 

--오름차순 내림차순 동시에 지정 가능
--전체 열을 부서 번호(오름차순)와 급여(내림차순)로 정렬하기
SELECT *
FROM EMP
ORDER BY DEPTNO ASC, SAL DESC;

SELECT DISTINCT JOB
FROM EMP;

--부서 번호를 기준으로 내림차순으로 정렬하되 부서 번호가 같다면 사원 이름을 기준으로 오름차순 정렬합니다.
SELECT EMPNO EMPLOYEE_NO, 
       ENAME EMPLOYEE_NAME,
       MGR MANAGER,
       SAL SALARY,
       COMM COMMISSION,
       DEPTNO DEPARTMENT_NO
FROM EMP
ORDER BY DEPTNO DESC, EMPNO ASC;

-- 부서번호가 30인 데이터만 출력하기 => WHERE 조건절을 사용한다.
SELECT *
FROM EMP
WHERE DEPTNO = 30;

-- 사원 번호가 7782인 것만 구하라 (SCOTT에서 사원번호는 EMPNO이다.)
SELECT *
FROM EMP
WHERE EMPNO = 7782;

--사원 번호가 7499이고 부서 번호가 30인 사원 정보 (두 개의 정보를 알고싶다.)
SELECT *
FROM EMP
WHERE EMPNO =7499 AND DEPTNO = 30;

-- OR 연산자 사용.
SELECT *
FROM EMP
WHERE DEPTNO = 30 
    OR JOB = 'CLERK';

-- 부서 번호가 20이거나 직업이 SALESMAN인 사원 정보만 나오게 해라
SELECT *
FROM EMP
WHERE DEPTNO = 20 
    OR JOB = 'SALESMAN';

--WHERE절 조건식 개수는 상관이 없다.

-- <산술 연산자>
-- 급여 열에 12를 곱한 값이 36000인 행을 출력
SELECT *
FROM EMP
WHERE SAL*12 = 36000;

-- <비교 연산자>
-- 대소비교
-- 급여가 3000 이상인 사원을 조회 (이상이면 >=)
SELECT *
FROM EMP
WHERE SAL >= 3000;

--급여가 2500 이상이고 직업이 ANLYST인 사원 정보
SELECT *
FROM EMP
WHERE SAL >=2500 AND JOB = 'ANALYST';

-- 대문자 F를 비교 했을 때 F와 같거나 F보다 뒤에 있는 거
SELECT *
FROM EMP
WHERE ENAME >= 'F';

--<등가 비교 연산자>
SELECT *
FROM EMP
WHERE SAL != 3000;

SELECT *
FROM EMP
WHERE SAL <> 3000;

SELECT*
FROM EMP
WHERE SAL ^= 3000;

--<NOT 연산자(논리 부정 연산자)>
-- 정반대의 결과를 얻고싶을 때 유용하게 쓰인다.
SELECT *
FROM EMP
WHERE NOT SAL= 3000;

-- OR 연산자를 사용하여 원하는 값만 얻기
SELECT *
FROM EMP
WHERE JOB = 'MANAGER'
    OR JOB ='SALESMAN'
    OR JOB ='CLERK';

-- OR 연산자는 계속해서 조건식을 써야 하지만 IN은 ()안에 다 때려넣으면 된다.
-- IN 연산자를 사용하여 출력하기 
SELECT *
FROM EMP
WHERE JOB IN('MANAGER','SALESMAN','CLERK');

-- 모두 반대인 값 출력 (AND 연산자 이용)
SELECT *
FROM EMP
WHERE JOB != 'MANAGER'
    AND JOB <>'SALESMAN'
    AND JOB ^='CLERK';

-- NOT IN 연산자 이용
SELECT *
FROM EMP
WHERE JOB  NOT IN('MANAGER','SALESMAN','CLERK');

-- 부서 번호 10,20만 조회
SELECT *
FROM EMP
WHERE DEPTNO IN(10,20);

-- 최소,최고 범위를 지정하여 그 값만 출력 => BETWEEN A AND B
SELECT *
FROM EMP
WHERE SAL BETWEEN 2000 AND 3000; 

--<LIKE 연산자>
-- % : 이 뒤에 몇 개가 오든지 상관없다.
SELECT *
FROM EMP
WHERE ENAME LIKE 'S%'; --S로 시작ㅎ는 사원 이름을 보여달라.

-- 사원 이름의 두 번째가 L인걸 찾기
SELECT *  FROM EMP WHERE ENAME LIKE '_L%';

-- 사원 이름에 AM이 포함되어 있는 사원 데이터만 출력
SELECT *  FROM EMP WHERE ENAME LIKE '%AM%';

-- 사원 이름에 AM이 포함되어 있지 않은 사원 데이터 출력하기
SELECT *  FROM EMP WHERE ENAME NOT LIKE '%AM%';

-- IS NULL을 사용하여 NULL값 출력하기
SELECT * FROM EMP WHERE COMM IS NULL;

-- IS NOT NULL을 사용하여 NULL값은 출력 안한다.
SELECT * FROM EMP WHERE MGR IS NOT NULL;

-- AND는 둘 다 값을 만족해야 하고
-- OR은 하나의 값만 만족하면 된다.
SELECT * 
FROM EMP 
WHERE SAL > NULL
OR COMM IS NULL;

-- <집합 연산자> 
-- UNION:합집합(중복 제거), UNION ALL:합집합(중복 포함), MINUS:차집합, INTERSECT: 교집합
-- 집합 연산자(UNION) : 두 개 이상의 SELECT 문의 결과 값을 연결
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10
UNION
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 20;
-- 주의점: 열의 개수와 자료형을 맞춰줘야 한다.
-- 열을 쓴 순서대로 출력된다.

--UNION:합집합 중복 제거, UNION ALL:합집합, 중복 포함

--UNION 출력 결과가 같을 때
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10
UNION
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10;

--MINUS: 차집합
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
UNION
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10; --10번 부서에 있는 사원 데이터를 제외

-- INTERSECT: 교집합, 같은 데이터만 출력됨
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
INTERSECT
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10;

--Q문제
-- S로 끝나는 사원 이름(ENAME)
SELECT *
FROM EMP
WHERE ENAME LIKE '%S';

-- 
SELECT *
FROM EMP
WHERE DEPTNO = 30 AND JOB = 'SALESMAN';

--20 30에 근무하고 있는 사원 중 급여가 2000 초과인 사원을 구하라
--IN 연산자를 사용하여 20,30 부서번호를 구하고 둘 다의 값을 구해야 하니 AND를 사용한다.
-- 2000 초과이니 > 사용
SELECT *
FROM EMP
WHERE DEPTNO IN(20,30)
AND SAL > 2000;

-- 급여 값이 2000이상 3000이하의 값만 출력해라
SELECT *
FROM EMP
WHERE SAL > 2000 AND SAL < 3000;

-- 사원 이름에 E가 포함되어 있는 30번 부서의 사원 중 급여가 1000~2000 사이가 아닌 걸 출력
-- 사잇값이 아닌걸 구해야하니 NOT 하고 BETWEEN AND를 써준다.
SELECT *
FROM EMP
WHERE DEPTNO = 30 
AND ENAME LIKE '%E%'
AND SAL NOT BETWEEN 1000 AND 2000;

-- 20, 30번 부서에 근무하고 있는 사원 중 급여가 2000초과( > )
-- 집합연산자를 사용하지 않은 방식
SELECT *
FROM EMP
WHERE DEPTNO IN(20,30)
AND SAL > 2000;

--집합연산자 사용
--1. INTERSECT: 교집합, 공통적인 속성
SELECT *
FROM EMP
INTERSECT
SELECT *
FROM EMP
WHERE DEPTNO IN(20,30) AND SAL > 2000; --조건식을 아래 다 넣어버림

--2. UNION:합집합(중복 제거)
SELECT *
FROM EMP
WHERE DEPTNO = 20 AND SAL > 2000
UNION 
SELECT *
FROM EMP
WHERE DEPTNO = 30 AND SAL > 2000;

-- NOT BETWEEN A ANB B 연산자를 쓰지 않고 급여가 2000 이상 3000이하 범위 이외의 값을 출력
-- 즉 2000이상 3000이하의 범위에 속한 값 제외 나머지.
SELECT * 
  FROM EMP
 WHERE SAL < 2000 -- 2000이하
    OR SAL > 3000; -- 3000이상
    
-- 사원 이름에 E 포함 30번 부서의 사원 중 급여가 1000~2000 사이가 아닌 사원을 구하라.
-- BETWEEN A AND B: 최소 최고 범위를 구함 NOT을 앞에 붙이면 그 값이 아닌 걸 구한다.
SELECT *
FROM EMP
WHERE ENAME LIKE '%E%' 
AND DEPTNO = 30 
AND SAL NOT BETWEEN 1000 AND 2000; -- BETWEEN 1000 AND 2000: 1000~2000 사이가 아닌걸 알려달라.

-- 추가 수당이 존재하지 않음 상급자가 있고 직책이 M,C인 사원 중 사원 이름의 두 번째 글자가 L이 아닌 사원정보 출력
SELECT *
FROM EMP
WHERE COMM IS NULL -- 추가 수당이 존재하지 않는다고 했으니 IS NULL 이다 존재한다면 IS NOT NULL이다. 
AND MGR IS NOT NULL --굳이 안 써도 됨 (상급자가 있다는 소리)
AND JOB IN('MANAGER','CLERK')
AND ENAME NOT LIKE '_L%'; -- 두 번째 글자가 L이 아니라고 했으니 LIKE 앞에 NOT을 붙여줌

-- <대.소문자를 바꿔주는> UPPER(모두 대문자), LOWER(모두 소문자), INITCAT(첫 글자만 대문자, 나머지 소문자)
SELECT ENAME, UPPER(ENAME),LOWER(ENAME),INITCAP(ENAME)
FROM EMP;

-- 대.소문자 상관없이 SCOOTT인 사람 찾기
SELECT *
FROM EMP
WHERE UPPER(ENAME) = UPPER('SCOTT');

-- 사원 이름에 SCOTT 단어를 포함한 데이터 찾기
SELECT *
FROM EMP
WHERE UPPER(ENAME) LIKE UPPER('%SCOTT%'); --대문자인 사원이름에 SCOTT이 포함되는걸 찾는데 대문자!

-- 사원 이름이 대문자
SELECT UPPER(ENAME) --단순 출력이니(조건이X) WHERE절을 안 써도된다.
FROM EMP;

-- <문자열 길이를 구한다.>
SELECT ENAME, LENGTH(ENAME) --사원 이름의, 길이를(사원이름) 구하겠다.
FROM EMP;

-- 사원 이름의 길이가 5 이상인 행 출력
SELECT ENAME, LENGTH(ENAME)
FROM EMP
WHERE LENGTH(ENAME) >= 5;

-- LENGTHB: 바이트 수를 반환
SELECT LENGTH('한글'),LENGTHB('한글')
FROM DUAL; --DUAL:단일 결과만 확인할 때 사용함

-- <SUBSTR:문자열 일부를 추출>
--(1,2): 첫번째 글자(포함)부터 두 글자
SELECT JOB, SUBSTR(JOB, 1, 2), SUBSTR(JOB, 3, 2), SUBSTR(JOB, 5)
FROM EMP;

-- SUBSTR 사용하여 모든 사원 이름을 세 번째 글자부터 끝까지 출력
SELECT ENAME, SUBSTR(ENAME, 3) --앞에 한 개만 쓰면 그 글자부터 전부 다 출력된다.
FROM EMP;

-- SUBSTR(문자열 일부 추출), LENGTH(길이)
-- <음수>
SELECT JOB, 
    SUBSTR(JOB, -LENGTH(JOB)),  --전체 다 출력
    SUBSTR(JOB, -LENGTH(JOB), 2), --앞에 두 글자만
    SUBSTR(JOB, -3) --3번째 글자부터 출력
FROM EMP;

--<INSTR>:특정 문자 찾기
SELECT INSTR('HELLO, ORACLE!', 'L') AS INSTR_1, --INSTR('기준되는 문자', '찾을 글자', 몇번 째부터?)
       INSTR('HELLO, ORACLE!', 'L', 5) AS INSTR_2,
       INSTR('HELLO, ORACLE', 'L', 2,2) AS INSTR_3 --2번째 글자부터 2번째의 L을 찾겠다.
FROM DUAL;

-- INSTR 함수로 사원 이름에 문자 S가 있는 행 구하기
SELECT *
FROM EMP
WHERE INSTR(ENAME, 'S') > 0; -- INSTR 결과 값이 0보다 크다면 사원 이름에 S가 존재한다.

-- LIKE로 사원 이름에 문자 S가 있는 행 구하기
SELECT *
FROM EMP
WHERE ENAME LIKE '%S%';

-- <REPLACE>:특정 문자를 다른 문자로 바꿈
SELECT '010-1234-5678' AS REPLACE_BEFORE,
        REPLACE('010-1234-3333', '-', ' ') AS PREPLACE_1, --  전번 기준 '-'이걸 ' '이렇게 바꾸겠다.(띄어씀)
        REPLACE('010-1234-3333', '-') AS REPLACE_2 -- 대체할 문자를 지정하지 않아 '-'문자가 삭제된 채 출력됨
FROM DUAL;

-- <빈 공간을 특정 문자로 채운다. LPAD,RPAD>
-- LPAD:왼쪽에 빈 공간에 문자를 채워넣음, RPAD는 오른쪽
SELECT 'ORACLE',
    LPAD('ORACLE', 10, '#') AS LPAD_1,
    RPAD('ORACLE', 10, '*') AS RPAD_1,
    LPAD('ORACLE', 10) AS LPAD_2,
    LPAD('ORACLE', 10) AS RPAD_2 -- 기준 글자에서 10글자를 출력할건데 빈 공간에 아무것도 안 넣겠다.
FROM DUAL;

-- RPAD를 이용하여 개인정보 뒷자리 *표시 (오른쪽에 빈 공간 채워넣음)
SELECT RPAD('990426-', 14, '*') AS RPAD_JMNO
FROM DUAL;

-- <CONCAT>: 두 문자열 데이터를 합친다.
-- 두 열 사이에 콜론(:)을 넣고 연결하기
SELECT CONCAT(EMPNO, ENAME), --CONCAT(A,B): 두 개를 연결 시켜서 나타냄
        CONCAT(EMPNO, CONCAT(' : ', ENAME)) -- 사이에 : 이걸 넣어서 연결 시키고자 CONCAT안에 CONCAT넣기
FROM EMP
WHERE ENAME = 'SCOTT'; --조건식을 정해서 위에 것들 중에서 ENAME이 SCOTT인 것만 나타나도록 함

-- 문자열 데이터를 연결하는 || 연산자 (CONCAT함수와 유사)
SELECT EMPNO || ENAME, EMPNO || ' : ' || ENAME
FROM EMP
WHERE ENAME = 'SCOTT';

-- <특정 문자를 지운다.TRIM, LTRIM, RTRIM>, LEADING:왼쪽 글자 지움, TRADING:오른쪽 글자 지움, BOTH:양쪽
SELECT '[' || TRIM(' _Oracle_ ') || ']' AS TRIM,
 '[' || LTRIM(' _Oracle_ ') || ']' AS LTRIM,
 '[' || LTRIM('<_Oracle_>', '_<') || ']' AS LTRIM_2,
 '[' || RTRIM(' _Oracle_ ') || ']' AS RTRIM,
 '[' || RTRIM('<_Oracle_>', '>_') || ']' AS RTRIM_2
 FROM DUAL;

--ROUND 함수 사용하여 날짜 데이터 출력 -156P
SELECT SYSDATE, --오늘 날짜
ROUND(SYSDATE, 'CC') AS FORMAT_CC, -- 전체 초기화
ROUND(SYSDATE, 'YYYY') AS FORMAT_YYYY, --내년 초기화
ROUND(SYSDATE, 'Q') AS FORMAT_Q, --이번년도 초기화
ROUND(SYSDATE, 'DDD') AS FORMAT_DDD, --다음날
ROUND(SYSDATE, 'HH') AS FORMAT_HH --오늘
FROM DUAL;

-- TRUNC 함수 사용하여 날짜 데이터 출력
SELECT SYSDATE, 
    TRUNC(SYSDATE, 'CC') AS FORMAT_CC,
    TRUNC(SYSDATE, 'YYY') AS FORMAT_YYYY
    FROM DUAL;

-- <자료형을 변환하는 형 변환 함수> -157P
-- 숫자와 문자열(숫자)을 더하여 출력
SELECT EMPNO, ENAME, EMPNO + '500' -- 사원번호에 500을 더한 값을 나타낼 것이다.
FROM EMP
WHERE ENAME = 'SCOTT'; -- 이름의 이름은 SCOTT으로 나타낼 것이다

-- 문자열(문자)와 숫자를 더하여 출력 => 오류 뜸
SELECT 'ABCD' + EMPNO, EMPNO
FROM EMP
WHERE ENAME = 'SCOTT';

--TO_CHAR: 날짜,숫자를 문자로 바꾼다.
-- 현재 날짜와 시간을 '연/월/일 시:분:초' 형태로 출력
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD') AS "현재 날짜"
FROM DUAL;

-- 월과 요일을 다양한 형식으로 출력하기
SELECT SYSDATE,
    TO_CHAR(SYSDATE, 'MM') AS MM, --MM:월(2자리 숫자)
    TO_CHAR(SYSDATE, 'MON') AS MON, --MON(0월, 월 이름 약자)
    TO_CHAR(SYSDATE, 'MONTH') AS MONTH --MONTH(0월, 월 이름 전체)
    FROM DUAL;

-- <NULL 처리 함수> 167P 
-- 데이터가 NULL이면 산술 연산자나 비교 연산자가 동작X
-- 그래서 NULL이 아닌 다른 값으로 대체 해줘야 한다 => NVL 함수와 NVL2 함수 사용

-- NVL 함수를 사용하여 출력하기
-- COMM: 급여 외 추가수당(보너스)
SELECT EMPNO, ENAME, SAL, COMM, SAL+COMM, --SAL+COMM하면 NULL의 값이 그냥 나와버림
    NVL(COMM,0), --COMM의 값이 NULL일 경우 0으로 대체 즉,NVL이라는 함수로 컬럼을 묶는다.
    SAL+NVL(COMM,0) AS 총수입
    -- 급여+보너스를 구하는건데 보너스의 값이 NULL일 경우 0으로 바꿔서 나타내준다.
FROM EMP;

-- NVL2 :NULL과 비슷하지만 NULL이 아닐때 반환할 데이터를 추가로 지정 가능
-- NVL2([NULL인지 여부 검사할 데이터 또는 열], [NULL이 아닐! 경우 반환 데이터 또는 계산식]
        --, [NULL일! 경우 반환 데이터 또는 계산식])
-- 즉, NULL이 아닐 경우와 NULL일 때 각각 다르게 결과를 냄
-- 예) COMM이 NULL이 아니라면 O, NULL이라면 X (존재 여부만 확인할 때 사용, 민감한 정보 노출X)

SELECT EMPNO, ENAME, COMM,
    NVL2(COMM, 'O', 'X'),
    NVL2(COMM, SAL*12+COMM, SAL*12) AS ANNSAL
FROM EMP;
-- 총수입액이면(SAL*12+COMM) 'O' 
-- 연봉이면(SAL*12) 'X'

--<상황에 따른 다른 데이터를 반환하는 DECODE 함수와 CASE문>
-- DECODE: 기준 데이터 지정 후 해당 데이터 값에 따라 다른 결과 값을 내보낸다.

-- DECODE([검사 대상이 될 열], [조건1], [데이터가 조건1과 일치할 경우 반환할 결과],
--                            [조건2], [데이터가 조건2과 일치할 경우 반환할 결과],
--                              [조건N], [데이터가 조건N과 일치할 경우 반환할 결과],
--                              [위 조건 모두와 비교해 아무것도 일치하지 않을 시 ,,,])

-- EMP테이블에서 직책이 MANAGER인 사람은 급여의 10%를 인상한 급여, SALESMAN인 사람은  급여의 5%,
    -- ANALYST인 사람은 그대로, 나머지는 3%만큼 인상된 급여를 구하여라
SELECT EMPNO, ENAME, JOB, SAL, --SELECT절에 DECODE 쓰기
    DECODE (JOB,
            'MANAGER' , SAL*1.1, 
            'SALESMAN', SAL*0.05,
            'ANALYST' , SAL,
            SAL*1.03) AS UPSAL
        FROM EMP;

-- CASE문을 사용하여 출력하기
SELECT EMPNO, ENAME, JOB, SAL,
    CASE JOB
        WHEN 'MANAGER' THEN SAL*1.1  --CASE는 쉼표 구분이 필요없다.
        WHEN 'SALESMAN' THEN SAL*1.05
        WHEN 'ANALYST' THEN SAL
        ELSE SAL*1.03
    END AS UPSAL
    FROM EMP;
    
-- COMM열 값에 따라서 출력 값이 달라지는 CASE문
-- COMM의 열 값이 NULL, COMM의 값이 0일 때 COMM 열 값이 0을 초과 시 각각 다른 값을 반환함
SELECT EMPNO, ENAME, COMM, 
    CASE 
        WHEN COMM IS NULL THEN '해당사항 없음' -- COMM의 값이 NULL일 때
        WHEN COMM = 0 THEN '수당없음'
        WHEN COMM > 0 THEN '수당 : ' || COMM
    END AS COMM_TEXT
    FROM EMP;

-- Q문제 
SELECT EMPNO, MASKING_MENPNO, ENAME, MASKING_ENAME
FROM EMP
WHERE ENAME LIKE '_____%';


-- <다중행 함수>: 여러 행을 바탕으로 하나의 결과 값을 도출 
-- 그래서 SELECT절에 여러 행의 결과가 나올 수 있는 열을 같이 사용 불가

-- SUM 함수를 사용하여 급여 합게 사용하기
-- SAL들을 다 더한 값=>(하나의 행으로 출력됨)
SELECT SUM(SAL) 
FROM EMP;

-- 여러 행 출력
SELECT SAL 
FROM EMP;

-- 여러 행의 결과가 나올 수 있음 =>오류: 단일 그룹의 그룹 함수가 아닙니다.
SELECT ENAME, SUM(SAL)
FROM EMP;

-- Q6.01 EMPNO 열에는 EMP 테이블에서 사원 이름(ENAME)이 다섯 글자 이상이며 여섯 글자 미만인 사원 
        --정보를 출력합니다. MASKING_EMPNO 열에는 사원 번호(EMPNO) 앞 두 자리 외 뒷자리를 
        -- * 기호로 출력합니다. 그리고 MASKING_ENAME 열에는 사원 이름의 첫 글자만 보여 주고 
        -- 나머지 글자 수만큼 * 기호로 출력하세요.
SELECT EMPNO, ENAME,
    -- SUBSTR로 번호의 1번째(7)부터 2번째만 추출함, 4개의 길이 중 출출한 2번째를 제외한 나머지를 *처리
    RPAD(SUBSTR(EMPNO, 1, 2), 4, '*')  AS MASKING_EMPNO,
    RPAD(SUBSTR(ENAME, 1, 1), LENGTH(ENAME), '*') AS MASKING_ENAME
    --LENGTH:문자의 길이를 알려주는데 이걸 추가하게되면 길이를 지정하지 않아도 그 값대로 *값이 넣어짐
FROM EMP
    WHERE LENGTH(ENAME) >= 5
    AND
    LENGTH(ENAME) < 6;

-- Q6.02 EMP 테이블에서 사원들의 월 평균 근무일 수는 21.5일입니다. 하루 근무 시간을 8시간으로 보았을 때
       --사원들의 하루 급여(DAY_PAY)와 시급(TIME_PAY)을 계산하여 결과를 출력합니다. 
       --단 하루 급여는 소수점 세 번째 자리에서 버리고, 시급은 두 번째 소수점에서 반올림하세요.
SELECT EMPNO, ENAME, SAL,
    --한 달 급여가 SAL이니 그걸 일한 만큼 나누면 하루 급여가 됨
    TRUNC(SAL / 21.5, 2) AS DAY_PAY, --소수점을 버린다:TRUNC
    ROUND(SAL / 21.5 / 8, 1) AS TIME_PAY -- 반올림:ROUND
FROM EMP;

    
-- Q6.03 EMP, 사원들은 입사일(HIREDATE)을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다. 
    --사원들이 정직원이 되는 날짜(R_JOB)를 YYYY-MM-DD 형식으로 출력 단, 추가 수당(COMM)이 없는
    --사원의 추가 수당은 N/A로 출력하세요.

SELECT EMPNO, ENAME, HIREDATE,
    TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3),'월요일'), 'YYYY/MM/DD') AS R_JOB,
    NVL(TO_CHAR(COMM), 'N/A') AS COMM
   FROM EMP; 

-- Q6.04 EMP 테이블의 모든 사원을 대상으로 직속 상관의 사원 번호 (MGR)를 다음과 같은 조건을 기준으로 
    --변환해서 CHG_MGR 열에 출력하세요.
-- CASE WHEN 조건1 THEN 결과1 ELSE 아니라면 END 별칭
-- SUBSTR:문자열 중 일부를 추출
-- MGR: 직속 상관의 사원 번호
SELECT EMPNO, ENAME, MGR,
    CASE 
        WHEN MGR IS NULL THEN '0000'
        --직속 상관의 사원 번호 앞 두 자리가 75일 경우:5555
        -- 사원 번호 앞 두 자리를 추출해내야함
        WHEN SUBSTR(MGR, 1, 2) = '75' THEN '5555'
        WHEN SUBSTR(MGR, 1, 2) = '76' THEN '6666'
        WHEN SUBSTR(MGR, 1, 2) = '77' THEN '7777'
        WHEN SUBSTR(MGR, 1, 2) = '78' THEN '8888'
    -- 본래 직속 상관의 사원 번호 그대로 출력
    -- TO_CHAR: 숫자나 날짜를 문자로 바꾼다.
    ELSE TO_CHAR(MGR)
    END AS CHG_MGR
FROM EMP;  
    
-- <SUM 함수>를 사용하여 급여 합계 출력하기 177P
SELECT SUM(SAL) --합계를 구한다(뭐를? 급여를)
FROM EMP; -- 하나의 행으로 출력이된다

-- 추가수당 합계 구하기
SELECT SUM(COMM)
FROM EMP;
    
-- 급여 합계 구하기(DISTINCT, ALL 사용)
SELECT SUM(DISTINCT SAL),
        SUM(ALL SAL), 
        SUM(SAL)
FROM EMP;

-- EMP 테이블의 모든 사원들에 대해서 급여와 추가 수당의 합계를 구하도록 해라
SELECT SUM(ALL SAL), SUM(COMM)
FROM EMP;

-- 데이터의 개수를 구해 주는 COUNT 함수 
-- EMP 테이블의 데이터 개수 출력하기
SELECT COUNT(*)
FROM EMP;

-- 부서 번호가 30번인 직원 수 구하기
SELECT COUNT(*) -- 인원수를 구하겠다
FROM EMP
WHERE DEPTNO = '30'; --조건식, 부서번호 30번인 직원 수

-- <COUNT 함수>를 사용하기 급여 개수 구하기(DISTINCT, ALL 사용)
SELECT COUNT(DISTINCT SAL), 
        COUNT(ALL SAL),
        COUNT(SAL)
FROM EMP;

-- COUNT 함수를 사용하여 추가 수당 열 개수 출력하기
SELECT COUNT(COMM)
FROM EMP;

-- COUNT 함수와 IS NOT NULL을 사용하여 추가 수당 열 개수 출력하기
SELECT COUNT(COMM) -- 추가수당을 구할거다
FROM EMP
WHERE COMM IS NOT NULL; --근데(조건식) 추가 수당이 NULL이 아닌걸 구해라

-- <MAX(최댓값), MIN(최솟값)을 구하는 함수> 182P
-- 부서 번호가 10번인 사원들의 최대 급여 출력하기
SELECT MAX(SAL)
FROM EMP
WHERE DEPTNO = '10';

-- 부서 번호가 10번인 사원들의 최소 급여 출력하기
SELECT MIN(SAL)
FROM EMP
WHERE DEPTNO = '10';

--날짜 데이터에 MAX, MIN 함수 사용하기,(날짜 및 문자 데이터 역시 크기 비교가 가능)
-- 부서 번호가 20인 사원의 입사일 중 제일 최근 입사일 출력하기
SELECT MAX(HIREDATE) -- 입사 연도가 가장 큰 사람이 최근입사일임(숫자가 크면 최근이자내)
FROM EMP
WHERE DEPTNO = '20';

--부서 번호가 20인 사원의 입사일 중 제일 오래된 입사일 출력하기
SELECT MIN(HIREDATE)
FROM EMP
WHERE DEPTNO = '20';

-- <AVG>:평균 값을 구한다
-- 부서 번호가 30인 사원들의 평균 급여 출력하기
SELECT AVG(SAL) --DISTINCT를 지정하지 않으면 기본값인 ALL이 나타나게 된다.
FROM EMP
WHERE DEPTNO = 30;

--DISTINCT로 중복을 제거한 급여 열의 평균 급여 구하기
SELECT AVG(DISTINCT(SAL))
FROM EMP
WHERE DEPTNO = 30;

-- 부서 번호가 30인 사원들의 평균 추가 수당을 출력하도록 다음 SQL문의 빈칸을 채워 보세요.
SELECT AVG(COMM)
FROM EMP
WHERE DEPTNO = 30;

-- GROUP BY>결과 값을 원하는 열로 묶어 출력한다.186P
-- 그룹화할 열을 지정한다(여러개 지정 가능)

-- GROUP BY를 사용하여 부서별 평균 급여 출력하기
SELECT AVG(SAL), DEPTNO
FROM EMP
GROUP BY DEPTNO;

-- 부서 번호 및 직책별 평균 급여로 정렬하기
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
-- GROUP BY절에 명시된 부서 번호로 그룹을 먼저 묶은 후 그룹 내에서 직책 열을 기준으로 다시 소그룹으로 묶어 급여 평균을 출력한다.
GROUP BY DEPTNO, JOB
-- 가지런하게 정렬을 하고싶다면 ORDER BY
ORDER BY DEPTNO, JOB;

-- GROUP BY절을 사용하여 부서 번호별 평균 추가 수당을 출력해라
SELECT DEPTNO, AVG(COMM)
FROM EMP
GROUP BY DEPTNO;

-- 오류: GROUP BY절에 없는 열을 SELECT절에 포함했을 경우
SELECT ENAME, DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO;

-- <GROUP BY절에 조건을 줄 때 사용하는 HAVING절> 190P
-- HAVING절은 GROUP BY절이 존재할 때만 사용 가능

-- 각 부서의 직책별 평균 급여를 구하되 그 평균 급여가 2000 이상인 그룹만 출력해라
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB --그룹화
HAVING AVG(SAL) > 2000  -- 그룹에 대한 조건식 작성
ORDER BY DEPTNO, JOB;   --그룹화된 것을 정렬( 먼저 써진 DEPTNO를 기준으로 순서대로 정렬 된다.)

























