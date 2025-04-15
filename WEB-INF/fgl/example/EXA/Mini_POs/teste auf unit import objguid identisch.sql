set search_path=hisinone;
select obj_guid, * from unit
where obj_guid in ('1c31efea-aa8c-4d96-9f60-cf752efa95a2')
Limit 100;