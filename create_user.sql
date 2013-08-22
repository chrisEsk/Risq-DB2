create user risq identified by risq
default tablespace USERS temporary tablespace TEMP
quota unlimited on users;
grant CREATE SESSION, CREATE TABLE, CREATE PROCEDURE
    , CREATE SEQUENCE, CREATE TRIGGER, CREATE VIEW
    , CREATE SYNONYM, ALTER SESSION, CREATE ANY INDEX 
    , CREATE PUBLIC SYNONYM, CREATE USER, CREATE ROLE
    , CREATE ANY DIRECTORY, QUERY REWRITE, DROP PUBLIC SYNONYM
TO  risq;