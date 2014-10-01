# DribbbleAPI

![Codeship Status for Calyhre/dribbble](https://www.codeship.io/projects/11857a40-2b09-0132-c03d-1ac4495b4327/status)

[![Build Status](https://travis-ci.org/Calyhre/dribbble.svg?branch=master)](https://travis-ci.org/Calyhre/dribbble)

_Dribbble API gem_

## Installation

### Requirements

* Ruby `~> 2.0`

### In a Gemfile

```ruby
gem 'dribbble'
```

### By yourself

```ruby
gem install dribbble
```

## Usage

First you need to instanciate a client with a client access token. You can get one by creating an application on [developer.dribbble.com](http://developer.dribbble.com/).

```ruby
client = Dribbble::Client.new token: '0123456789abcdef'
```

### User

You can get the current user logged in by calling `client.user`

```ruby
client.get_user
#=> #<Dribbble::User ...>
```

Or you can get a specific user by knowing his ID

```ruby
user = client.get_user(1)
#=> #<Dribbble::User id=1 ...>
```

You can access users attributes like this :

```ruby
user.name
#=> "Charley D."

user.username
#=> "Calyhre"
```

A user also have buckets :

```ruby
user.buckets
#=> [#<Dribbble::Bucket ...>, #<Dribbble::Bucket ...>]
```

### Shots

You can create a shot by calling `client.create_shot`

```ruby
shot = {
  title: 'Shot title',
  desciption: 'Shot description',
  image: File.new('some/directory/image.jpg', 'rb'),
  tags: %w(tag1 tag2)
}

client.create_shot(shot)
#=> True
```

## Contributing

Feel free to help me make this gem awesome !

[Contributors](https://github.com/Calyhre/dribbble/graphs/contributors) and [CONTRIBUTING](https://github.com/Calyhre/dribbble/blob/master/CONTRIBUTING.md)

## Licence

Released under the MIT License. See the [LICENSE](https://github.com/Calyhre/dribbble/blob/master/LICENSE.md) file for further details.
