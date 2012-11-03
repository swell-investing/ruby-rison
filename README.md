rison
=====


A Ruby implementation of [Rison - Compact Data in URIs](http://mjtemplate.org/examples/rison.html).


Installation
------------

```
$ gem install rison
```


Usage
-----

Use `Rison.dump` to encode Ruby objects as Rison, and `Rison.load` to decode
Rison encoded strings into Ruby objects:

```ruby
require 'rison'

Rison.dump(true)         # => '!t'

Rison.dump([1, 2, 3])    # => '!(1,2,3)'

Rison.dump({:a => 0})    # => '(a:0)'

Rison.dump(Array)        # => Rison::DumpError

Rison.load('!t')         # => true

Rison.load('!(1,2,3)')   # => [1, 2, 3]

Rison.load('(a:0)')      # => {:a => 0}

Rison.load('abc def')    # => Rison::ParseError
```
