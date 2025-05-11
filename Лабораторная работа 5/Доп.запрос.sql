use UNIVER;
select s.NAME, s.BDAY, s.IDGROUP from
STUDENT s where FORMAT(s.BDAY, 'MM-dd') in(select FORMAT(st.BDAY, 'MM-dd') from STUDENT st where
MONTH(s.BDAY) = MONTH(st.BDAY) and DAY(s.BDAY) = DAY(st.BDAY) and s.IDSTUDENT != st.IDSTUDENT) order by DAY(s.BDAY),MONTH(s.BDAY);