import sys
import os

PATH = os.path.dirname(os.path.dirname(os.path.dirname(os.path.realpath(__file__))))
sys.path.append(PATH)

from GettingStarted.python.Neo4jConnection import Neo4jConnection


if __name__ == "__main__":
    conn = Neo4jConnection(uri="bolt://localhost:7687", user="neo4j", pwd="moviedb")

    users = f"""
    LOAD CSV WITH HEADERS FROM 'file:///users.csv' AS row
    MERGE (u:User {{name:row.Name, fav_genre:row.Fav_genre, preferred_language:row.Preferred_language}})
    MERGE (m:Movies {{title: row.Seen}})
    MERGE (u)-[:seen {{liked:row.Liked, rated:row.Rated}}]->(m)
    """
    users_load = conn.query(query=users, db="moviescsv")
    print(users_load)
    movie = f"""
    LOAD CSV WITH HEADERS FROM 'file:///movies.csv' AS row
    MATCH (m:Movies {{title:row.title}})
    SET m.rating = row.rating 
    SET m.released = row.released 
    SET m.genre = row.genre 
    SET m.language = row.language
    """
    movies_set = conn.query(query=movie, db="moviescsv")
    print(movies_set)
