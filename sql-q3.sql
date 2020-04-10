SELECT 
    dest_1.dest_city AS city
FROM
    (
    SELECT DISTINCT dest_city
    FROM flights as flt1
    WHERE dest_city <> 'Seattle WA'
          AND origin_city <> 'Seattle WA'
    ) as dest_1

    LEFT JOIN
        (SELECT
             origin_city
             , dest_city
         FROM flights
         WHERE origin_city = 'Seattle WA'
         GROUP BY 1, 2
        ) as orig
        
    ON dest_1.dest_city = orig.dest_city
       OR orig.dest_city IS NULL

    LEFT JOIN
        (SELECT
             subb.origin_city
             , subb.dest_city
         FROM flights as suba

         LEFT JOIN flights as subb
            ON suba.dest_city = subb.origin_city

         WHERE suba.origin_city = 'Seattle WA'
             AND suba.dest_city <> 'Seattle WA'
             AND subb.origin_city <> 'Seattle WA'
             AND subb.dest_city <> 'Seattle WA'
         GROUP BY 1, 2
        ) as orig_2
        
    ON dest_1.dest_city = orig_2.dest_city
       OR orig_2.dest_city IS NULL

WHERE orig.dest_city IS NULL
AND orig_2.origin_city IS NULL

ORDER BY city ASC
;

--"Hattiesburg/Laurel MS"
-- "St. Augustine FL"
-- "Devils Lake ND"



------------------------------------------------------------------
------------------------------------------------------------------
------------------------------------------------------------------
/* This should be the less performant option
However I was not able to get either of these queries to be performant
nor could I make any attempts at optimization.
My computer continued to crash from memory constraints
*/


SELECT DISTINCT
    dest_city as city

FROM flights as flt

WHERE flt.dest_city NOT IN
          (SELECT DISTINCT
            suba.dest_city
            FROM flights as suba
            WHERE suba.origin_city = 'Seattle WA')

AND flt.dest_city NOT IN
        (SELECT DISTINCT
            subc.dest_city
            FROM flights as subb

            LEFT JOIN flights AS subc
                ON subb.dest_city = subc.origin_city
                AND subc.dest_city NOT IN
                      (SELECT DISTINCT
                        subd.dest_city
                        FROM flights as subd
                        WHERE subd.origin_city = 'Seattle WA')

            WHERE subb.origin_city = 'Seattle WA'
                AND subb.dest_city <> 'Seattle WA'

                AND subc.origin_city <> 'Seattle WA'
                AND subc.dest_city <> 'Seattle WA'
        )
ORDER BY city ASC
;
-- "Seattle WA"
-- "Hattiesburg/Laurel MS"
-- "St. Augustine FL"
-- "Devils Lake ND"