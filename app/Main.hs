module Main (main) where

import Control.Monad (mapM)
import Control.Monad.Loops (iterateUntil)
import Text.Read (readMaybe)
import System.Random
import System.Environment (getArgs)
import qualified Data.Text as T
import qualified Data.Text.IO as Tio

import TextGen (
  Vocab,
  runTextGen,
  loadVocab,
  smartjoin,
  upcase
  )


import Poliphili (poliphili)

default_max_length :: Int
default_max_length = 140


getDir (x:xs) = x
getDir _      = "./"


maxLength :: [ String ] -> Int
maxLength (a:b:cs) = case readMaybe b of
  (Just i) -> i
  Nothing  -> default_max_length
maxLength _        = default_max_length


generate :: Vocab -> Int -> IO ()
generate v remain = do
  sentence <- getStdRandom $ runTextGen $ poliphili v
  output <- return $ upcase $ smartjoin sentence
  putStrLn output
  putStrLn "\n"
  generate v remain
  
main :: IO ()
main = do
  args <- getArgs
  v <- loadVocab (getDir args)
  generate v 10000
