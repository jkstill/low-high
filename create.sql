

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


create unique index low_high_id_idx on low_high(id);
create index low_high_n1_idx on low_high(n1);
create index low_high_c1_idx on low_high(c1);
create index low_high_d1_idx on low_high(d1);

exec dbms_stats.gather_table_stats(ownname => user, tabname => 'LOW_HIGH', method_opt => 'for all columns size auto', cascade => true)


