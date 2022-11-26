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

number :: TextGenCh
number = choose $ map word [
    "two", "three", "four", "five", "six", "seven", "eight", "nine",
    "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen",
    "sixteen", "seventeen", "eighteen", "nineteen", "twenty",
    "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"
    ]


building :: Vocab -> TextGenCh
building v = list [ preface, room1, room2, room3, room4, room5, room6 ]
    where preface = list [ v "building", word ":" ]
          room1 = chamber v
          room2 = chamber v
          room3 = perhaps (1, 2) (chamber v)
          room4 = perhaps (1, 2) (chamber v)
          room5 = perhaps (1, 2) (chamber v)
          room6 = perhaps (1, 2) (chamber v)


chamber :: Vocab -> TextGenCh
chamber v = list [ lineament1, lineament2, lineament3, lineament4, lineament5 ]
    where lineament1 = lineament v
          lineament2 = lineament v
          lineament3 = lineament v
          lineament4 = perhaps (1, 2) $ lineament v
          lineament5 = perhaps (1, 2) $ lineament v


-- need a starting phrase
lineament :: Vocab -> TextGenCh
lineament v = list [ detail1, detail2, detail3, detail4, detail5, detail6 ]
    where detail1 = details v
          detail2 = spatialdetails v
          detail3 = spatialdetails v
          detail4 = perhaps (1, 2) $ spatialdetails v
          detail5 = perhaps (1, 2) $ spatialdetails v
          detail6 = perhaps (1, 2) $ spatialdetails v


spatialdetails :: Vocab -> TextGenCh
spatialdetails v = list [ v "spatial", word "these were", details v ]

details :: Vocab -> TextGenCh
details v = list [ number, v "details", madeof, stone v, phyperbole ]
    where madeof = choose $ map word [ "of", "made of", "carved from" ]
          phyperbole = perhaps (1, 3) (hyperbole v)


sentence :: TextGenCh -> TextGenCh
sentence t = list [ t, word "." ]


describe :: Vocab -> TextGenCh -> TextGenCh
describe v building = list [ iwilldesc, word "this", building, reason ]
    where iwilldesc = list [ word "I will", perhaps (1, 2) (v "quickly"), word "describe"]
          reason = list []
          

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
stone v = choose [ plain, coloured, comparative ]
    where plain = v "stone"
          coloured = list [ v "colour", v "stone" ]
          comparative = list [ v "stone", word "the colour of", v "substance"]


poliphili :: Vocab -> TextGenCh
poliphili v = building v



