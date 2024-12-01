/*View of table*/

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


/*Before trigger*/

DELIMITER $$

CREATE TRIGGER before_insert_concert_tickets
BEFORE INSERT ON concert_tickets
FOR EACH ROW
BEGIN
    IF NEW.ticket_price > 500 THEN
        SET NEW.ticket_price = 500;
    END IF;
END$$

DELIMITER ;


/*After trigger*/

DELIMITER $$

CREATE TRIGGER after_insert_concert_tickets
AFTER INSERT ON concert_tickets
FOR EACH ROW
BEGIN
    DECLARE found_artist_id INT;

    SELECT ca.artist_id
    INTO found_artist_id
    FROM concert_artists ca
    WHERE ca.concert_id = NEW.concert_id
    LIMIT 1;

    IF found_artist_id IS NOT NULL THEN
        UPDATE artists
        SET total_revenue = IFNULL(total_revenue, 0) + NEW.ticket_price
        WHERE artist_id = found_artist_id;
    END IF;
END$$

DELIMITER ;

/*Stored Function*/

DELIMITER $$

CREATE FUNCTION total_occupied_seats(concert_id_input INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE seat_count INT;
    SET seat_count = 0;

    SELECT COUNT(ticket_id)
    INTO seat_count
    FROM concert_tickets
    WHERE concert_id = concert_id_input;

    RETURN seat_count;
END$$

DELIMITER ;


/*Stored Procedure*/

DELIMITER $$

CREATE PROCEDURE check_and_add_song_album(
    IN input_song_id INT,
    IN input_album_id INT
)
BEGIN
    DECLARE album_release_date DATE;
    DECLARE song_release_date DATE;
    DECLARE song_exists INT;

    SELECT COUNT(*) 
    INTO song_exists
    FROM songs
    WHERE song_id = input_song_id AND album_id = input_album_id;

    IF song_exists = 0 THEN
        UPDATE songs
        SET album_id = input_album_id
        WHERE song_id = input_song_id;
    END IF;

    SELECT release_date INTO album_release_date FROM albums WHERE album_id = input_album_id;
    SELECT release_date INTO song_release_date FROM songs WHERE song_id = input_song_id;

    IF song_release_date > album_release_date THEN
        UPDATE songs
        SET release_date = album_release_date
        WHERE song_id = input_song_id;
    END IF;
END$$

DELIMITER ;


