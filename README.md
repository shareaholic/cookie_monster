# CookieMonster
[![Build Status](https://secure.travis-ci.org/griffindy/cookie_monster.png)](http://travis-ci.org/griffindy/cookie_monster?branch=master)

This library exists to help you handle encrypted cookies in your app(s). The
goal is for the implementation to be simple and dependency free so that it can
be used anywhere.

Installation
--------

```shell
gem install cookie_monster
```
or add the following line to Gemfile:

```ruby
gem 'cookie_monster'
```
and run `bundle install` from your shell.

Configuration
-------------

`CookieMonster` is configured by passing a block to `CookieMonster.configure`
like the following:

```ruby
CookieMonster.configure do |config|
  config.key = '6e14e0255e472f84ef99df899cf9158aa3215a919db1ba0fa460eb928da3b34265a98d93bb4593762b0404494c7f1ab60f62b75eb'
end
```

The object yielded by `CookieMonster.configure` accepts two methods: `key` and
`cipher_type`. `key` is the key that will unlock all the cookies, so keep this
secret! It should also be long. If you're using `CookieMonster` across multiple
apps, make sure that the key is the same. `cipher_type` defaults to
`'AES-256-CBC'`, but can be anything in the list of `OpenSSL::Cipher.ciphers`

Usage
-----
### Rails

If you're on rails, using CookieMonster is as easy as including the appropriate
module into your controller:

```ruby
include CookieMonster::Rails
```

This includes a method `cookie_monster` which behaves just like `cookies`. You
can access cookies with `[]` and set them with `[]=`:

```ruby
class SecretsController < ApplicationController
  # ...
  def update
    cookie_monster[:super_secret_thing] = 'hopefully no one reads this'
  end

  def show
    @secret = cookie_monster[:super_secret_thing]
  end
  # ...
end
```

### Another Ruby application
Otherwise, you need to instantiate a new `CookieMonster::Jar` object with a
`request` and `response` objects. `request` and `response` should both respond
to `cookies`, and `response` should also respond to `set_cookie`. You can also
provide options for the cookie setting. This could look like the following:

```ruby
def cookie_monster
  @cookie_monster ||= CookieMonster::Jar.new(request: request, response: response, expires: 1.day.from_now)
end
```

Supported Ruby Versions
-----------------------

`CookieMonster` requires at least Ruby 1.9. It is tested against Ruby 1.9.2,
\1.9.3, and JRuby in 19-mode.

Contributing
------------

Contributing to `CookieMonster`:

1. Fork the [official repository](https://github.com/shareaholic/cookie_monster/tree/master).
2. Make your changes in a topic branch.
3. Send a pull request.

Notes:

* Contributions without tests won't be accepted.
* Please don't update the Gem version.

License
-------

cookie_monster is Copyright © 2013 Dylan Griffin and Shareaholic, Inc.
It is free software, and may be redistributed under the terms specified
in the [LICENSE](https://github.com/shareaholic/cookie_monster/blob/master/LICENSE) file.
