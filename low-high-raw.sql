
-- low-high-raw.sql
-- Jared Still
-- http://www.pythian.com/blog/author/still/
-- still@pythian.com
-- jkstill@gmail.com

prompt
prompt Use of the [low|high]_value columns is deprecated for [all|dba|user]_tab_columns
prompt They are here for Oracle 7 compatibility
prompt Use these views instead: [tab|part]_col_statistics 
prompt

col low_value format a40
col high_value format a40
col column_name format a6

set line 200 trimspool on
set pagesize 60

prompt
prompt NUMERIC
prompt 

select column_name, low_value, high_value 
from user_tab_columns 
where table_name = 'LOW_HIGH' 
	and data_type = 'NUMBER'
/


prompt
prompt VARCHAR2
prompt 

select column_name, low_value, high_value 
from user_tab_columns 
where table_name = 'LOW_HIGH' 
	and data_type = 'VARCHAR2'
/

prompt
prompt DATE
prompt 

select column_name, low_value, high_value 
from user_tab_columns 
where table_name = 'LOW_HIGH' 
	and data_type = 'DATE'
/
