// Getting the details of the user who has seen the movie Garuda Rekhe.
MATCH (u:User)-[:seen]->(m:Movie {title: "Garuda Rekhe"}) RETURN u,m
// Getting the details of the user and movie who follows someone who has seen the Endgame Movie
MATCH (u:User)-[:follows]->(u2:User)-[s:seen]->(m:Movie {title:"Endgame"}) RETURN u,u2,m,s.liked