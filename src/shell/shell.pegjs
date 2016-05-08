/**
 * <https://coderwall.com/p/316gba/beginning-parsers-with-peg-js>
 */

commands
  = "wc:" space* wc:wordCount { return wc; }
  / "lc:" space* lc:letterCount { return lc; }

wordCount = w:(word space?)* {return w.length;}

letterCount = w:(w:word space? { return w; })* {
  return w.reduce(function (acc, word) {
    return acc + word.length;
  }, 0);
}

word = letter+
letter = [a-z]
space = " "
