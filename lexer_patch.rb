require 'rouge'
require 'rouge/lexers/javascript'

class Rouge::Lexers::JSON
  state :comments_and_whitespace do
    rule /\s+/, Text
    rule /<!--/, Comment # really...?
    rule %r(//.*?$), Comment::Single
    rule %r(/\*.*?\*/)m, Comment::Multiline
  end

  prepend(:root) do
    mixin :comments_and_whitespace
  end

  prepend(:object_key) do
    mixin :comments_and_whitespace
  end
end
