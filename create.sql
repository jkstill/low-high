

define chars='ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz'

drop table low_high purge;

create table low_high
as 
select id
	, mod(id,128) n1
	, substr('&&chars',mod(id,42)+1, 20) c1
	, sysdate-(mod(id,1000)+1) d1
from (
	select level id from dual
	connect by level <= 128 * 1024
)
/


exec dbms_stats.gather_table_stats(user,'LOW_HIGH')


