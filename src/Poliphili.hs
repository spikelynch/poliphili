module Poliphili
    ( someFunc
    ) where


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


outfile = "hosts.txt"

nlines = 200

default_max_length :: Int
default_max_length = 140

architecture :: Vocab -> TextGenCh
architecture v = v "architecture"



someFunc :: IO ()
someFunc = putStrLn "someFunc"
