DROP TABLE albums;
DROP TABLE artists;

CREATE TABLE artists(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE albums(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  artist_id INT4 references artists(id)
);

