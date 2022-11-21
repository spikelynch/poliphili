module Main (main) where

import TextGen (
  TextGen,
  Vocab,
  TextGenCh,
  runTextGen,
  word,
  aan,
  weighted,
  choose,
  list,
  randrep,
  perhaps,
  smartjoin,
  upcase,
  loadVocab
  )

import Control.Monad (forM)
import Control.Monad.Loops (iterateUntil)
import Data.List (intercalate)
import Data.Char (toUpper)
import Text.Read (readMaybe)
import System.Random
import System.Environment (getArgs)
import qualified Data.Text as T
import qualified Data.Text.IO as Tio

outfile = "hosts.txt"

nlines = 200

default_max_length :: Int
default_max_length = 140

architecture :: Vocab -> TextGenCh
architecture v = v "architecture"

getDir (x:xs) = x
getDir _      = "./"


maxLength :: [ String ] -> Int
maxLength (a:b:cs) = case readMaybe b of
  (Just i) -> i
  Nothing  -> default_max_length
maxLength _        = default_max_length

  
main :: IO ()
main = do
  args <- getArgs
  v <- loadVocab (getDir args)
  max_length <- return $ maxLength args
  archf <- return $ runTextGen $ architecture v
  result <- iterateUntil (\s -> length s <= max_length) $ do 
    band <- getStdRandom archf
    return $ upcase $ smartjoin band
  putStrLn result
