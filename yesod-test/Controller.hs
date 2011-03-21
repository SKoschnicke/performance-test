{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module Controller
    ( withTest
    ) where

import Test
import Settings
import Yesod.Helpers.Static
import Yesod.Helpers.Auth
import Database.Persist.GenericSql
import Data.ByteString (ByteString)

-- Import all relevant handler modules here.
import Handler.Root
import Handler.Site
import Handler.Quote

-- This line actually creates our YesodSite instance. It is the second half
-- of the call to mkYesodData which occurs in Test.hs. Please see
-- the comments there for more details.
mkYesodDispatch "Test" resourcesTest

-- Some default handlers that ship with the Yesod site template. You will
-- very rarely need to modify this.
getFaviconR :: Handler ()
getFaviconR = sendFile "image/x-icon" "favicon.ico"

getRobotsR :: Handler RepPlain
getRobotsR = return $ RepPlain $ toContent ("User-agent: *" :: ByteString)

-- This function allocates resources (such as a database connection pool),
-- performs initialization and creates a WAI application. This is also the
-- place to put your migrate statements to have automatic database
-- migrations handled by Yesod.
withTest :: (Application -> IO a) -> IO a
withTest f = Settings.withConnectionPool $ \p -> do
    runConnectionPool (runMigration migrateAll) p
    let h = Test s p
    toWaiApp h >>= f
  where
    s = static Settings.staticdir
