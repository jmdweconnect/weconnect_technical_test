SELECT
    car.name AS carrier
    , MAX(flt.price) AS max_price
FROM Flights AS flt

LEFT JOIN carriers AS car
    ON flt.carrier_id = car.cid

WHERE flt.origin_city IN  ('Seattle WA', 'New York NY')
    AND flt.dest_city IN ('Seattle WA', 'New York NY')

GROUP BY carrier;


-- Query Time: not available
-- Result set:
-- "American Airlines Inc.",991
-- "Delta Air Lines Inc.",999
-- "JetBlue Airways",996