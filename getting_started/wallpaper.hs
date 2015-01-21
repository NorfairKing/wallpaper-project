{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Wallpaper.Wallpaper (Config (..), wallpaper)

import           Text.Blaze.Html     (string)
import           Text.Blaze.Html5    (Html (..), body, br, html)
import qualified Text.Blaze.Html5    as H (head, title)

import           System.Time         (ClockTime (..), getClockTime)


main :: IO ()
main = wallpaper example


data ExampleData = Data { currentTime :: ClockTime }

exampleParser :: IO ExampleData
exampleParser = do
    t <- getClockTime
    return Data { currentTime = t }


exampleGenerator :: ExampleData -> Html
exampleGenerator d = html $ do
    H.head $ do
        H.title "Page title"
    body $ do
        string "Welcome to your wallpaper project"
        br
        string $ "Now: " ++ show (currentTime d)

example :: Config ExampleData
example = Config {
        generator = exampleGenerator
    ,   parser = exampleParser
    }
