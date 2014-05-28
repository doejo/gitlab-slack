# gitlab-slack

Deliver Gitlab code push notifications to a [Slack](https://slack.com/) channel

## Install

Clone repository and install dependencies:

```
git clone git@gitlab.doejo.com:doejo/gitlab-slack.git
cd gitlab-slack
bundle install
```

## Configure

Application requires the following environment variables to function:

- `SLACK_TEAM`    - Team name on Slack
- `SLACK_TOKEN`   - Integration token
- `SLACK_CHANNEL` - Channel name to post updates to
- `SLACK_USER`    - Name of the user that sends notifications

## Usage

Application accepts incoming push payloads from Gitlab on `/receive` endpoint via `POST` request.

To start application just run:

```
foreman start
```

## Deployment

You can deploy this application to Heroku for free:

```
heroku create
heroku config:set SLACK_TEAM=team SLACK_TOKEN=token SLACK_CHANNEL=ops SLACK_USER=gitlab
git push heroku master
```

## Testing

Execute test suite:

```
bundle exec rake test
```

## License

The MIT License (MIT)

Copyright (c) 2014 Doejo LLC
