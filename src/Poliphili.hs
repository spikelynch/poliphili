module Poliphili
    ( poliphili
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

negative :: Vocab -> TextGenCh
negative v = list [ suchas, propernoun, never, boasted ]
    where suchas = choose [ word "such as", word "that" ]
          propernoun = choose [ v "person", v "place" ]
          never = v "never"
          boasted = v "boasted"


excessive :: Vocab -> TextGenCh
excessive v = list [ v "superlative", word "than", v "goodthing" ]

hyperbole :: Vocab -> TextGenCh
hyperbole v = choose [ negative v, excessive v ]

stone :: Vocab -> TextGenCh
stone v = list [ perhaps (1, 2) (v "colour"), v "stone" ]

detail :: Vocab -> TextGenCh
detail v = list [ aan (v "detail"), word "of", stone v, perhaps (1, 4) (hyperbole v) ]

poliphili :: Vocab -> TextGenCh
poliphili v = detail v



