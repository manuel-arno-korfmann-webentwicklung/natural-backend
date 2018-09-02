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

* Clone this repository:
```sh
$ git clone https://github.com/LemonAndroid/natural-backend.git
````
* Change into the app directory:
```sh
$ cd natural-backend
```
* Install dependencies:
```sh
$ bundle install
```
* Setup database:
```sh
$ rails db:setup
```
* Start the application:
```sh
$ rails server
```
