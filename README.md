# Dribbble API wrapper Gem

[![Gem Version]][on rubygems]

Calyhre/dribbble is an unofficial API wrapper ruby gem for [Dribbble.com's API].

[But, what is Dribbble?]

> What are you working on? Dribbble is a community of designers answering that question each day. Web designers, graphic designers, illustrators, icon artists, typographers, logo designers, and other creative types share small screenshots (shots) that show their work, process, and current projects.

## Installation

### Requirements

- Ruby `~> 2.5`, use `v1.2.0` for previous Ruby versions.

### In a Gemfile

```ruby
gem 'dribbble'
```

### By yourself

```ruby
gem install dribbble
```

---

## Usage

Lets assume you have your token set:

```ruby
token = 'my_access_token'
```

Some calls are through a client:

```ruby
client = Dribbble::Client.new(token)
```

### Projects

##### Find a Projects

```ruby
project = Dribbble::Project.find(token, 1234)
```

##### Update a Project

```ruby
project.update(name: 'Some project', description: 'Some description');
```

##### Delete a Project

```ruby
project.delete
```

### Shots

##### Find a shot

```ruby
shot = Dribbble::Shot.find(token, 1971500)
```

##### Create a shot

```ruby
params = {
  title: 'A new shot',
  description: 'Shot description',
  image: File.open('/path/to/image.png'),
  tags: %w(tag1 tag2),
  team_id: 1234,
  rebound_source_id: 1234
}
shot = Dribbble::Shot.create(token, params)
```

##### Update a shot

```ruby
params = {
  title: 'A new shot',
  description: 'Shot description',
  tags: %w(tag1 tag2),
  team_id: 1234
}
shot.update(params)
```

##### Delete a shot

```ruby
shot.delete
```

#### Shot attachments

##### Create an attachment

```ruby
shot.create_attachment(file: File.open('attachment_path'))
```

##### Delete an attachment

```ruby
shot.delete_attachment(206165)
```

#### Shot projects

##### List projects for a shot

```ruby
projects = shot.projects
```

### Users

##### Get the authenticated user

```ruby
user = client.user
```

##### List authenticated user’s projects

```ruby
projects = client.projects
```

#### User shots

##### List shots for authenticated user

```ruby
shots = client.shots
```

### Pagination & parameters

All requests are paginated, defaults params are :

| Param    | Default |
| -------- | ------: |
| page     |       1 |
| per_page |     100 |

You override them or adding some by passing a `Hash` to every request :

```ruby
user.shots page: 2, custom_param: 'My param'
```

## Contributing

Feel free to help me make this gem awesome !

[Contributors] and [CONTRIBUTING]

## Licence

Released under the MIT License. See the [LICENSE] file for further details.

[gem version]: https://badge.fury.io/rb/dribbble.svg
[build status]: https://travis-ci.org/Calyhre/dribbble.svg?branch=master
[on rubygems]: http://rubygems.org/gems/dribbble
[dribbble.com's api]: http://developer.dribbble.com/
[but, what is dribbble?]: https://dribbble.com/about
[license]: LICENSE.md
[contributors]: https://github.com/Calyhre/dribbble/graphs/contributors
[contributing]: CONTRIBUTING.md
