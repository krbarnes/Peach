# Peach 🍑
Make iOS Simulators with Ruby (and simctl).

# Why?
Because Xcode sucks at this.

# Quality
Nope. I wrote this quickly and it works for me. There's no error handling and it will delete all your simulators sometimes. PRs welcome, issues disabled.

Good Luck!


# Things I forget all the time:

## Install

gem build peach.gemspec
gem install ./peach-[version string]

## Publish

curl -u iamkevb https://rubygems.org/api/v1/api_key.yaml > ~/.gem/credentials; chmod 0600 ~/.gem/credentials
gem push hola-[version string]
