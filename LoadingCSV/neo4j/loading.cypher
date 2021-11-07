// CSV files must be stored in import folder of the project.
LOAD CSV WITH HEADERS FROM 'file:///users.csv' AS row
MERGE (u:User {name:row.Name, fav_genre:row.Fav_genre, preferred_language:row.Preferred_language})
MERGE (m:Movies {title: row.Seen})
MERGE (u)-[:seen {liked:row.Liked, rated:row.Rated}]->(m)


LOAD CSV WITH HEADERS FROM 'file:///movies.csv' AS row
MATCH (m:Movies {title:row.title})
SET m.rating = row.rating 
SET m.released = row.released 
SET m.genre = row.genre 
SET m.language = row.language;


LOAD CSV WITH HEADERS FROM 'file:///follows.csv' as row
MATCH (u:User {{uid:row.uid}}), (f_u:User {{uid:row.f_uid}})
MERGE (u)-[:follows {{since:row.since}}]->(f_u)