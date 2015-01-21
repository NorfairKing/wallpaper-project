module Wallpaper.Wallpaper (
          Config(..)
        , wallpaper
    ) where

import           System.IO                       (writeFile)
import           System.Process                  (callCommand)
import           Text.Blaze.Html.Renderer.Pretty (renderHtml)
import           Text.Blaze.Html5                (Html (..))



data Config d = Config {
      generator :: d -> Html
    , parser    :: IO d
    }

wallpaperFileName :: String
wallpaperFileName = "wallpaper"

generateImage :: FilePath -> FilePath -> IO ()
generateImage html png = callCommand generateCmd
    where
        generateCmd = unwords $ generateBin :generateFlags ++ [generateInputHtml, generateOutputPng]
        generateBin = "wkhtmltoimage"
        generateFlags = ["--width", width, "--height", height]
        generateInputHtml = html
        generateOutputPng = png
        width = "1920"
        height = "1080"

putUpWallpaper :: FilePath -> IO ()
putUpWallpaper png = callCommand putCmd
    where
        putCmd = unwords $ putBin: putFlags
        putBin = "feh"
        putFlags = ["--bg-fill", putInputPng]
        putInputPng = png

wallpaper :: Config a -> IO ()
wallpaper c = do

    -- generate html
    dat <- parser c
    let html = renderHtml $ (generator c) dat
    writeFile wallpaperHtmlFile html

    -- Generate wallpaper
    generateImage wallpaperHtmlFile wallpaperPngFile

    -- Put up wallpaper
    putUpWallpaper wallpaperPngFile

    where
        wallpaperHtmlFile = wallpaperFileName ++ ".html"
        wallpaperPngFile  = wallpaperFileName ++ ".png"

