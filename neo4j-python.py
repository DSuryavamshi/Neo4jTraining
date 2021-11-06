from Neo4jConnection import Neo4jConnection
import pandas as pd

if __name__ == "__main__":
    conn = Neo4jConnection(uri="bolt://localhost:7687", user="neo4j", pwd="moviedb")
    movie = "Endgame"
    cql = f"""
    MATCH (u:User)-[:follows]->(u2:User)-[s:seen]->(m:Movie {{title:"{movie}"}})
    RETURN u.title as first_user,u2.title as second_user,m.title as movie_name,s.liked as liked
    """
    df = pd.DataFrame([dict(_) for _ in conn.query(cql, db="neo4j")])
    print(df)
