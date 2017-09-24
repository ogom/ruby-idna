# Idna

The [IDN Library](http://www.gnu.org/software/libidn/manual/libidn.html) to use by the [Ruby-FFI](https://github.com/ffi/ffi).

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

## Usage

### Transform

* Attach function to `idna_to_ascii_8z`:

```
Idna.to_ascii('あいうえお') #xn--l8jegik
```

* Attach function to `idna_to_unicode_8z8z`:

```
Idna.to_unicode('xn--l8jegik') #あいうえお
```

### Configure

* Custome libidn name:

```
Idna.configure do |config|
  config.ffi_lib = 'idn.so.11'
end

Idna.reload!
```

## Development

```
$ bundle exec rspec
```

## License

* MIT
