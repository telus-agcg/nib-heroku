# nib-heroku

Integrates the Heroku CLI into `nib` with the idea of allowing for a similar API for tasks like viewing logs or creating REPL shell. For example:

```sh
# access logs in development as usual
nib logs web

# access production logs
nib logs -e production web
```

## Installation

Install the gem on your machine globally:

```sh
gem install nib-heroku
```

### Dependencies

* [`Heroku CLI`](https://devcenter.heroku.com/articles/heroku-cli) is used to interact with Heroku.

## Conventions

* The name of the local folder matches the name of an application on Heroku with the insertion of environment.
* Environments are abbreviated as `dev`, `stage`, `prod`

For example:

Local directory: `my-awesome-app`
Heroku app name: `my-prod-awesome-app`

These conventions match a pattern we use internally at Technekes where the first part is a token for the owner of a project (ie. internal or client) and the later part is the name of the project. The insertion of environment after the owner token helps with application lists and billing sorting.

## Usage

`nib-heroku` mostly relies on an installed and authenticated instance of the Heroku CLI as well as previously mentioned conventions.

### Access Logs

"Follow" (not [tail](https://github.com/heroku/legacy-cli/pull/297)!) the production logs.

```sh
nib logs -f -e production web
```

### Start a shell

Start up a bash session in the production environment:

```sh
nib shell -e production web
```

## Development

After pulling down the repo build an image and use Guard to facilitate running specs and RuboCop.

```sh
nib build
nib guard gem
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/technekes/nib-heroku.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
