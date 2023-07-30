-- <CREATE> : 테이블이나 인덱스, 뷰 등 데이터베이스 객체를 생성하는 구문
-- CREATE TABLE 테이블 명 ( 컬럼 명(열), 자료형(크기)  );
CREATE TABLE MEMBER( MEMBER_ID VARCHAR2(20), 
                    MEMBER_PWD VARCHAR2(20),
                    MEMBER_NAME VARCHAR2(20)
);

-- 컬럼(열)주석 : 테이블의 컬럼에 주석을 다는 구문
-- 표현식
-- COMMENT ON COLUMN 테이블명.컬럼명 IS '주석 내용';
COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원아이디';

--?
DESC USER_CONSTRAINTS;
SELECT * FROM USER_CONSTRAINTS; --PRIMART KEY: P, FOREIGN KEY: R(FK)


