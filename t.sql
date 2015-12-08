
drop table t purge;

create table t as select sysdate-level d1 from dual connect by level <=10;

exec dbms_stats.gather_table_stats(user,'T')

col lowval_dump format a25
col test_date format a25

select min(d1) from t;

select lowval_dump,
        -- extract the century and year information from the
        -- internal date format
        -- century = (century byte -100) * 100
        to_char((
                to_number(
                        -- parse out integer appearing before first comma
                        substr( lowval_dump, 1, instr(lowval_dump,',')-1) - 100
                ) * 100
        )
        +
        -- year = year byte - 100
        (
                to_number(
                        substr(
                                lowval_dump,
                                -- get position of 2nd comma
                                instr(lowval_dump,',',2)+1,
                                -- get position of 2nd comma - position of 1st comma
                                instr(lowval_dump,',',1,2) - instr(lowval_dump,',',1,1) -1
                        )
                )
                - 100
        )) --current_year
			|| '-' || substr(
				lowval_dump,
		  		instr(lowval_dump,',',1,2)+1,
				instr(lowval_dump,',',1,3) - instr(lowval_dump,',',1,2) -1
			) -- month
			||  '-' || substr(
				lowval_dump,
		  		instr(lowval_dump,',',1,3)+1,
				instr(lowval_dump,',',1,4) - instr(lowval_dump,',',1,3) -1
			) -- day
			|| ' ' || 
			lpad(
				to_char(to_number(
					substr(
						lowval_dump,
		  				instr(lowval_dump,',',1,4)+1,
						instr(lowval_dump,',',1,5) - instr(lowval_dump,',',1,4) -1
					)
				)-1)
				,2,'0'
			) -- hour
			|| ':' || 
			lpad(
				to_char(
					to_number(
						substr(
							lowval_dump,
		  					instr(lowval_dump,',',1,5)+1,
							instr(lowval_dump,',',1,6) - instr(lowval_dump,',',1,5) -1
						)
					)-1
				)
				,2,'0'
			) -- minute
			|| ':' ||
			lpad(
				to_char(
					to_number(
						substr(
							lowval_dump,
		  					instr(lowval_dump,',',1,6)+1
						)
					)-1
				)
				,2,'0'
			) --second
			test_date
from (
        -- return just the date bytes from the dump()
        select substr(dump(low_value),15) lowval_dump
		  from user_tab_col_statistics
		  where table_name = 'T'
		  and column_name = 'D1'
) a
/
