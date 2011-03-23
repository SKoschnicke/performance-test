{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
import Database.Persist.Postgresql
--import Database.Persist.Sqlite
import Control.Monad.IO.Class
import Data.Time

mkPersist [$persist|
User
    ident String
    password String Maybe Update
    UniqueUser ident
Email
    email String
    user UserId Maybe Update
    verkey String Maybe Update
    UniqueEmail email
Quote
    datetime UTCTime Desc
    value Double
    created_at UTCTime
    updated_at UTCTime
    object_with_quotes_id Int
    object_with_quotes_type String
    source String
    stock_market String
    currency_id Int
|]

-- | The database connection string. The meaning of this string is backend-
-- specific.
connStr :: String
connStr = "user=svk password=svk host=localhost port=5432 dbname=haskell"
-- connStr = "sqlite3.db"

connectionCount :: Int
connectionCount = 1

main :: IO ()
--main = withSqlitePool connStr connectionCount $ runSqlPool go
main = withPostgresqlPool connStr connectionCount $ runSqlPool go

go :: SqlPersist IO ()
go = do
  quotes <- selectList [] [QuoteDatetimeDesc] 1000 0
  liftIO $ print quotes
