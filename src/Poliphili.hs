module Poliphili
    ( architecture
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


-- garden

--     lawn arrangement

--     plants

-- building

--     colonnade

--     facade

--     floor

--     ceiling

--     roof

--         detail

-- tomb

--    sad lover's story

-- nymphs

--   dresses

--   hairstyles

--   footwear

--   dances


architecture :: Vocab -> TextGenCh
architecture v = v "architecture"



