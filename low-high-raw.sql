
prompt
prompt Use of the [low|high]_value columns is deprecated for [all|dba|user]_tab_columns
prompt They are here for Oracle 7 compatibility
prompt Use these views instead: [tab|part]_col_statistics 
prompt

col low_value format 99999999999
col high_value format 99999999999

select low_value, high_value 
from user_tab_columns 
where table_name = 'LOW_HIGH' 
	and column_name = 'N1'
/

col low_value format a40
col high_value format a40

select low_value, high_value 
from user_tab_columns 
where table_name = 'LOW_HIGH' 
	and column_name = 'C1'
/

select low_value, high_value 
from user_tab_columns 
where table_name = 'LOW_HIGH' 
	and column_name = 'D1'
/
