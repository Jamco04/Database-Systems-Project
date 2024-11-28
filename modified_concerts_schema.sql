CREATE TABLE artists (
  artist_id INTEGER(10) PRIMARY KEY,  
  artist_name VARCHAR(128),
  genre VARCHAR(64),
  debut_year YEAR

   total_revenue DECIMAL(10, 2) DEFAULT 0
);

CREATE TABLE albums (
  album_id INTEGER(10) PRIMARY KEY,
  album_title VARCHAR(256),
  release_date DATE
);

CREATE TABLE artist_album (
  album_id INTEGER(10),
  artist_id INTEGER(10),
  PRIMARY KEY (album_id, artist_id),
  FOREIGN KEY (album_id) REFERENCES albums(album_id),
  FOREIGN KEY (artist_id) REFERENCES artists(artist_id)
);

CREATE TABLE songs (
  song_id INTEGER(10) PRIMARY KEY,
  album_id INTEGER(10),
  song_title VARCHAR(128),
  length REAL,
  release_date DATE,
  FOREIGN KEY (album_id) REFERENCES albums(album_id)
);

CREATE TABLE song_artists (
  song_id INTEGER(10),
  artist_id INTEGER(10),
  PRIMARY KEY (song_id, artist_id),
  FOREIGN KEY (song_id) REFERENCES songs(song_id),
  FOREIGN KEY (artist_id) REFERENCES artists(artist_id)
);

CREATE TABLE concerts (
  concert_id INTEGER(10) PRIMARY KEY,
  concert_title VARCHAR(256),
  location VARCHAR(256),
  date_of_concert DATE
);

CREATE TABLE concert_artists (
  concert_id INTEGER(10),
  artist_id INTEGER(10),
  PRIMARY KEY (concert_id, artist_id),
  FOREIGN KEY (concert_id) REFERENCES concerts(concert_id),
  FOREIGN KEY (artist_id) REFERENCES artists(artist_id)
);

CREATE TABLE concert_songs (
  concert_id INTEGER(10),
  song_id INTEGER(10),
  order_performance TINYINT(4),
  PRIMARY KEY (concert_id, song_id),
  FOREIGN KEY (concert_id) REFERENCES concerts(concert_id),
  FOREIGN KEY (song_id) REFERENCES songs(song_id)
);

CREATE TABLE concert_tickets (
  ticket_id INTEGER(10) PRIMARY KEY,
  concert_id INTEGER(10),
  seat_zone VARCHAR(16),
  seat_number VARCHAR(16),
  purchase_date DATE,
  ticket_price DOUBLE,
  FOREIGN KEY (concert_id) REFERENCES concerts(concert_id)
);

CREATE TABLE fans (
  fan_id INTEGER(10) PRIMARY KEY,  
  fan_name VARCHAR(128),
  fan_email VARCHAR(128),
  age TINYINT(3)
);


CREATE TABLE fans_ticket (
  ticket_id INTEGER(10),
  fan_id INTEGER(10),
  PRIMARY KEY (ticket_id, fan_id),
  FOREIGN KEY (ticket_id) REFERENCES concert_tickets(ticket_id),
  FOREIGN KEY (fan_id) REFERENCES fans(fan_id)
);

CREATE TABLE fan_favorite_artists (
  fan_id INTEGER(10),              
  artist_id INTEGER(10),            
  PRIMARY KEY (fan_id, artist_id),  
  FOREIGN KEY (fan_id) REFERENCES fans(fan_id),  
  FOREIGN KEY (artist_id) REFERENCES artists(artist_id)  
);



