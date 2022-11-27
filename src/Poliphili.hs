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


intro :: Vocab -> TextGenCh
intro v = list [ will, v "building", word ",", explanation ]
    where will = list [ word "I will", v "adverb", word "describe this" ]
          explanation = list [ word "for I", v "admired", word "its", gushes ]
          gushes = choose [ gushplain, gushhyper ]
          gushplain = choose [ gush, list [ gush, word "and its", gush ] ]
          gushhyper = list [ gushplain, word ",", hyperbole v ]
          gush = list [ v "adjective", v "quality"]



building :: Vocab ->  [ TextGenCh ]
building v = [ intro v, detail1, detail2, detail3, detail4, detail5, detail6 ]
    where detail1 = list [ word "the", v "feature", word "had", details v ] 
          detail2 = spatialdetails v
          detail3 = spatialdetails v
          detail4 = perhaps (1, 2) $ spatialdetails v
          detail5 = perhaps (1, 2) $ spatialdetails v
          detail6 = perhaps (1, 2) $ spatialdetails v


spatialdetails :: Vocab -> TextGenCh
spatialdetails v = list [ v "spatial", word "these were", details v ]


details :: Vocab -> TextGenCh
details v = list [ number, v "details", madeof, stonephrase ]
    where madeof = choose $ map word [ "of", "made of", "carved from" ]
          stonephrase = choose [ plain, coloured, compared ]
          plain = list [ v "stone", maybehyper ]
          coloured = list [ v "colour", v "stone", maybehyper ]
          compared = choose [ justcompared, hypercompared ]
          justcompared = list [ v "stone", word "the colour of", v "substance" ]
          hypercompared = list [ justcompared, word ",", hyperbole v ]
          maybehyper = perhaps (1, 2) (hyperbole v)



stone :: Vocab -> TextGenCh
stone v = choose [ plain, coloured, comparative ]
    where plain = v "stone"
          coloured = list [ v "colour", v "stone" ]
          comparative = list [ v "stone", word "the colour of", v "substance"]

          

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


describe :: Vocab -> TextGenCh -> TextGenCh
describe v building = list [ iwilldesc, word "this", building, reason ]
    where iwilldesc = list [ word "I will", perhaps (1, 2) (v "quickly"), word "describe"]
          reason = list []



poliphili :: Vocab -> [ TextGenCh ]
poliphili v = building v



