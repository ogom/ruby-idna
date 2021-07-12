# IDNA

[Ruby FFI](https://github.com/ffi/ffi) bindings for the [libidn2](https://www.gnu.org/software/libidn/#libidn2) library, providing some simple methods to handle internationalised domain names backed by the GNU library's complete IDNA2008 / TR46 implementation.

The gem is tested with:

* Ruby 2.4.10, but probably works on all later Ruby 2 versions.
* Ruby 3.0.2, and will probably works on all subsequent Ruby 3.0.x versions.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'idna'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install idna
```

You will need to install [libidn2](https://www.gnu.org/software/libidn/#libidn2) separately, if it is not already installed on your system. For example, macOS users with [Homebrew](https://brew.sh) can run `brew install libidn2`.

## Usage

### Transform

* Attach function to `idn2_to_ascii_8z`:

```
Idna.to_ascii('あいうえお') #xn--l8jegik
```

* Attach function to `idn2_to_unicode_8z8z`:

```
Idna.to_unicode('xn--l8jegik') #あいうえお
```

### Configure

* Custom `libidn2` name:

```
Idna.configure do |config|
  config.ffi_lib = 'idn2.so.11'
end

Idna.reload!
```

## Development

```
$ bundle exec rspec
```

## License

* MIT
