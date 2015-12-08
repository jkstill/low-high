select today_dump,
        -- extract the century and year information from the
        -- internal date format
        -- century = (century byte -100) * 100
        (
                to_number(
                        -- parse out integer appearing before first comma
                        substr( today_dump, 1, instr(today_dump,',')-1) - 100
                ) * 100
        )
        +
        -- year = year byte - 100
        (
                to_number(
                        substr(
                                today_dump,
                                -- get position of 2nd comma
                                instr(today_dump,',',2)+1,
                                -- get position of 2nd comma - position of 1st comma
                                instr(today_dump,',',1,2) - instr(today_dump,',',1,1) -1
                        )
                )
                - 100
        ) current_year
		  -- 120,113,3,12,19,5,15
			, substr(
				today_dump,
		  		instr(today_dump,',',1,2)+1,
				instr(today_dump,',',1,3) - instr(today_dump,',',1,2) -1
			) month
			, substr(
				today_dump,
		  		instr(today_dump,',',1,3)+1,
				instr(today_dump,',',1,4) - instr(today_dump,',',1,3) -1
			) day
			, to_number(substr(
				today_dump,
		  		instr(today_dump,',',1,4)+1,
				instr(today_dump,',',1,5) - instr(today_dump,',',1,4) -1
			))-1 hour
			, to_number(substr(
				today_dump,
		  		instr(today_dump,',',1,5)+1,
				instr(today_dump,',',1,6) - instr(today_dump,',',1,5) -1
			))-1 minute
			, to_number(substr(
				today_dump,
		  		instr(today_dump,',',1,6)+1
			))-1 second
from (
        -- return just the date bytes from the dump()
        select substr(dump(low_value),15) today_dump 
		  from user_tab_columns 
		  where table_name = 'LOW_HIGH'
		  and column_name = 'D1'
) a
/
