MATCH (n) DETACH DELETE n;
CREATE (endgame:Movie {title:"Endgame", released:2018, rating:8.5, genre:"Action, Scify, Drama", language:"English"})
CREATE (shantinivasa:Movie {title:"Shantinivasa", released:2007, rating:7.5, genre:"Drama, Comedy, Musical", language:"Kannada"})
CREATE (dhanush:User {title:"Dhanush", fav_genre:"Action, Drama, Comedy, Romance, Scify, Fantasy, Musical", preferred_language:"Kannada, Hindi, English, Telugu"})
CREATE (sagar:User {title:"Sagar", fav_genre:"Action, Drama, Comedy, Romance,", preferred_language:"Kannada, Hindi, English, Telugu, Tamil, Malayalam"})
CREATE (dhanush)-[:seen {liked:TRUE, rated:9.5}]->(endgame)
CREATE (dhanush)-[:seen {liked:TRUE, rated:7}]->(shantinivasa)
CREATE (sagar)-[:seen {liked:TRUE, rated:8.5}]->(shantinivasa)
CREATE (dhanush)-[:follows {since:2015}]->(sagar)
CREATE (sagar)-[:follows {since:2015}]->(dhanush)
CREATE (shivajirao:User {title:"Shivaji Rao", fav_genre: "Action, Drama, Comedy", preferred_language:"Kannada, Hindi"})
CREATE (usha:User {title:"Usha", fav_genre: "Romance, Drama, Comedy", preferred_language:"Kannada, Hindi"})
CREATE (usha)-[:follows {since:1989}]->(shivajirao)-[:follows {since:1989}]->(usha)
CREATE (humraaz:Movie {title:"Humraaz", released:2002, rating:6.5, genre:"Thriller, Romance", language:"Hindi"})
CREATE (garudarekhe:Movie {title:"Garuda Rekhe", released:1982, rating:8.6, genre:"N/A", language:"Kannada"})
CREATE 
	(usha)-[:seen {liked:TRUE, rated:8.5}]->(humraaz)<-[:seen {liked:FALSE, rated:4.5}]-(shivajirao),
	(usha)-[:seen {liked:TRUE, rated:7.5}]->(garudarekhe)<-[:seen {liked:TRUE, rated:9.5}]-(shivajirao),
	(usha)-[:follows {since:2015}]->(dhanush)<-{:follows {since:2016}}-(shivajirao)-[:follows {since:2015}]->(sagar)-[:follows {since:2015}]->(usha)<-[:follows {since:2015}]-(dhanush)
