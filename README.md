# gitlab-slack

Deliver Gitlab code push notifications to a [Slack](https://slack.com/) channel

[![Build Status](https://magnum-ci.com/status/ebcfe15f396d8c1f4b3692986615e83f.png)](https://magnum-ci.com/public/ebcfe15f396d8c1f4b3692986615e83f/builds)

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

## Start Server

To start application just run:

```
foreman start
```

## Testing

Execute test suite:

```
bundle exec rake test
```

## License

The MIT License (MIT)

Copyright (c) 2014 Doejo LLC