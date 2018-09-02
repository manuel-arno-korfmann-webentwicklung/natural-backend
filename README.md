[![Gitter chat](https://badges.gitter.im/gitterHQ/gitter.png)](https://gitter.im/gitterHQ/gitter)

## Demo

https://natural-db.com.

## One-click deployments

Currently looking into:

[![Deploy](https://cdn.wedeploy.com/images/deploy.svg)](https://console.wedeploy.com/deploy?repo=https://github.com/LemonAndroid/natural-backend)

Let's see if this works, heroku didn't work.

Not supported for now:

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

In order to make the heroku deployment work properly, a custom Amazon RDS instance would have to be configured. HMU in the gitter and I'll guide you through it if you want to deploy to heroku. Be aware that the Amazon RDS instance will cost money.

## Getting started

1. Clone this repository:
```sh
$ git clone https://github.com/LemonAndroid/natural-backend.git
````

2. Install redis
```sh
$ sudo apt install redis
```
3. Change into the app directory:
```sh
$ cd natural-backend
```
4. Install dependencies:
```sh
$ bundle install
```
5. Setup database:
```sh
$ bundle exec rake db:setup
```
6. Start the application:
```sh
$ bundle exec rails server
```
7. Start sidekiq:
```sh
$ bundle exec sidekiq
```
