module Main where

import           Model
import           Parser
import           View

import           Wallpaper.Wallpaper (Config (..), wallpaper)

main = wallpaper myConfig

myConfig = Config {
        parser = parse
    ,   viewer = view
    }
