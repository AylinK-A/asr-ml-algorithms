-- 1) Все алгоритмы с их "эрой"
SELECT algorithm_id, name, era FROM ALGORITHMS ORDER BY algorithm_id;

-- 2) Какие структурные единицы поддерживает каждый алгоритм
SELECT a.name AS algorithm, group_concat(su.unit, ', ') AS units
FROM ALGORITHMS a
JOIN ALGORITHM_STRUCTURAL_UNITS asu ON a.algorithm_id = asu.algorithm_id
JOIN STRUCTURAL_UNITS su ON su.unit_id = asu.unit_id
GROUP BY a.algorithm_id
ORDER BY a.name;

-- 3) Какие алгоритмы использует каждая система
SELECT sys.name AS system, group_concat(a.name, ', ') AS algorithms
FROM SYSTEMS sys
JOIN SYSTEMS_ALGORITHMS sa ON sa.system_id = sys.system_id
JOIN ALGORITHMS a ON a.algorithm_id = sa.algorithm_id
GROUP BY sys.system_id
ORDER BY sys.name;

-- 4) Системы, использующие алгоритмы "современной" эры
SELECT DISTINCT sys.name
FROM SYSTEMS sys
JOIN SYSTEMS_ALGORITHMS sa ON sa.system_id = sys.system_id
JOIN ALGORITHMS a ON a.algorithm_id = sa.algorithm_id
WHERE a.era = 'современная'
ORDER BY sys.name;

-- 5) Сколько систем использует каждый алгоритм
SELECT a.name, COUNT(*) AS systems_count
FROM ALGORITHMS a
LEFT JOIN SYSTEMS_ALGORITHMS sa ON sa.algorithm_id = a.algorithm_id
GROUP BY a.algorithm_id
ORDER BY systems_count DESC, a.name;

-- 6) Алгоритмы, работающие с контекст-зависимыми единицами (например, трифоны)
SELECT DISTINCT a.name
FROM ALGORITHMS a
JOIN ALGORITHM_STRUCTURAL_UNITS asu ON asu.algorithm_id = a.algorithm_id
JOIN STRUCTURAL_UNITS su ON su.unit_id = asu.unit_id
WHERE su.considers_context = 1
ORDER BY a.name;
