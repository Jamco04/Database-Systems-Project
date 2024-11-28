--View of table

CREATE VIEW popular_artist_tours AS
SELECT 
    a.artist_name,
    SUM(ct.ticket_price) AS total_revenue
FROM 
    artists a
JOIN concert_artists ca ON a.artist_id = ca.artist_id
JOIN concerts c ON ca.concert_id = c.concert_id
JOIN concert_tickets ct ON c.concert_id = ct.concert_id
GROUP BY 
    a.artist_name
HAVING 
    SUM(ct.ticket_price) > 200;


--Before trigger

DELIMITER $$

CREATE TRIGGER before_insert_concert_tickets
BEFORE INSERT ON concert_tickets
FOR EACH ROW
BEGIN
    -- Check if the ticket price is greater than the allowed maximum ($500)
    IF NEW.ticket_price > 500 THEN
        -- If it is, set it to the maximum allowed price
        SET NEW.ticket_price = 500;
    END IF;
END$$

DELIMITER ;


--After trigger

DELIMITER $$

CREATE TRIGGER after_insert_concert_tickets
AFTER INSERT ON concert_tickets
FOR EACH ROW
BEGIN
    DECLARE artist_id INT;

table
    SELECT ca.artist_id
    INTO artist_id
    FROM concert_artists ca
    WHERE ca.concert_id = NEW.concert_id
    LIMIT 1;


    UPDATE artists
    SET total_revenue = IFNULL(total_revenue, 0) + NEW.ticket_price
    WHERE artist_id = artist_id;
END$$

DELIMITER ;

