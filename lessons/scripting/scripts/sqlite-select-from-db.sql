.mode csv
.header on
SELECT species.genus, species.species AS speciesname, surveys.*
FROM surveys
JOIN species ON surveys.species = species.species_id
WHERE species.taxa = 'Rodent';
