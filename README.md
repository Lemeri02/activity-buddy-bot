# ActivityBuddy

A nice little Telegram Bot to help you be more active!

## Introduction

This bot has been implemented for a Seminar about Chatbots and Conversational Agents @ University of Applied Sciences of Western Switzerland
The topic of this project is User Engagement in Chatbots. This prototype implements a User Engagement Analyzer which analyses the engagement
and deploys different strategies for communicating with the user.

Currently the bot has two different strategies/personalities:

- motivational
- disciplined

## Requirements

If you want to build this project, the following things are required:

- Ruby 2.5
- PostgreSQL Database
- Wit.ai Account and API token
- Telegram Bot API token

## Setup

- Check out project
- Install Ruby (Need help? --> https://www.ruby-lang.org/en/downloads/)
- Install bundler
    * `gem install bundler`
- Install dependencies with bundler
    * `bundle install`
- Generate and populate a new `credentials.yml` (Need help? --> https://medium.com/cedarcode/rails-5-2-credentials-9b3324851336)
    * A sample credentials file is under `config/credentials.sample.yml`
- Prepare the DB
    * `bin/rails db:setup`
- Start the bot
    * `bin/rake telegram:bot:poller`

### Wit.ai Project

To extract intents from user messages, this bot relies on wit.ai. To build
a copy of this project for yourself you need to create a project on wit.ai.

Create a new Project on wit.ai from the backed up available in the file `ActivityBuddy-##########.zip`

Copy the API token and save it to credentials.yml

### Telegram Bot

Create a new Bot on Telegram. How? https://core.telegram.org/bots

Copy the API token and save it to credentials.yml

