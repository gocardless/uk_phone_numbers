# uk_phone_numbers

A Ruby library for validating and formatting UK phone numbers.

## Installation

```console
$ gem install uk_phone_numbers
```

## Usage

### Validating a phone number

```ruby
require 'uk_phone_numbers'

UKPhoneNumbers.valid? "02087123456"
# => true
```

### Formatting a phone number

```ruby
require 'uk_phone_numbers'

UKPhoneNumbers.format "02087123456"
# => "020 8712 3456"
```

