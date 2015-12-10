
-- low-high-cast1.sql
-- Jared Still
-- http://www.pythian.com/blog/author/still/
-- still@pythian.com
-- jkstill@gmail.com

col low_value format 999999999999
col high_value format 999999999999

select  column_name
	, utl_raw.cast_to_number(low_value) low_value
	, utl_raw.cast_to_number(high_value) high_value
from user_tab_columns
where table_name = 'LOW_HIGH'
	and data_type = 'NUMBER'
/

col low_value format a20
col high_value format a20

select  column_name
	, utl_raw.cast_to_varchar2(low_value) low_value
	, utl_raw.cast_to_varchar2(high_value) high_value
from user_tab_columns
where table_name = 'LOW_HIGH'
	and data_type = 'VARCHAR2'
/


