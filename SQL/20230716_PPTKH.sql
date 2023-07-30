-- <SUBQUERY>
-- 예시1
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >=(SELECT AVG(SALARY) FROM EMPLOYEE);

-- 단일 행 서브쿼리(결과 값의 개수가 1개)
-- 전 직원의 급여 평균보다 많은 급여를 받는 직원의 이름, 직급, 부서, 급여를 조회
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEE) -- 급여 평균보다 많이 받는 >=
ORDER BY 2; -- 2번째 컬럼(열)을 기준으로

--다중 행 서브쿼리
-- 부서 별 최고 급여를 받는 직원의 이름, 직급, 부서, 급여 조회
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MAX(SALARY) FROM EMPLOYEE GROUP BY DEPT_CODE)
ORDER BY 3;

--<GROUP BY, HAVING>
--GROUP BY: 그룹화할 때 사용, 여러 개의 결과 값을 산출
-- 부서의 연봉 합계를 구하겠다?(부서를 그룹화)
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 부서코드 그룹 별 급여의 합계, 그룹 별 급여의 평균(정수처리) 인원 수를 조회하고 부서 코드 순 정렬
SELECT DEPT_CODE "부서코드", SUM(SALARY) "합계", 
        FLOOR(AVG(SALARY)) "평균", COUNT(*) "인원 수"
FROM EMPLOYEE
GROUP BY DEPT_CODE  -- 지금 부서관련해서 구하는거니깐
ORDER BY DEPT_CODE ASC; --부서 코드 순으로 정렬

-- 부서코드와 보너스 받는 사원 수 조회하고 부서코드 순으로 정렬
-- 부서 내에서 보너스를 받는 사원 수(숫자)를 조회 해야하니 COUNT를 써야 하고 ()안에 BONUS를 적는다.
SELECT DEPT_CODE, COUNT(BONUS) 
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC;

SELECT DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', 2, '여') "성별", --성별
        FLOOR(AVG(SALARY)) "평균",
        SUM(SALARY) 합계,
        COUNT(*) 인원수
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', 2, '여')
ORDER BY 4 DESC; --인원수로 내림차순이니 4

-- <NVL>
SELECT EMP_NO, EMP_NAME, SALARY,
    NVL(BONUS,0) 보너스 , -- 보너스가 없는 사람들은 NULL값으로 나오는데 NULL이 아니라 0으로 나오게 함
    (SALARY + (SALARY * NVL(BONUS,0)))*12 총수령액
FROM EMPLOYEE;

--<DECODE>  :조건식,조건1,결과1 --SELECT절에 바로 적힘
SELECT EMP_NAME, EMP_NO,
     DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여') AS 성별
FROM EMPLOYEE;

--<CASE>
-- 성별을 구하라 1이면 남자 2이면 여자
SELECT EMP_ID, EMP_NAME, EMP_NO,
    CASE WHEN SUBSTR(EMP_NO, 8, 1) =1 THEN '남'
    ELSE '여'
    END AS 성별
FROM EMPLOYEE;

-- 등급을 구하라
SELECT EMP_NAME, SALARY,
    CASE WHEN SALARY >= 5000000 THEN '1등급'
         WHEN SALARY >= 3500000 THEN '2등급'
         WHEN SALARY >= 2000000 THEN '3등급'
         ELSE '4등급'
    END 등급
FROM EMPLOYEE;

-- DECODE: 비교하고자 하는 값 또는 컬럼이 조건식과 같으면 결과 값 반환
    --DECODE(표현식, 조건1, 결과1, DEFAULT)
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', 2, '여') 성별,
        FLOOR(AVG(SALARY)) 평균, -- 평균(정수처리)
        SUM(SALARY) 합계,    --급여 합계
        COUNT(*) 인원수
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', 2, '여') --성별이 기준이므로?
ORDER BY 4 DESC; --인원수로 내림차순 정렬
    

-- <HAVING>: GROUP BY에 대한 조건을 적는다(WHERE는 SELECT에 대한 조건을 적는 곳)
-- 부서 코드와 급여 3000000 이상인 직원의 그룹별 평균 조회
SELECT DEPT_CODE, FLOOR(AVG(SALARY)) 평균
FROM EMPLOYEE
WHERE SALARY >= 3000000
GROUP BY DEPT_CODE
ORDER BY 1; -- SELECT한 컬럼에 대해 정렬을 할 때 작성하는 구문

-- 부서 코드와 급여 평균이 3000000 이상인 그룹 조회
SELECT DEPT_CODE 부서코드, FLOOR(AVG(SALARY)) 급여평균
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) >= 3000000 -- 급여 평균이 300만원 이상
ORDER BY 1;

-- 부서 코드와 급여 평균이 3000000 이상인 그룹 조회
SELECT DEPT_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) > 3000000
ORDER BY 1;

-- <ROLLUP와 CUBE> :그룹 별 산출한 결과 값의 집계를 계산하는 함수
-- ROLLUP 
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE) --JOB_CODE의 전체 결과 값을 집계
ORDER BY 1;

SELECT DEPT_CODE,JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1;


--CUBE
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE)
ORDER BY 1;

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;


--GROUPINNG 예시 ROLLUP, CUBE에 의한 집계의 결과가 전달받은 컬럼 집합의 산출물이면 0 아니면 1
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY),
-- CASE WHEN 조건1 THEN 결과1 ELSE 결과 END N
CASE WHEN GROUPING(DEPT_CODE) = 0 AND
            GROUPING(JOB_CODE) = 1  --1이 NULL값이다.
    THEN '부서별 합계'
    WHEN GROUPING(DEPT_CODE) = 1 AND
          GROUPING(JOB_CODE) = 0
    THEN '직급별 합계'
    WHEN GROUPING(DEPT_CODE) = 1 AND
        GROUPING(JOB_CODE) = 1
    THEN '총 합계'
    ELSE '그룹별 합계'
END AS 구분
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY),
--CASE 조건1 THEN 결과1 ELSE 결과 END N
CASE WHEN GROUPING(DEPT_CODE) = 0 AND
            GROUPING(JOB_CODE) = 1
    THEN '부서별 합계'
    WHEN GROUPING(DEPT_CODE) = 1 AND
            GROUPING(JOB_CODE) = 0
    THEN '직급별 합계'
    WHEN GROUPING(DEPT_CODE) = 1 AND
            GROUPING(JOB_CODE) = 1
    THEN '총 합계'
    ELSE '그룹별 합계'
    END "구분"
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE,JOB_CODE)
ORDER BY 1;





-- <02 실습>
-- 6.EMPLOYEE테이블에서 이름, 연봉, 총수령액(보너스포함),
    -- 실수령액(총수령액 - (연봉*세금 3%)) 조회
SELECT EMP_NAME,
    SALARY*12 연봉, 
    (SALARY + SALARY * NVL(BONUS,0))*12 총수령액, 
    ((SALARY + (SALARY * NVL(BONUS,0))) - (SALARY*0.03))*12 실수령액
    --NVL(P1,P2) =>(데이터를 처리할 컬럼명 혹은 값, 대체하고자 하는 값)
FROM EMPLOYEE;
    

-- < GROUP BY절 >
-- EMPLOYEE테이블에서 부서코드와 보너스 받는 사원 수 조회하고 부서코드 순으로 정렬
SELECT DEPT_CODE,COUNT(*)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- EMPLOYEE,성별과 성별 별 급여 평균(정수처리),급여 합계, 인원 수 조회하고 인원수로 내림차순 정렬
-- DECODE(컬럼, 조건1, 결과1 ...):비교하고자 하는 값 또는 컬럼이 조건식과 같으면 결과 값 반환
SELECT  DECODE(SUBSTR(EMP_NO, 8,1), 1, '남', 2, '여자'), 
        FLOOR(AVG(SALARY)),
        SUM(SALARY),
        COUNT(*)
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO, 8,1), 1, '남', 2, '여자')
ORDER BY 4 DESC;

-- HAVING절 
-- 부서 코드와 급여 평균이 3000000 이상인 그룹 조회 
SELECT DEPT_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) >= 3000000
ORDER BY DEPT_CODE;











