start = expr

ws = [ \t\n]*

identifier = first:[a-z] rest:[a-z0-9]* {
  return first + rest.join('');
}

string = ["] string:([^"]*) ["] {
  return string.join('');
}

word = ws word:[^ \t\n<>]+ {
  return word.join('');
}

text = text:word+ {
  return { type: 'text', text: text.join(' ') };
}

attribute = ws name:identifier "=" value:string {
  return { type: 'attr', name: name, value: value };
}

expr = ws expr:(tag / text) ws {
  return expr;
}

open = ws "<" name:identifier attributes:attribute* ">" {
  var attrs = attributes.map(function (attr) {
    return { name: attr.name, value: attr.value };
  });

  return { type: 'open', name: name, attrs: attrs };
}

close = ws "</" identifier? ">" {
  return { type: 'close' };
}

tag = open:open content:expr* close {
  return { type: 'tag', name: open.name, attrs: open.attrs, content: content };
}
