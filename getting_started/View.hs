{-# LANGUAGE OverloadedStrings #-}

module View where

import           Model

import           Text.Blaze.Html5    (Html (..))
import qualified Text.Blaze.Html5    as H (body, head, html, p, pre, title)

import           Wallpaper.ViewUtils (css)

view :: Model -> Html
view m = H.html $ do
    css "wallpaper.css"
    H.head $ do
       H.title "Title"
    H.body $ do
        H.p "Welcome to your wallpaper project"
        H.p "To get started, you should link the wallpaper command to some place in your $PATH:"
        H.pre "ln -s ~/.wpp/wallpaper.bin /usr/bin"
        H.p $ "To change the data you use, edit " >>  H.pre "Model.hs"
        H.p $ "To change what data is parsed, edit " >>  H.pre "Parser.hs"
        H.p $ "To change what is redered, edit " >>  H.pre "View.hs"

