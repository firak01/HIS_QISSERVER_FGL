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
select min(startdate), max(enddate)
from degree_program, degree_program_progress 
where degree_program_id = degree_program.id 
and degree_program_id in 
(764) 
group by degree_program_id
