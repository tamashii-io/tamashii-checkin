Tamashii Checkin
===

## Requirements

* Ruby 2.4.0
* PostgreSQL 9.5+
* Redis
* Node.js
* Yarn

## Usage

### Install Dependency

```
$ bundle install
```

### Prepare Database

If you didn't have database.

```
$ rake db:create
```

And run migration to create tables.

```
$ rake db:migrate
```

### Rails

Start Rails server

```
$ rails s
```

### Webpack

Make sure running `webpack-dev-server` to building javascript.

Above require `binstub` setup for your system.

```
$ webpack-dev-server
```

or

```
$ ./bin/webpack-dev-server
```

## Contributes

* Aotoki <elct9620@frost.tw>
* jun SSSS<k5241284@kyoto-wu.ac.jp>