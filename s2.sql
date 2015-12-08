
col low_value format 99999999
col high_value format 99999999

select  utl_raw.cast_to_number(low_value) low_value
	, utl_raw.cast_to_number(high_value) high_value
from user_tab_col_statistics
where table_name = 'LOW_HIGH'
	and column_name = 'N1'
/

col low_value format a20
col high_value format a20

select  utl_raw.cast_to_varchar2(low_value) low_value
	, utl_raw.cast_to_varchar2(high_value) high_value
from user_tab_col_statistics
where table_name = 'LOW_HIGH'
	and column_name = 'C1'
/


