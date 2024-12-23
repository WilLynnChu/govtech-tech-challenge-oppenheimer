SELECT
	w.natid,
    v.name,
    v.voucher_type
FROM
    vouchers v
JOIN
    working_class_heroes w
ON
    v.working_class_hero_id = w.id
WHERE
    w.natid = 'value_natid'
    AND v.voucher_type = 'value_voucherType'
    AND v.name = 'value_voucherName';
    