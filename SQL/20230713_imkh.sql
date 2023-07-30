-- 새로운 계정 만들기
CREATE USER KH IDENTIFIED BY KH; --CREATE를 이용해 계정을 생성한다.
GRANT RESOURCE, CONNECT TO KH; --GRANT를 이용하여 권한을 준다.

-- <시험 문제>
-- 1. 사용자 계정을 만들기 위해 일반 사용자 계정인 TEST계정으로 접속하여 계정이 SAMPLE 비밀번호가 1234인
    --계정을 생성하기 위해 CREATE USER SAMPLE; 를 실행하니 정상적으로 실행이 되지 않았다.
    -- => 일반 사용자 계정이 아닌 SYSTEM, SYS AS SYSDBA계정으로 실행해야한다.
    -- SYSTEM 계정으로 재접속한다.
        -- => CREATE USER SAMPLE IDENTIFIED BY 1234;
        
-- 2.DEPT_CODE가 D9이거나 D6이고 SALARY이 300만원 이상이고 BONUS가 있고
    --남자이고 이메일주소가 _ 앞에 3글자 있는 사원의 EMP_NAME, EMP_NO, DEPT_CODE, SALARY를 조회
    SELECT EMP_NAME, EMP_NO, DEPT_CODE, SALARY
    FROM EMPLOYEE
    WHERE (DEPT_CODE = 'D9' OR DEPT_CODE = 'D6') -- 우선연산처리가 되어야함
    AND SALARY >= 3000000 -- 이상이니깐 >= (초과면 > )
    AND BONUS IS NOT NULL -- 보너스가 있다고 했으니 NULL이 아니다라고 써야한다.
    AND EMAIL LIKE '___#_%' ESCAPE '#' --컬럼 명 like '___기호_%' 이스케이프 '기호'
    AND SUBSTR(EMP_NO, 8, 1) = 1;

-- 3.SELECT * FROM EMPLOYEE WHERE BONUS = NULL AND MANAGER_ID !=NULL;
    --NULL값에 대한 비교처리가 되지 않았다.
    -- => 이유: 일반연산자와 null값을 비교할 수가 없다(null이란 아무것도 값이 없음을 의미)
    SELECT *
    FROM EMPLOYEE
    WHERE BONUS IS NULL AND MANAGER_ID IS NOT NULL; 
    -- NULL값을 비교하려면 IS NULL AND IS NOT NULL로 바꿔줘야 한다.

CREATE USER KH IDENTIFIED BY KH;
GRANT RESOURCE, CONNECT TO KH;

-- 연봉: SALARY, 급여 + (급여+보너스) 
SELECT EMP_NAME, SALARY*12,(SALARY + (SALARY*BONUS))*12
FROM EMPLOYEE;

SELECT *
FROM EMPLOYEE; 

SELECT EMP_NAME AS 이름, SALARY*12 "연봉(월)",
    (SALARY + (SALARY*BONUS))*12 AS "총 소득(원)"
    FROM EMPLOYEE; 
    
SELECT EMP_NAME AS 이름, SALARY*12 "연봉(월)",
    (SALARY + (SALARY*BONUS))*12 AS "총 소득(원)"
    FROM EMPLOYEE; 

-- 리터럴: 문자나 날짜 리터럴은 '' 기호 사용한다.
SELECT EMP_ID, SALARY, '원' AS 단위 --,(콤마) 다음 문자(리터럴)'원'이니깐 행에 표시된다.
FROM EMPLOYEE;

-- DISTINCT: 중복 값 제외
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

-- 부서코드가 D9인 직원이름, 부서코드 조회
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 급여가 4000000보다 많은 직원 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY > 4000000;

-- 부서코드가 'D6'이거나 급여를 2000000보다 많이 받는 직원 
-- (이거나=OR, A이거나B이니 A,B둘 중 하나 아무거나 포함되면 나타나도록 해야함, AND는 둘 다 포함)
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY > 2000000;

-- <연결 연산자>
-- 컬럼과 컬럼을 연결
SELECT EMP_NAME || DEPT_CODE
FROM EMPLOYEE;

-- 컬럼과 리터럴을 연결
SELECT EMP_NAME || '직원이름'
FROM EMPLOYEE;

-- <비교 연산자>
-- BETWEEN AND
-- 급여를 3500000보다 많이 받고 6000000보다 적게 받는 직원 이름과 급여 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE 
WHERE SALARY BETWEEN 3500000 AND 6000000;
-- 또는
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

-- LIKE
-- 직원 이름중 전 씨만
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

-- 핸드폰 앞 네자리 중 첫 번호가 7인 직원 이름과 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE LIKE '___7%';

-- EMAIL ID 중 '_'의 앞이 3자리인 직원 이름, 이메일 조회
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#'; 
-- (-) 작대기가 비슷하니 ESCAPE로 처리 작대기 대신 # 그리고 ESCAPE '#'이라고 뒤에 써주기

-- '이'씨 성이 아닌 직원 사번, 이름, 이메일 조회
SELECT EMP_NO, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMP_NAME NOT LIKE '이%'; -- NOT은 맨 앞에 위치하나 연산자 앞에 위치하나 노상관

-- ID NOT NULL 
-- 관리자도 없고 부서 배치도 받지 않은 직원 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- 부서 배치를 받지 않았지만 보너스를 지급받는 직원 조회
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

-- IN( 비교하려는 값 목록에 일치하는 값이 있으면 TRUE를 반환하는 연산자)
-- D6 부서와 D8 부서원들의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D6' , 'D8'); -- 혹은 IN 대신 OR을 써도 된다.

-- ‘J2’ 또는 ‘J7’ 직급 코드 중 급여를 2000000보다 많이 받는 직원의 이름, 급여, 직급코드 조회
SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J2' AND SALARY > 2000000; 
-- 연산자 우선순위에 의해서 AND가 먼저 실행됨 
-- 그래서 200백만원 이상인 J2직급인 사람이거나 직급이 J7인 사람을 나타낸다.(J7에는 200 이상이 적용X)

-- 직급이 'J7' 혹은 'J2'인데 급여가 200백 이상인 직원들을 출력
SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE IN('J7', 'J2') AND SALARY > 2000000;

--<02_실습_kh>
--1. JOB 테이블의 모든 정보 조회
SELECT *
FROM JOB;

--2.JOB 테이블의 직급 이름 조회
SELECT JOB_NAME
FROM JOB;

-- DEPARTMENT 테이블의 모든 정보 조회
SELECT *
FROM DEPARTMENT;

-- EMPLOYEE테이블의 직원명, 이메일, 전화번호, 고용일 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

--EMPLOYEE 테이블의 고용일, 사원 이름, 월급 조회
SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;

-- 6.EMPLOYEE 테이블에서 이름, 연봉, 총수령액(보너스 포함), 실수령액
    --(총수령액 - (연봉*세금 3%)) 조회
SELECT EMP_NAME "이름", SALARY*12 "연봉", (SALARY+(SALARY*BONUS))*12 "총수령액"
        ,(((SALARY*(1+BONUS))*12) - (SALARY*12*0.03)) "실수령액"
        ((SALARY*12+(SALARY*12*BONUS))-(SALARY*12*0.03)
        ((salary+(salary*nvl(bonus,0)))-(salary*0.03))*12
        salary*(12)*(1+nvl(bonus,0))*0.97
        SALARY*12+((SALARY*12)*NVL(BONUS, 0))-(SALARY*12*0.03) 
        SALARY*(1+NVL(BONUS, 0))*12-SALARY*12*0.03

FROM EMPLOYEE; --모르겠다.

-- 7.EMPLOYEE 테이블에서 SAL_LEVEL이 S1인 사원의 이름, 월급, 고용일, 연락처 조회
SELECT EMP_NAME, SALARY, HIRE_DATE, PHONE
FROM EMPLOYEE
WHERE SAL_LEVEL = 'S1';

-- nvl: 컬럼이 null이 아니라면 그대로 출력, null이면 기본 값 지정 가능
-- 8.EMOLOYEE 테이블에서 실수령액이 5천만원 이상인 사원의 이름,월급, 실수령액 고용일 조회
SELECT EMP_NAME, SALARY,  (SALARY+(SALARY*BONUS))*12
FROM EMPLOYEE;


-- TO_NUMBER: 문자 데이터를 숫자 데이터로 변환한다.
-- '숫자처럼 생긴' 문자 데이터 간의 산술 연산 시 자동으로 
    --문자 데이터 -> 숫자 데이터로 형변환이 일어남(암시적 형변환)
SELECT 1300 - '1500',
    '1300' + 1500
FROM DUAL;

-- 숫자 사이에 (,) 쉼표가 들어가 있어서 자동으로 문자 -> 숫자로 형변환이 되지 않는다.
SELECT '1,300' - '1,500'
FROM DUAL;
-- 그래서 강제로 인식 TO_NUMBER 사용
-- TO_NUMBER('[문자열 데이터(필수)]', '[인식될 숫자형태(필수)]');
SELECT TO_NUMBER( '1,300', '999,999') - TO_NUMBER( '1,500', '999,999')
FROM DUAL;

-- TO_CHAR: 숫자OR문자 다 변환
-- TO_DATE: 문자 -> 날짜
-- TO_NUMBER: 문자 -> 숫자

-- TO_DATE: 문자 -> 숫자
SELECT TO_DATE('2018-07-14', 'YYYY-MM-DD') AS TODATE1,
    TO_DATE('20180714', 'YYYY-MM-DD') AS TPDATE2
FROM EMPLOYEE;

-- 1981년 6월 1일 이후에 입사한 사원 정보 출력하기
-- TO_DATE를 사용, 기준점 = 입사일(HIREDATE)
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE > TO_DATE('1981/06/01', 'YYYY/MM/DD'); -- (-)이거 말고도 (/) 사용가능 

--1980년 10월 15일 이후에 입사한 사원을 출력해라
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE > TO_DATE('1980-10-15', 'YY/MM/DD');


















