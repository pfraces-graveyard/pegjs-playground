start = expression

expression = spaces expr:(atom / list) spaces { return expr; }
atom = atom:[^() \t\n]+ { return atom.join(''); }
list = "(" list:expression* ")" { return list; }
spaces = (space / tab / newline)* { return ' '; }

space = " "
tab = "\t"
newline = "\n"
