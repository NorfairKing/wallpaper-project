module Wallpaper.Wallpaper (
          Config(..)
        , wallpaper
    ) where

import           System.FilePath.Posix           ((<.>), (</>))
import           System.IO                       (writeFile)
import           System.Posix.Env                (setEnv)
import           System.Process                  (callCommand)
import           Text.Blaze.Html.Renderer.Pretty (renderHtml)

import           Text.Blaze.Html5                (Html (..))


data Config d = Config {
      viewer  :: d -> Html
    , parser  :: IO d
    , rootDir :: FilePath
    }

wallpaperFileName :: String
wallpaperFileName = "wallpaper"

call :: String -> IO ()
call cmd = do
    putStrLn cmd
    callCommand cmd

generateImage :: FilePath -> FilePath -> IO ()
generateImage html png = call generateCmd
    where
        generateCmd = unwords $ fakeXServerBin:fakeXServerArgs ++ generateBin:generateFlags ++ generateArgs
        fakeXServerBin = "xvfb-run"
        fakeXServerArgs = [
                                "--auto-servernum"
                            ,   "--server-args=" ++ show fakeXServerScreen
                          ]
        fakeXServerScreen = "-screen 0, " ++ width ++ "x" ++ height ++ "x16"
        generateBin = "wkhtmltoimage"
        generateFlags = [
                            "--format", "png"
                        ,   "--width" , width
                        ,   "--height", height
                        ,   "--quality", show 100
                        ]
        generateArgs = [generateInputHtml, generateOutputPng]
        generateInputHtml = html
        generateOutputPng = png
        width = "1920"
        height = "1080"

putUpWallpaper :: FilePath -> IO ()
putUpWallpaper png = call putCmd
    where
        putCmd = unwords $ putBin: putFlags
        putBin = "feh"
        putFlags = ["--bg-fill", putInputPng]
        putInputPng = png

wallpaper :: Config a -> IO ()
wallpaper c = do

    -- Set the screen to display the wallpaper on
    setEnv "DISPLAY" ":0" False

    -- generate html
    dat <- parser c
    let html = renderHtml $ (viewer c) dat
    writeFile wallpaperHtmlFile html

    -- Generate wallpaper
    generateImage wallpaperHtmlFile wallpaperPngFile

    -- Put up wallpaper
    putUpWallpaper wallpaperPngFile

    where
        wallpaperHtmlFile = root </> wallpaperFileName <.> "html"
        wallpaperPngFile  = root </> wallpaperFileName <.> "png"
        root = rootDir c

