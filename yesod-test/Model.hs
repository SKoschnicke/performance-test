{-# LANGUAGE QuasiQuotes, TypeFamilies, GeneralizedNewtypeDeriving, TemplateHaskell #-}
module Model where

import Yesod
import Database.Persist.TH (share2)
import Database.Persist.GenericSql (mkMigrate)
import Data.Time


-- You can define all of your database entities here. You can find more
-- information on persistent and how to declare entities at:
-- http://docs.yesodweb.com/book/persistent/
share2 mkPersist (mkMigrate "migrateAll") [persist|
User
    ident String
    password String Maybe Update
    UniqueUser ident
Email
    email String
    user UserId Maybe Update
    verkey String Maybe Update
    UniqueEmail email
Site
    url String
    created UTCTime default=now()
    UniqueSite url
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
    performance Bool
    incorrect Bool
|]
