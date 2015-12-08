# low-high
Investigation into the low_value and high_value columns of user_tab_col_statistics, and how to read them.

create.sql:
  create a table and indexes.

low-high-raw.sql:
  Show raw values for low_value and high_value

low-high-cast1.sql:
  Uses utl_raw.cast_to_[number|varchar2] to display the numeric and character
  values for low_value and high_value

low-high-cast2.sql:
  Builds on low-high-cast1.sql.  
  Dates cannot be converted with utl_raw.
  Dbms_stats convert routines could be used but this requires creating functions if < 12.1.
  Instead use the dump() function and reconstruct the dates.
  Currently only NUMBER, VARCHAR2 and DATE are supported.


  
