-- Please note that ZIKZAK_SCHEMA has to be created manually in H2. Rest all database objects will be created during bootstrapping for the firsttime 
----------------------------------------------------------------------------------------------------
-- Data Courtesy : http://download.oracle.com/oll/tutorials/DBXETutorial/html/module2/les02_load_data_sql.htm
-- Tweaked a bit as needed for H2
----------------------------------------------------------------------------------------------------

-- DROP USER IF EXISTS zikzak;
-- CREATE USER IF NOT EXISTS zikzak PASSWORD 'zikzak123' ADMIN;
-- DROP SCHEMA IF EXISTS ZIKZAK_SCHEMA;
-- CREATE SCHEMA ZIKZAK_SCHEMA AUTHORIZATION zikzak;
-- SET SCHEMA ZIKZAK_SCHEMA;

--DROP VIEW IF EXISTS emp_details_view;
--DROP TABLE IF EXISTS ZIKZAKTESTABLE;
--DROP TABLE IF EXISTS REGIONS;
--DROP TABLE IF EXISTS COUNTRIES;
--DROP TABLE IF EXISTS locations;
--DROP TABLE IF EXISTS departments;
--DROP TABLE IF EXISTS jobs;
--DROP TABLE IF EXISTS employees;
--DROP TABLE IF EXISTS job_history;

CREATE TABLE IF NOT EXISTS ZIKZAKTESTABLE (ID INT PRIMARY KEY, NAME VARCHAR(255));
 
CREATE TABLE IF NOT EXISTS REGIONS(REGION_ID INT NOT NULL AUTO_INCREMENT, REGION_NAME VARCHAR(25));
CREATE UNIQUE INDEX IF NOT EXISTS reg_id_pk ON REGIONS(region_id);
ALTER TABLE REGIONS ADD CONSTRAINT IF NOT EXISTS reg_id_pk PRIMARY KEY(region_id);

CREATE TABLE IF NOT EXISTS COUNTRIES ( country_id CHAR(2) NOT NULL, country_name VARCHAR2(40), region_id NUMBER);
CREATE UNIQUE INDEX IF NOT EXISTS country_id_pk ON COUNTRIES(country_id);
ALTER TABLE COUNTRIES ADD CONSTRAINT IF NOT EXISTS country_id_pk PRIMARY KEY(country_id);
ALTER TABLE COUNTRIES ADD CONSTRAINT IF NOT EXISTS countr_reg_fk FOREIGN KEY (region_id) REFERENCES REGIONS(region_id);

CREATE TABLE IF NOT EXISTS locations ( location_id NUMBER(4) NOT NULL, street_address VARCHAR2(40), postal_code VARCHAR2(12), city VARCHAR2(30), state_province VARCHAR2(25), country_id CHAR(2)) ;
CREATE UNIQUE INDEX IF NOT EXISTS loc_id_pk ON locations (location_id);
ALTER TABLE locations ADD CONSTRAINT IF NOT EXISTS location_id_pk PRIMARY KEY(location_id);
ALTER TABLE locations ADD CONSTRAINT IF NOT EXISTS loc_c_id_fk FOREIGN KEY (country_id) REFERENCES countries(country_id);

--CREATE SEQUENCE IF NOT EXISTS locations_seq START WITH 3300 INCREMENT BY 100 MAXVALUE 9900 NOCACHE NOCYCLE;
CREATE SEQUENCE IF NOT EXISTS locations_seq START WITH 3300 INCREMENT BY 100 NOCACHE NOCYCLE;
 
CREATE TABLE IF NOT EXISTS departments ( department_id NUMBER(4) NOT NULL, department_name VARCHAR2(30), manager_id NUMBER(6), location_id NUMBER(4)) ;
CREATE UNIQUE INDEX IF NOT EXISTS dept_id_pk ON departments (department_id) ;
ALTER TABLE departments ADD CONSTRAINT IF NOT EXISTS dept_id_pk PRIMARY KEY (department_id);
ALTER TABLE departments ADD CONSTRAINT IF NOT EXISTS dept_loc_fk FOREIGN KEY (location_id) REFERENCES locations (location_id);

--CREATE SEQUENCE IF NOT EXISTS departments_seq START WITH 280 INCREMENT BY 10 MAXVALUE 9990 NOCACHE NOCYCLE;
CREATE SEQUENCE IF NOT EXISTS departments_seq START WITH 280 INCREMENT BY 10 NOCACHE NOCYCLE;
 
CREATE TABLE IF NOT EXISTS jobs ( job_id VARCHAR2(10) NOT NULL, job_title VARCHAR2(35) NOT NULL, min_salary NUMBER(6), max_salary NUMBER(6) ) ;
CREATE UNIQUE INDEX IF NOT EXISTS job_id_pk ON jobs (job_id) ;
ALTER TABLE jobs ADD CONSTRAINT IF NOT EXISTS job_id_pk PRIMARY KEY(job_id);

 
CREATE TABLE IF NOT EXISTS employees ( employee_id NUMBER(6) NOT NULL, first_name VARCHAR2(20), last_name VARCHAR2(25) NOT NULL, email VARCHAR2(25), phone_number VARCHAR2(20), hire_date DATE NOT NULL, job_id VARCHAR2(10) NOT NULL, salary NUMBER(8,2), commission_pct NUMBER(2,2), manager_id NUMBER(6), department_id NUMBER(4), CONSTRAINT emp_salary_min
 CHECK (salary > 0)) ;
CREATE UNIQUE INDEX IF NOT EXISTS emp_emp_id_pk ON employees (employee_id) ;
 
ALTER TABLE employees ADD CONSTRAINT IF NOT EXISTS emp_emp_id_pk PRIMARY KEY (employee_id);
ALTER TABLE employees ADD CONSTRAINT IF NOT EXISTS emp_dept_fk FOREIGN KEY (department_id) REFERENCES departments (department_id);
ALTER TABLE employees ADD CONSTRAINT IF NOT EXISTS emp_job_fk FOREIGN KEY (job_id) REFERENCES jobs (job_id);
-- not needed ALTER TABLE employees ADD CONSTRAINT IF NOT EXISTS emp_manager_fk FOREIGN KEY (manager_id) REFERENCES employees(job_id);
ALTER TABLE departments ADD CONSTRAINT IF NOT EXISTS dept_mgr_fk FOREIGN KEY (manager_id) REFERENCES employees (employee_id) ;

CREATE SEQUENCE IF NOT EXISTS employees_seq START WITH 207 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE TABLE IF NOT EXISTS job_history( employee_id NUMBER(6) NOT NULL, start_date DATE NOT NULL, end_date DATE NOT NULL, job_id VARCHAR2(10) NOT NULL, department_id NUMBER(4), CONSTRAINT jhist_date_interval CHECK (end_date > start_date)); 
CREATE UNIQUE INDEX IF NOT EXISTS jhist_emp_id_st_date_pk ON job_history (employee_id, start_date) ;
ALTER TABLE job_history ADD CONSTRAINT IF NOT EXISTS jhist_emp_id_st_date_pk PRIMARY KEY (employee_id, start_date);
ALTER TABLE job_history ADD CONSTRAINT IF NOT EXISTS jhist_job_fk FOREIGN KEY (job_id) REFERENCES jobs;
ALTER TABLE job_history ADD CONSTRAINT IF NOT EXISTS jhist_emp_fk FOREIGN KEY (employee_id) REFERENCES employees;
ALTER TABLE job_history ADD CONSTRAINT IF NOT EXISTS jhist_dept_fk FOREIGN KEY (department_id) REFERENCES departments;

CREATE OR REPLACE VIEW emp_details_view
(employee_id, job_id, manager_id, department_id, location_id, country_id, first_name, last_name, salary, commission_pct, department_name, job_title, city, state_province, country_name, region_name)
 AS SELECT
 e.employee_id,  e.job_id,  e.manager_id,  e.department_id, d.location_id, l.country_id, e.first_name, e.last_name, e.salary, e.commission_pct, d.department_name, j.job_title, l.city, l.state_province, c.country_name, r.region_name
 FROM
 employees e, departments d, jobs j, locations l, countries c, regions r
 WHERE e.department_id = d.department_id AND d.location_id = l.location_id AND l.country_id = c.country_id AND c.region_id = r.region_id AND j.job_id = e.job_id;
 
COMMIT;

