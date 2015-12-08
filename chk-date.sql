
define date_format='yyyy-mm-dd hh24:mi:ss'

select 
	to_char(min(d1), '&&date_format') d1_min
	, to_char(max(d1), '&&date_format') d1_max
from t;

col v_low_value new_value v_low_value
col v_high_value new_value v_high_value

var v_date_low varchar2(30)
var v_date_high varchar2(30)

select low_value v_low_value, high_value v_high_value
from user_tab_col_statistics
where table_name = 'LOW_HIGH'
and column_name = 'D1'
/

declare
	d_date_low date;
	d_date_high date;
begin
	dbms_stats.convert_raw_value('&&v_low_value',d_date_low);
	:v_date_low := to_char(d_date_low,'&&date_format');

	dbms_stats.convert_raw_value('&&v_high_value',d_date_high);
	:v_date_high := to_char(d_date_high,'&&date_format');
end;
/

print v_date_low
print v_date_high



