module Main where

import Database.HDBC.PostgreSQL (connectPostgreSQL)
-- import Database.HDBC.Sqlite3 (connectSqlite3)
import Database.HDBC

main = query 1000

sql_to_string :: SqlValue -> String
sql_to_string sql_value = case fromSql sql_value of
                            Just x -> x
                            Nothing -> "NULL"

query :: Int -> IO ()
query limit =
  do
--    conn <- connectSqlite3 "sqlite3.db"
    conn <- connectPostgreSQL "user=svk password=svk host=localhost port=5432 dbname=haskell"

    -- Run the query and store the results in r
    r <- quickQuery' conn
           "SELECT * FROM \"Quote\" ORDER BY datetime DESC LIMIT ?"
           [toSql limit]

    -- Convert each row into a String
    let stringRows = map convRow r

    -- Print the rows out
    mapM_ putStrLn stringRows

    -- And disconnect from the database
    disconnect conn
  where convRow :: [SqlValue] -> String
        convRow sql_values =
            foldl1 (++) (map sql_to_string sql_values)

