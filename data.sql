/*Insert Artists*/
INSERT INTO artists (artist_id, artist_name, genre, debut_year) 
VALUES 
(1, 'The Beatles', 'Rock', 1960),
(2, 'EricDOA', 'Rap', 2020),
(3, 'Taylor Swift', 'Pop', 2006);

/*Insert Albums*/
INSERT INTO albums (album_id, album_title, release_date) 
VALUES 
(1, 'Abbey Road', '1969-09-26'),
(2, 'Crisis', '2022-06-17'),
(3, '1989', '2014-10-27');

/*Insert Artist-Album Relations*/
INSERT INTO artist_album (album_id, artist_id) 
VALUES 
(1, 1),
(1, 3), -- The Beatles - album: Abbey Road (ft. Taylor Swift)
(2, 2),
(3, 3);


/*Insert Songs*/
INSERT INTO songs (song_id, album_id, song_title, length, release_date)
VALUES 
(1, 1, 'Come Together', 4.20, '1969-09-26'),
(2, 1, 'Something', 3.03, '1969-09-26'),
(3, 2, 'Crisis', 3.10, '2022-06-17'),
(4, 2, 'DoA', 2.50, '2022-06-17'),
(5, 3, 'Shake It Off', 3.39, '2014-10-27');

/*Insert Song-Artist Relations*/
INSERT INTO song_artists (song_id, artist_id) 
VALUES 
(1, 1),
(1, 3), -- The Beatles - Come Together (ft. Taylor Swift)
(2, 1),
(3, 2),
(4, 2);

/*Insert Concerts*/
INSERT INTO concerts (concert_id, concert_title, location, date_of_concert)
VALUES 
(1, 'The Beatles Live', 'London', '2024-12-01'),
(2, 'EricDOA Live', 'New York', '2024-12-05'),
(3, 'Taylor Swift Live', 'Los Angeles', '2024-12-10');

/*Insert Concert-Artist Relations*/
INSERT INTO concert_artists (concert_id, artist_id)
VALUES 
(1, 1),
(1, 3), -- Taylor joined The Beatles Live
(2, 2),
(3, 3);

/*Insert Concert-Song Relations*/
INSERT INTO concert_songs (concert_id, song_id, order_performance)
VALUES 
(1, 1, 1),
(1, 2, 2),
(1, 5, 3),  -- Shake it off at The Beatles Live
(2, 3, 1),
(2, 4, 2),
(3, 5, 1);

/*Insert Concert Tickets*/
INSERT INTO concert_tickets (ticket_id, concert_id, seat_zone, seat_number, purchase_date, ticket_price)
VALUES 
(1, 1, 'Front Row', 'A1', '2024-11-25', 150.00),
(2, 1, 'Back Row', 'C20', '2024-11-25', 80.00),
(3, 2, 'Front Row', 'B5', '2024-11-27', 120.00),
(4, 2, 'Back Row', 'D10', '2024-11-27', 70.00),
(5, 3, 'VIP Section', 'V1', '2024-11-30', 200.00);

/*Insert Fans*/
INSERT INTO fans (fan_id, fan_name, fan_email, age)
VALUES 
(1, 'Adam Urban', 'adamurban@gmail.com', 20),
(2, 'James Connolly', 'jamesconnolly@gmail.com', 15),
(3, 'Enda Buckley', 'endabuckley@hotmail.com', 29);

/*Insert Fans-Ticket Relations*/
INSERT INTO fans_ticket (ticket_id, fan_id)
VALUES 
(1, 1),
(1, 3),  -- shared ticket
(2, 1),
(3, 2),
(4, 2),
(5, 3);

/*Insert Fan-Favorite Artists*/
INSERT INTO fan_favorite_artists (fan_id, artist_id)
VALUES 
(1, 2),
(1, 3),
(2, 2),
(3, 3);
