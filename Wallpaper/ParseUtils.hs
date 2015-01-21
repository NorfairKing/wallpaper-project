module Wallpaper.ParseUtils (
    countFilesR
    ) where

import           Control.Monad    (filterM, liftM)
import           Data.List        (isSuffixOf, partition)

import           Pipes            (Producer (..), each, lift)

import           Pipes.Prelude    (toListM)
import           System.Directory (doesDirectoryExist, doesFileExist,
                                   getDirectoryContents)
import           System.FilePath  ((</>))

dirRWalker :: FilePath -> Producer FilePath IO ()
dirRWalker root = do
    cts <- lift $ getDirectoryContents root
    let paths = map (root </>) cts
    files <- filterM (lift . doesFileExist) paths
    dirs <- filterM (lift . realDir) paths
    each files
    mapM_ dirRWalker dirs
    where
        realDir x | ".." `isSuffixOf` x = return False
        realDir x | "." `isSuffixOf` x = return False
        realDir x = doesDirectoryExist x

countFilesR :: FilePath -> IO Int
countFilesR root = do
    files <- toListM $ dirRWalker root
    return $ length files

