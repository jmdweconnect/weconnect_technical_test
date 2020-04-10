SELECT
    car.name AS carrier
    , MAX(flt.price) AS max_price
FROM Flights AS flt

LEFT JOIN carriers AS car
    ON flt.carrier_id = car.cid

WHERE flt.origin_city IN  ('Seattle WA', 'New York NY')
    AND flt.dest_city IN ('Seattle WA', 'New York NY')

GROUP BY carrier;