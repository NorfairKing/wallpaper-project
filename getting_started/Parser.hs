module Parser where

import           Model

parse :: IO Model
parse = return Model { test = "hi" }
