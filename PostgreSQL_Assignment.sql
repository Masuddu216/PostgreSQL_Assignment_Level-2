-- Active: 1748120307514@@localhost@5432@conservation_db
CREATE DATABASE conservation_db;
DROP TABLE rangers;
DROP TABLE SPECIES;
DROP TABLE sightings;

CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL
);

INSERT INTO rangers (name, region) VALUES
('Abdul Karim', 'Sundarbans East'),
('Razia Sultana', 'Sundarbans West'),
('Jamal Uddin', 'Lawachara National Park'),
('Shirin Akter', 'Rema-Kalenga Wildlife Sanctuary'),
('Tariq Hasan', 'Chittagong Hill Tracts'),
('Nasima Khatun', 'Madhupur Forest'),
('Mohammad Fahim', 'Barind Tract Reserve');

SELECT * FROM rangers;

CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(150) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50) NOT NULL
);

INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Asian Elephant', 'Elephas maximus', '1758-01-01', 'Endangered'),
('Hoolock Gibbon', 'Hoolock hoolock', '1791-01-01', 'Endangered'),
('Fishing Cat', 'Prionailurus viverrinus', '1833-01-01', 'Vulnerable'),
('Ganges River Dolphin', 'Platanista gangetica', '1828-01-01', 'Endangered'),
('Leopard Cat', 'Prionailurus bengalensis', '1792-01-01', 'Least Concern'),
('Sloth Bear', 'Melursus ursinus', '1791-01-01', 'Vulnerable'),
('Smooth-coated Otter', 'Lutrogale perspicillata', '1826-01-01', 'Vulnerable'),
('Indian Pangolin', 'Manis crassicaudata', '1822-01-01', 'Endangered'),
('Black Softshell Turtle', 'Nilssonia nigricans', '1825-01-01', 'Critically Endangered'),
('Indian Rock Python', 'Python molurus', '1758-01-01', 'Near Threatened'),
('Mugger Crocodile', 'Crocodylus palustris', '1801-01-01', 'Vulnerable'),
('Greater Adjutant Stork', 'Leptoptilos dubius', '1786-01-01', 'Endangered'),
('Asian Openbill', 'Anastomus oscitans', '1758-01-01', 'Least Concern'),
('Jungle Cat', 'Felis chaus', '1776-01-01', 'Least Concern'),
('Indian Peafowl', 'Pavo cristatus', '1758-01-01', 'Least Concern'),
('Asian Black Bear', 'Ursus thibetanus', '1823-01-01', 'Vulnerable'),
('Asiatic Lion', 'Panthera leo persica', '1826-01-01', 'Endangered'),
('Indian Wolf', 'Canis lupus pallipes', '1821-01-01', 'Vulnerable'),
('Great Hornbill', 'Buceros bicornis', '1758-01-01', 'Near Threatened');

SELECT * FROM species;


CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    species_id INT NOT NULL,
    ranger_id INT NOT NULL,
    location VARCHAR(150) NOT NULL,
    sighting_time TIMESTAMP NOT NULL,
    notes TEXT,
    
    CONSTRAINT fk_species
        FOREIGN KEY (species_id)
        REFERENCES species(species_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_ranger
        FOREIGN KEY (ranger_id)
        REFERENCES rangers(ranger_id)
        ON DELETE CASCADE
);


INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Sundarbans Core Zone',         '2024-05-10 06:30:00', 'Fresh paw prints observed near waterhole'),
(2, 2, 'Sundarbans West Pass',        '2024-05-12 08:15:00', 'Adult elephant seen with calf'),
(3, 3, 'Lawachara Central Trail',      '2024-05-15 09:00:00', 'Pair of gibbons calling loudly'),
(4, 4, 'Rema Swamp Edge',              '2024-05-18 11:20:00', 'Seen hunting small fish'),
(5, 5, 'Kaptai Lake Shore',            '2024-05-20 07:45:00', 'Brief surfacing observed'),
(6, 1, 'Sundarbans Eastern Pass',     '2024-05-21 10:00:00', 'Nocturnal movement detected on camera trap'),
(7, 2, 'Chandpai Area',                '2024-05-22 14:25:00', 'Claw marks found on tree trunk'),
(8, 3, 'Lawachara Stream Bend',        '2024-05-23 13:10:00', 'Swimming observed in pairs'),
(9, 4, 'Rema Hillside Trail',          '2024-05-25 08:40:00', 'Seen foraging near termite mound'),
(10, 5, 'Rangamati Temple Area',       '2024-05-26 07:30:00', 'Resting on river bank'),
(11, 6, 'Madhupur Forest South',       '2024-05-28 17:10:00', 'Seen basking under sun'),
(12, 7, 'Pabna Wetlands',              '2024-05-30 12:00:00', 'Observed during nesting'),
(13, 1, 'Sundarbans East Watchtower',  '2024-06-01 06:45:00', 'Seen feeding on carrion'),
(14, 2, 'Satkhira Buffer Zone',        '2024-06-03 09:30:00', 'Flock in rice field'),
(15, 3, 'Lawachara East Sector',       '2024-06-05 11:55:00', 'Single cat spotted in bushes'),
(16, 6, 'Madhupur Elephant Pass',      '2024-06-07 08:50:00', 'Male displaying feathers'),
(17, 7, 'Barind Tract Hillside',       '2024-06-09 10:30:00', 'Tracks and droppings found nearby');

SELECT * FROM sightings;


-- 1️⃣ Register a new ranger with provided data with name = 'Derek Fox' and region = 'Coastal Plains'


INSERT INTO rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');
SELECT * FROM rangers;



-- 2️⃣ Count unique species ever sighted.

SELECT COUNT(*) AS unique_species_count
FROM (
    SELECT species_id
    FROM sightings
    GROUP BY species_id
) AS unique_species;


-- 3️⃣ Find all sightings where the location includes "Pass".
SELECT *
FROM sightings
WHERE location ILIKE '%Pass%';




-- 4️⃣ List each ranger's name and their total number of sightings.

SELECT rangers.name AS name, COUNT(sightings.sighting_id) AS total_sightings
FROM rangers
LEFT JOIN sightings ON rangers.ranger_id = sightings.ranger_id
GROUP BY rangers.name
ORDER BY total_sightings DESC;

-- 5️⃣ List species that have never been sighted.

SELECT species.common_name
FROM species
LEFT JOIN sightings ON species.species_id = sightings.species_id
WHERE sightings.species_id IS NULL;


-- 6️⃣ Show the most recent 2 sightings.

SELECT 
    species.common_name,
    sightings.sighting_time,
    rangers.name
FROM sightings
JOIN species ON sightings.species_id = species.species_id
JOIN rangers ON sightings.ranger_id = rangers.ranger_id
ORDER BY sightings.sighting_time DESC
LIMIT 3;

-- 7️⃣ Update all species discovered before year 1800 to have status 'Historic'.

UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';

DO $$
BEGIN
  RAISE NOTICE '(No output needed - this is an UPDATE operation)';
END
$$;

-- 8️⃣ Label each sighting's time of day as 'Morning', 'Afternoon', or 'Evening'.

SELECT 
  sighting_id,
  CASE 
    WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sighting_time) >= 12 AND EXTRACT(HOUR FROM sighting_time) <= 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_of_day
FROM sightings
ORDER BY sighting_id;

-- 9️⃣ Delete rangers who have never sighted any species

DELETE FROM rangers
WHERE ranger_id NOT IN (
  SELECT DISTINCT ranger_id FROM sightings
);

SELECT * FROM rangers;
