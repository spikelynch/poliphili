module Main (main) where

import Control.Monad (mapM, forM)
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


-- note - this separates sentences with newlines 
writeParagraph :: [[Char]] -> IO ()
writeParagraph (x:xs) = do
  putStrLn x
  writeParagraph xs
writeParagraph _ = putStrLn ""


generate :: Vocab -> Int -> IO ()
generate v remain = do
  generators <- return $ poliphili v
  rawSentences <- mapM (\g -> getStdRandom $ runTextGen g) generators
  sentences <- return $ map (upcase . smartjoin) rawSentences
  chars <- return $ sum $ map length sentences
  writeParagraph sentences
  l <- return (remain - chars)
  if l > 0 then generate v l else (putStrLn "***")

  
main :: IO ()
main = do
  args <- getArgs
  v <- loadVocab (getDir args)
  generate v 500000