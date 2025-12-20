set search_path='hisinone';

SELECT root_element.root_unit_defaulttext root_text, root_element.root_unit_id root_unit_id, parent.elementnr parent_nr, parent.defaulttext parent_text, rel.parent_unit_id parent_unit_id, sortorder, COUNT(*)
FROM unitrelation rel
Join unit parent on parent.id = rel.parent_unit_id
INNER JOIN (
WITH RECURSIVE Nodes AS (
SELECT node.*, root_unit_elementtype, root_unit_id, root_unit_defaulttext, 0 AS sortorder, 0 AS parent_id ,0 AS level, ARRAY[node.id] AS path, Array[0] AS forest_sorting, ARRAY[ROW(0,node.id)] AS cycle_path, false AS cycle
FROM unit node
INNER JOIN (
SELECT root_unit.id root_unit_id, root_unit.defaulttext root_unit_defaulttext , root_unit.k_elementtype_id root_unit_elementtype FROM unit root_unit
INNER JOIN k_elementtype ON k_elementtype.id = root_unit.k_elementtype_id
WHERE k_elementtype.hiskey_id IN (1,4,10)
) recursive_sql ON node.id = recursive_sql.root_unit_id
WHERE node.id = recursive_sql.root_unit_id
UNION ALL SELECT node.*, root_unit_elementtype, root_unit_id, root_unit_defaulttext, rel.sortorder, rel.parent_unit_id, level+1, path || node.id, forest_sorting || rel.sortorder, cycle_path || ROW(rel.parent_unit_id, rel.child_unit_id), ROW(rel.child_unit_id, rel.parent_unit_id) = ANY(cycle_path)
FROM unit node
INNER JOIN unitrelation rel ON rel.child_unit_id = node.id
INNER JOIN Nodes nodes ON rel.parent_unit_id = nodes.id
WHERE NOT cycle )
SELECT DISTINCT id unit_id, root_unit_id, root_unit_defaulttext, root_unit_elementtype FROM nodes order by root_unit_elementtype
) root_element on root_element.unit_id = rel.parent_unit_id
WHERE parent_unit_id IS NOT NULL
GROUP BY root_element.root_unit_defaulttext, root_element.root_unit_id, parent.elementnr, parent.defaulttext, parent_unit_id, sortorder
HAVING ( COUNT(*) > 1 )

----
UPDATE unitrelation update_relation
SET sortorder = row_num
FROM unitrelation relation INNER JOIN (
SELECT DISTINCT oo.id, oo.parent_unit_id, oo.child_unit_id, oo.sortorder, DENSE_RANK() over(PARTITION BY oo.parent_unit_id ORDER BY oo.id) as row_num
FROM unitrelation oo INNER JOIN (
SELECT o.parent_unit_id, o.child_unit_id
FROM unitrelation o INNER JOIN (
SELECT parent_unit_id, sortorder, COUNT(*)
FROM unitrelation
GROUP BY parent_unit_id, sortorder
HAVING ( COUNT(*) > 1 )
) i ON o.parent_unit_id = i.parent_unit_id and o.sortorder = i.sortorder
INNER JOIN unit parent ON parent.id = o.parent_unit_id
) ii ON oo.parent_unit_id = ii.parent_unit_id
ORDER BY oo.parent_unit_id
) false_relation ON false_relation.id = relation.id
WHERE relation.id = update_relation.id