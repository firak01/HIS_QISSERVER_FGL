set search_path='hisinone';

-- Die möglichen Vertiefungen
select * from major_field_of_study
ORDER BY uniquename;



--
SELECT  course_of_study.id AS cos_id, course_of_study.lid AS cos_lid, course_of_study.uniquename AS cos_signature, unit.uniquename AS unit_signature, unit.id AS unit_id
                FROM unit
                INNER JOIN k_elementtype ON (unit.k_elementtype_id=k_elementtype.id AND k_elementtype.hiskey_id = 4)
                INNER JOIN course_of_study ON (course_of_study.uniquename LIKE split_part(unit.uniquename, '|', 1) || '|' || split_part(unit.uniquename, '|', 2) || '|%|%|' ||  split_part(unit.uniquename, '|', 5) || '|' || split_part(unit.uniquename, '|', 6) || '|%' )                                                     
                WHERE unit.uniquename LIKE (split_part(unit.uniquename, '|', 1) || '|' || split_part(unit.uniquename, '|', 2) || '|-|-|%')
	   			ORDER BY cos_signature;



select course_of_study.uniquename, * from course_of_study
WHERE split_part(uniquename,'|',1) in ('88') and split_part(uniquename,'|',2) in ('039')  and split_part(uniquename,'|',6) in ('2023')
ORDER BY uniquename;

--### SUCHE NACH DER KONKRETEN LEISTUNG, DEREN ZUORNUNG FEHLT
--a) über examrelation
select * from examrelation
where -- bonus in (7.0)
	  -- AND 
		k_unitrelationtype_id in(1) --AZ
--order by id DESC
--LIMIT 100;

--b) über examplan
select * from examplan
where date_of_work = '2025-02-13'
      and person_id in (
							select person_id from student
							where registrationnumber in(64769)
	  )
LIMIT 100


select * from examrelation 
where id in (
							select default_examrelation_id from examplan
							where date_of_work = '2025-02-13'
      								and person_id in (
														select person_id from student
														where registrationnumber in(64769)
	  												)
			)



select * from unit
where longtext like '%Grundlagen % Ingenieurgeologie%'
LIMIT 100;

select * from k_internal_accreditationtype; --wohl der Rücktritt


--### FÜR DIE ZUORDNUNG WICHTIG ----
select * from k_unitrelationtype;

--wirf die leistung raus, um sie neu zu migrieren.
--Merke den Wert für die ExternalTabpk bekommt man aus sospos, siehe im dortigen Test: "Alle Prüfungen eines Studenten für eine Prüfungsnummer"
--------------------------------------
select * from external_relation
order by id DESC
Limit 100

select * from external_relation
where externalsystem in ('sospos')
      AND externaltable in ('lab')
	  and externaltabpk in ('3253270')
LIMIT 100;

delete from external_relation
where id in(
	select id from external_relation
	where externalsystem in ('sospos')
      AND externaltable in ('lab')
	  and externaltabpk in ('3253270')
)


-- wirf die labzuordnung raus (das bringt aber nix, wenn die Zuordnung eh schon fehlt)
select * from external_relation
where externalsystem in ('sospos')
      AND externaltable in ('labzuord')
	  and externaltabpk in ('%3253270-%')
LIMIT 100;


