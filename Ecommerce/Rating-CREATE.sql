CREATE TABLE IF NOT EXISTS rating(
RAT_ID int NOT NULL,
ORD_ID int NOT NULL,
RAT_RATSTARS INT NOT NULL,
PRIMARY KEY (RAT_ID),
FOREIGN KEY (ORD_ID) REFERENCES ORDER1 (ORD_ID));