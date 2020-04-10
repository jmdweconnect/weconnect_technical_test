SELECT DISTINCT
    flight_num
FROM flights AS flt

LEFT JOIN carriers AS car
    ON flt.carrier_id = car.cid

LEFT JOIN weekdays as week
    on flt.day_of_week_id = week.did

WHERE flt.origin_city =  'Seattle WA'
    AND flt.dest_city = 'Boston MA'
    AND car.name = 'Alaska Airlines Inc.'
    AND week.day_of_week = 'Monday'
;

-- Query Time: Not available
-- Results:
-- 12
-- 24
-- 734