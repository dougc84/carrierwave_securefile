# CarrierWave_SecureFile

A gem to add secured file uploading to CarrierWave.  Uses the Crypt19 gem with Blowfish encryption to encrypt and decrypt files.

I needed this functionality for a project, and simply couldn't find a viable solution.  So I rolled out my own.  Then I got tired of
dirtying up my /lib/ folder, so I made a gem out of it.  This is my first attempt at writing a gem, and for my project, it works
pretty well.

For personal testing, I was uploading to RackSpace Cloud Files.  I haven't tested using local file uploads or other cloud services, but
it should work fine just the same.

## Requirements

Ruby 1.9.3 w/ Rails 3.1.3.  Realistically, it should work on Ruby 1.9.x and Rails 3.1.x, but may work on other configurations.
It hasn't been tested.

## Installation

Add the following to your gemfile:

``` ruby
gem 'carrierwave_securefile'
```

...and run the obligatory

```
bundle
```

command to install.

## Usage
### Initializer

Add an initializer in yourapp/config/initializers.  Name it *carrierwave_securefile.rb*.  Add the following:

``` ruby
CarrierWave::SecureFile.configure do |config|
	config.cypher = ("Your cypher code here")[0..55]
end
```

The cypher must be no longer than 56 characters.

### Uploader

``` ruby
process :secure_file
def secure_file
	CarrierWave::SecureFile::Uploader.secure_file( model, self.to_s )
end
```

This sends the model data (typically nil, but differentiates between uploads and downloads) as well as the current file name
(self.to_s - which is needed to encrypt the file).

### Downloader

You will not be able to call YourUploader.asset_file (or whatever you chose with your CarrierWave uploader) directly.  Create
a new get controller action, and use the following code.  Change where appropriate.  Assumed using an uploader named
UserFileUploader, and a model called UserFile.

``` ruby
def file
	# get the decrypted file from the server.  needs the uploader model and the record the file is attached to in your ORM.
	decrypted_file = CarrierWave::SecureFile::Downloader.call( UserFileUploader, UserFile.find(params[:id]) )
	# decrypted file is a hash set up as follows:
	# decrypted_file[:file] - the decrypted file, hopefully saved in a tmp path, not somewhere public facing.
	# decrypted_file[:content_type] - returns content type, if available.
	# send the file to the user:
	send_file decrypted_file[:file], :content_type => decrypted_file[:content_type]
	# then immediately destroy the file.  You don't want an unencrypted file saved on your server... or do you?
	File.unlink decrypted_file[:file]
end
```

And that's it!  You're good to go.

# To Do

* Add other encryption algorithms
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

### Copyright

Copyright (c) 2011 Doug Clark. See LICENSE.txt for further details.

