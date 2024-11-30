DELETE v
FROM
    vouchers v
INNER JOIN
    working_class_heroes w
ON
    v.working_class_hero_id = w.id
WHERE
    w.natid = 'value_natid';