start = node

node = ws node:(text / expr / tag) ws {
  return node;
}

text = text:word+ {
  return { type: 'text', value: text.join(' ') };
}

expr = "{{" ws expr:dotexpr ws "}}" {
  return { type: 'expr', value: expr };
}

tag = "<" name:identifier attributes:attribute* ">" children:node* "</" identifier? ">" {
  var attrs = attributes.reduce(function (acc, attr) {
    acc[attr.name] = attr.value;
    return acc;
  }, {});

  return { type: 'tag', name: name, attrs: attrs, children: children };
}

ws = [ \t\n]*

identifier = first:[a-z] rest:[a-z0-9]* {
  return first + rest.join('');
}

string = ["] string:([^"]*) ["] {
  return string.join('');
}

word = ws word:[^ \t\n<>{}]+ {
  return word.join('');
}

member = "." member:identifier {
  return member;
}

dotexpr = first:identifier rest:member* {
  return [].concat(first, rest);
}

attribute = ws name:identifier "=" value:string {
  return { name: name, value: value };
}
