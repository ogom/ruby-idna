# Change Log

## v1.0.0 (2020-10-15)

- Now uses [libidn2](https://www.gnu.org/software/libidn/#libidn2).
- The gem main API is identical, but custom exception classes differ from V1 since the V2 library's error codes have changed. The old classes are maintained via backwards compatibility mappings. You can keep using the V1 exception classes, but ought to update code for the V2 exceptions if you can. See the [C definitions](https://gitlab.com/libidn/libidn2/-/blob/master/lib/idn2.h.in) for details, or look in `lib/idna/error.rb`.
- Local development uses Ruby 2.4.10 (was 2.4.1).

## v0.1.0 (2017-09-24)

- First release.
