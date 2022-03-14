CREATE DATABASE HUD_UserBase;

CREATE TABLE user{
    user_id INT NOT NULL PRIMARY KEY,
    username VARCHAR(16) NOT NULL UNIQUE,
    user_email VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(16) NOT NULL
    
};

CREATE TABLE follow_publisher{
    publisher_id INT NOT NULL,
    user_id INT NOT NULL,
    PRIMARY KEY(publisher_id, user_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id)
};

CREATE TABLE follow_game{
    game_id INT NOT NULL,
    user_id INT NOT NULL,
    PRIMARY KEY (game_id, user_id),
    FOREIGN KEY (game_id) REFERENCES game(game_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id)
};

CREATE TABLE publisher{
    publisher_id INT NOT NULL PRIMARY KEY,
    publisher_name VARCHAR(50)
};

CREATE TABLE game{
    game_id INT NOT NULL PRIMARY KEY,
    publisher_id INT NOT NULL,
    game_title VARCHAR(50) NOT NULL,
    game_desc TEXT,
    PRIMARY KEY(publisher_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
};

CREATE TABLE game_region{
    game_id INT NOT NULL,
    region_id INT NOT NULL,
    price NUMERIC(20, 2) NOT NULL,
    sale NUMERIC(2, 2),
    PRIMARY KEY(game_id, region_id),
    FOREIGN KEY (game_id) REFERENCES game(game_id),
    FOREIGN KEY (region_id) REFERENCES region(region_id)
};

CREATE TABLE region{
    region_id INT NOT NULL PRIMARY KEY,
    region_name VARCHAR(50)
};

CREATE TABLE genre{
    genre_id INT NOT NULL PRIMARY KEY,
    genre_name VARCHAR(20) NOT NULL,    
    genre_desc TEXT
};

CREATE TABLE genres{
    genre_id INT NOT NULL,
    game_id INT NOT NULL,
    PRIMARY KEY (genre_id, game_id)
    FOREIGN KEY (genre_id) REFERENCES genre(genre_id),
    FOREIGN KEY (game_id) REFERENCES genre(game_id)
};

CREATE TABLE platform{
    platform_id INT NOT NULL PRIMARY KEY,
    platform_name VARCHAR(50) NOT NULL,
};

CREATE TABLE platforms{
    platform_id INT NOT NULL,
    game_id INT NOT NULL,
    PRIMARY KEY (platform_id, game_id),
    FOREIGN KEY (platform_id) REFERENCES platform(platform_id),
    FOREIGN KEY (game_id) REFERENCES game(game_id)
};
