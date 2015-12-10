
-- extract-date-from-raw.sql
-- Jared Still
-- http://www.pythian.com/blog/author/still/
-- still@pythian.com
-- jkstill@gmail.com


col cyear format 9999
col month format a2
col day format a2
col hour format 99
col minute format 99
col second format 99

select 
        -- extract the century and year information from the
        -- internal date format
        -- century = (century byte -100) * 100
        (
                to_number(
                        -- parse out integer appearing before first comma
                        substr( startup_dump, 1, instr(startup_dump,',')-1) - 100
                ) * 100
        )
        +
        -- year = year byte - 100
        (
                to_number(
                        substr(
                                startup_dump,
                                -- get position of 2nd comma
                                instr(startup_dump,',',2)+1,
                                -- get position of 2nd comma - position of 1st comma
                                instr(startup_dump,',',1,2) - instr(startup_dump,',',1,1) -1
                        )
                )
                - 100
        ) cyear
			, substr(
				startup_dump,
		  		instr(startup_dump,',',1,2)+1,
				instr(startup_dump,',',1,3) - instr(startup_dump,',',1,2) -1
			) month
			, substr(
				startup_dump,
		  		instr(startup_dump,',',1,3)+1,
				instr(startup_dump,',',1,4) - instr(startup_dump,',',1,3) -1
			) day
			, to_number(substr(
				startup_dump,
		  		instr(startup_dump,',',1,4)+1,
				instr(startup_dump,',',1,5) - instr(startup_dump,',',1,4) -1
			))-1 hour
			, to_number(substr(
				startup_dump,
		  		instr(startup_dump,',',1,5)+1,
				instr(startup_dump,',',1,6) - instr(startup_dump,',',1,5) -1
			))-1 minute
			, to_number(substr(
				startup_dump,
		  		instr(startup_dump,',',1,6)+1
			))-1 second
from (
        -- return just the date bytes from the dump()
        select substr(dump(startup_time),15) startup_dump
		  from v$instance
) a
/
