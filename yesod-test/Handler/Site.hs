{-# LANGUAGE TemplateHaskell, QuasiQuotes, OverloadedStrings #-}
module Handler.Site where

import Test

-- This is a handler function for the GET request method on the RootR
-- resource pattern. All of your resource patterns are defined in
-- Test.hs; look for the line beginning with mkYesodData.
--
-- The majority of the code you will write in Yesod lives in these handler
-- functions. You can spread them across multiple files if you are so
-- inclined, or create a single monolithic file.
getSiteR :: Handler RepHtml
getSiteR = do
    mu <- maybeAuth
    defaultLayout $ do
        h2id <- lift newIdent
        setTitle "Site Listing"
        addWidget $(widgetFile "site-index")
