# Dribbble API wrapper Gem

[![Gem Version](https://badge.fury.io/rb/dribbble.svg)](http://rubygems.org/gems/dribbble)
[![Build Status](https://travis-ci.org/Calyhre/dribbble.svg?branch=master)](https://travis-ci.org/Calyhre/dribbble)

Calyhre/dribbble is an unofficial API wrapper ruby gem for [Dribbble.com's API](http://developer.dribbble.com/).

[But, what it Dribbble?](https://dribbble.com/about)
> What are you working on? Dribbble is a community of designers answering that question each day. Web designers, graphic designers, illustrators, icon artists, typographers, logo designers, and other creative types share small screenshots (shots) that show their work, process, and current projects.

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




### Buckets

##### Find a bucket
```ruby
bucket = Dribbble::Bucket.find(token, '2754')
```

##### Create a bucket
```ruby
bucket = Dribbble::Bucket.create(token, name: 'A new bucket', description: 'A description')
```

##### Update a bucket
```ruby
bucket.update name: 'An updated bucket name'
```

##### Delete a bucket
```ruby
bucket.delete
```

#### Bucket shots

##### List bucket shots
```ruby
shots = bucket.shots
```

##### Add shot to a bucket
```ruby
bucket.add_shot(329335)
# or
bucket.add_shot(shot) # shot is a Dribbble::Shot
```

##### Remove shot from a bucket
```ruby
bucket.remove_shot(329335)
# or
bucket.remove_shot(shot) # shot is a Dribbble::Shot
```




### Projects

##### Find a Projects
```ruby
project = Dribbble::Project.find(token, 3)
```

#### Project shots
```ruby
shots = project.shots
```




### Shots

##### List shots
```ruby
shots = Dribbble::Shot.all(token)
```

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

##### List attachments for a shot
```ruby
shot.attachments
```

##### Create an attachment
```ruby
shot.create_attachment(file: File.open('attachment_path'))
```

##### Get a single attachment
```ruby
shot.find_attachment(206165)
```

##### Delete an attachment
```ruby
shot.delete_attachment(206165)
```


#### Shot buckets
##### List buckets for a shot
```ruby
shot.buckets
```


#### Shot comments
##### List comments for a shot
```ruby
shot.comments
```

##### Create a comment
```ruby
comment = shot.create_comment(body: 'A comment')
```

##### Get a single comment
```ruby
comment = shot.find_comment(1145736)
```

##### Update a comment
```ruby
comment = shot.update_comment(1145736, body: 'Comment body')
```

##### Delete a comment
```ruby
shot.delete_comment(1145736)
```

##### List likes for a comment
```ruby
comment.likes
```

##### Check if you like a comment
```ruby
comment.like?
```

##### Like a comment
```ruby
comment.like!
```

##### Unlike a comment
```ruby
comment.unlike!
```

#### Shot likes
##### List the likes for a shot
```ruby
shot.likes
```

##### Check if you like a shot
```ruby
shot.like?
```

##### Like a shot
```ruby
shot.like!
```

##### Unlike a shot
```ruby
shot.unlike!
```

#### Shot projects
##### List projects for a shot
```ruby
projects = shot.projects
```

#### Shot rebounds
##### List rebounds for a shot
```ruby
shots = shot.rebounds
```




### Teams

Let's assume you have a team:
```ruby
user = Dribbble::User.find(token, 483195)
team = user.teams.first
```

#### Team members
##### List a team’s members
```ruby
users = team.members
```


#### Team shots
##### List shots for a team
```ruby
shots = team.shots
```




### Users
##### Get a single user
```ruby
user = Dribbble::User.find(token, 483195)
```

##### Get the authenticated user
```ruby
user = client.user
```


#### User buckets
##### List a user’s buckets
```ruby
user.buckets
```

##### List authenticated user’s buckets
```ruby
buckets = client.buckets
```


#### User followers
##### List followers of a user
```ruby
users = user.followers
```

##### List followers of authenticated user
```ruby
users = client.followers
```

##### List users followed by a user
```ruby
users = user.following
```

##### List shots for users followed by a authenticated user
```ruby
shots = client.following_shots
```

##### Check if you are following a user
```ruby
user.following?
```

##### Check if one user is following another
```ruby
user.following?(483195)
```

##### Follow a user
```ruby
user.follow!
```

##### Unfollow a user
```ruby
user.unfollow!
```


#### User likes
##### List shot likes for a user
```ruby
shots = user.likes
```

##### List shot likes for authenticated user
```ruby
shots = client.likes
```


#### User projects
##### List a user’s projects
```ruby
projects = user.projects
```

##### List authenticated user’s projects
```ruby
projects = client.projects
```


#### User shots
##### List shots for a user
```ruby
shots = user.shots
```

##### List shots for authenticated user
```ruby
shots = client.shots
```


#### User teams
##### List a user’s teams
```ruby
teams = user.teams
```

##### List authenticated user’s teams
```ruby
teams = client.teams
```



### Pagination & parameters

All requests are paginated, defaults params are :

| Param   | Default |
|---------|--------:|
|page     |        1|
|per_page |      100|

You override them or adding some by passing a `Hash` to every request :

```ruby
user.shots page: 2, custom_param: 'My param'
```

## Contributing

Feel free to help me make this gem awesome !

[Contributors](https://github.com/Calyhre/dribbble/graphs/contributors) and [CONTRIBUTING](https://github.com/Calyhre/dribbble/blob/master/CONTRIBUTING.md)

## Licence

Released under the MIT License. See the [LICENSE](https://github.com/Calyhre/dribbble/blob/master/LICENSE.md) file for further details.
