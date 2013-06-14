# CookieMonster

This library exists to help you handle encrypted cookies in your app(s). The
goal is for the implementation to be simple and dependency free so that it can
be used anywhere.

Install
--------

```shell
gem install cookie_monster
```
or add the following line to Gemfile:

```ruby
gem 'cookie_monster'
```
and run `bundle install` from your shell.

Usage
-----

If you're on rails, using CookieMonster is as easy as:

```ruby
include CookieMonster::Rails
```

This includes a method `cookie_monster` which behaves just like `cookies`.
Otherwise, you need to instantiate a new `CookieMonster::Jar` object with a
`request` and `response` objects. `request` and `response` should both respond
to `cookies`, and `response` should also respond to `set_cookie`. You can also
provide options for the cookie setting. This could look like the following:

```ruby
def cookie_monster
  @cookie_monster ||= CookieMonster::Jar.new(request: request, response: response, expires: 1.day.from_now)
end
```
