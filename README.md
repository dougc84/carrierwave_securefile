# CarrierWave_SecureFile

A gem to add secured file uploading to CarrierWave.  Uses Crypt19 and OpenSSL to encrypt and decrypt files, and offers multiple
methods of encryption.

I needed this functionality for a project, and simply couldn't find a viable solution.  So I rolled out my own.  Then I got tired of
dirtying up my /lib/ folder, so I made a gem out of it.  This is my first attempt at writing a gem, and for my project, it works
pretty well.

For personal testing, I was uploading to RackSpace Cloud Files.  I haven't tested using local file uploads or other cloud services, but
it should work fine just the same.

## Requirements

Ruby 1.9.3 w/ Rails 3.1.3.  Realistically, it should work on Ruby 1.9.x and Rails 3.x, but may work on other configurations.
It hasn't been tested.  I'm currently using this with CarrierWave 0.6.2, Rails 3.2.8, and Ruby 1.9.3.

## Installation and Usage

[Please refer to the Wiki For Installation and Usage.](https://github.com/dougc84/carrierwave_securefile/wiki/Usage)

## Changes in 0.4.x

* Added AES file encryption using OpenSSL

## Changes in 0.2.0

* Changed syntax for Downloader so, you know, it actually works.  Would expect a "user_file" field before, now you specify
  the file field.
* Added choice for encryption algorithm - Blowfish (default), Rijndael, GOST.

# To Do

* Integrate with 'process' method in uploader to make 4 lines of code into 1
* Refactoring and testing

# Contributing to carrierwave_securefile
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

### Thanks To

[sirvine](https://github.com/sirvine) for help with the downloader.

### Copyright

Copyright (c) 2011-2012 Doug Clark. See LICENSE.txt for further details.

## How to Create a Release

Releases happen in CircleCI when a tag is pushed to the repository.

To create a release, you will need to do the following:

1. Change the version in `lib/gr_send_with_us/version.rb` to the new version and create a PR with the change.
1. Once the PR is merged, switch to the master branch and `git pull`.
1. `git tag <version from version.rb>`
1. `git push origin --tags`

CircleCI will see the tag push, build, and release a new version of the library.

