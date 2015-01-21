{-# LANGUAGE OverloadedStrings #-}

module Wallpaper.ViewUtils (
      (!.)
    , (!#)
    , css
    ) where

import           Text.Blaze.Html5            (Attribute, AttributeValue,
                                              Html (..), (!))
import qualified Text.Blaze.Html5            as H (link)
import qualified Text.Blaze.Html5.Attributes as A (class_, href, id, rel, type_)
import           Text.Blaze.Internal         (Attributable)

-- | Add an class to an element.
(!.) :: (Attributable h) => h -> AttributeValue -> h
elem !. className = elem ! A.class_ className

-- | Add an id to an element.
(!#) :: (Attributable h) => h -> AttributeValue -> h
elem !# idName = elem ! A.id idName


-- | Link to a CSS stylesheet.
css :: AttributeValue -> Html
css link = H.link ! A.rel "stylesheet" ! A.type_ "text/css" ! A.href link
