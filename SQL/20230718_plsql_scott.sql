-- 프로시저를 사용하여 출력하는 내용을 화면에 보여주도록 설정하는
    --환경변수이다. 기본값 OFF
SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD'); --DBMS...을 쓰고 ()괄호 안에 출력할 값을 넣는다.
    --DBMS_OUTPUT패키지 안에 있는 PUT_LINE이라는 프로시저를 이용하여 출력한다.
END;
/

--DETP_CODE가 30DLRH SAL이 800인걸 출력해봐
--선언(변수명 자료형)
-- 초기화를 

DECLARE
    EMP_ID NUMBER;
    EMP_NAME VARCHAR2(30);
BEGIN 
    EMP_ID := 888;
    EMP_NAME := '배정남';
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID); 
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
END;
/
    
-- 레퍼런스 변수의 선언과 초기화, 변수 값 출력
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME
    INTO EMP_ID,EMP_NAME 
    --INTO: 데이터를 삽입하겠다.
        -- 컬럼 데이터 값을 EMP_ID와 EMP_NAME 변수에 삽입!
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
     DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
     DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
END;
/

-- <선택문>
-- IF ~ THEN ~ END IF



-- <TRIGGER>
-- 테이블이나 뷰가 DML문에 의해 변경될 경우 자동으로 실행될 내용을 정의
-- 예시
CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT
ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('신입사원이 입사했습니다.');
END;
/

INSERT INTO EMPLOYEE VALUES(905, '길성춘', '690512-1151432',
                        'GIL_SJ@KH.OR.KR','01035464455', 'D5', 'J3',
                        'S5',3000000,0.1,200,SYSDATE,NULL,DEFAULT);

-- 부서 별 평균 월급이 2800000을 초과하는 부서를 조회해라
SELECT DEPTNO, SUM(SAL) 합계, FLOOR(AVG(SAL)) 평균, COUNT(*) 인원수
FROM EMP
GROUP BY DEPTNO
HAVING FLOOR(AVG(SAL)) >= 2800000
ORDER BY DEPTNO ASC;
--그룹으로 묶은 것에 대한 조건을 기술하는 부분이니 평균월급 >= 2800000 










