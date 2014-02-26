# gitlab-slack

Send gitlab notifications to Slack channel

## Install

Clone repository and install dependencies:

```
git clone git@gitlab.doejo.com:doejo/gitlab-slack.git
cd vip-notify
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

## License

The MIT License (MIT)

Copyright (c) 2014 Doejo LLC