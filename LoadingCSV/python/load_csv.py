import sys
import os

PATH = os.path.dirname(os.path.dirname(os.path.dirname(os.path.realpath(__file__))))
sys.path.append(PATH)

from GettingStarted.python.Neo4jConnection import Neo4jConnection
import pandas as pd

if __name__ == "__main__":
    conn = Neo4jConnection(uri="bolt://localhost:7687", user="neo4j", pwd="moviedb")

    users = f"""
    LOAD CSV WITH HEADERS FROM 'file:///users.csv' AS row
    MERGE (u:User {{name:row.Name, fav_genre:row.Fav_genre, preferred_language:row.Preferred_language, uid:row.uid}})
    MERGE (m:Movies {{title: row.Seen, mid:row.mid}})
    MERGE (u)-[:seen {{liked:row.Liked, rated:row.Rated}}]->(m)
    """
    users_load = conn.query(query=users, db="moviescsv")

    movie = f"""
    LOAD CSV WITH HEADERS FROM 'file:///movies.csv' AS row
    MATCH (m:Movies {{mid:row.mid}})
    SET m.rating = row.rating 
    SET m.released = row.released 
    SET m.genre = row.genre 
    SET m.language = row.language
    """
    movies_set = conn.query(query=movie, db="moviescsv")

    follows = f"""
    LOAD CSV WITH HEADERS FROM 'file:///follows.csv' as row
    MATCH (u:User {{uid:row.uid}}), (f_u:User {{uid:row.f_uid}})
    MERGE (u)-[:follows {{since:row.since}}]->(f_u)
    """
    follows_exec = conn.query(query=follows, db="moviescsv")

    final_q = f"""
    MATCH (u:User)-[s:seen]->(m:Movies) return u.name as user, u.fav_genre as fav_genre,m.title as seen_movie,
    m.released as released_year, s.liked as liked, s.rated as rated, m.genre as movie_genre, m.rating as movie_rating
    """
    df = pd.DataFrame([dict(_) for _ in conn.query(query=final_q, db="moviescsv")])
    print(df)
