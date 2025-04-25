set search_path=hisinone;
 
select * from student
where registrationnumber in (52612);

select * from degree_program
Limit 100;

-- Studienverlauf eines Studierenden, z.B. 52612, 71857
set search_path=hisinone;
select degree_program_id, *
from degree_program, degree_program_progress 
where degree_program_id = degree_program.id 
and degree_program_id in 
(select id from degree_program where person_id in 
(select person_id from student where registrationnumber in (52612))) 
order by startdate, studynumber, subjectnumber

-- Course of Study , wg. der Studiengänge
set search_path=hisinone;
select * from course_of_study
where id in
(select course_of_study_id 
	from degree_program, degree_program_progress 
	where degree_program_id = degree_program.id 
	and degree_program_id in 
		(select id from degree_program where person_id in 
			(select person_id from student where registrationnumber in (52612))
		) 
		order by startdate, studynumber, subjectnumber
)

-- Aggregation der Daten aus dem Studienverlauf eines Studierenden für eine degree_program_id 
set search_path=hisinone;
select min(startdate), max(enddate), max(finished)
from degree_program, degree_program_progress 
where degree_program_id = degree_program.id 
and degree_program_id in 
(764) 
group by degree_program_id

-------------------
-- Sortierreihenfolge so, dass älteste Studiengänge zuerst stehen
-- Wegen der Group By UND Order By Konstruktion die nicht benötigten Infos aus Person rausgenommen.
select dp.id as dpid, min(dpp.startdate) as startdateMIN, dp.belongs_to, dp.person_id as publishPersonId, s.id as publishStudentId, s.registrationnumber as Mtknr, 
			enrollmentdate, universitysemester, leavesemester, practicalsemester, kollegsemester, s.term_year, s.term_type_id,
			s.library_card_number, s.current_enrollmentdate
			from degree_program as dp
			join degree_program_progress as dpp on dpp.degree_program_id = dp.id
			join person p ON p.id = dp.person_ID
			join student s on s.person_id = dp.person_id
			where s.id in ((select id from student where registrationnumber in (52612)))
			GROUP BY s.id, dp.id
			order BY startdateMIN ASC
