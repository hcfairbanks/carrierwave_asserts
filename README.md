# CarrierwaveAsserts

Description here
This gem clones the rspec helpers for carrierwave into minitest asserts.

## Installation

### Dependencies

```imagemagick libmagickwand-dev```

You can install them on ubuntu as follows

```sudo apt-get install imagemagick libmagickwand-dev```


The following gems are needed

rmagick  (needs to be added in rails 5)

Minitest (included in rails 5)  

i18n     (included in rails 5)

Add the following lines to your application's Gemfile:
```ruby
gem 'rmagick'
gem 'carrierwave_asserts'
```

And then execute:

```$ bundle install```

Or install it yourself as:

```$ gem install carrierwave_asserts```

## Usage

Inside you project under the test folder create a folder uploaders.
All your uploaders should be tested in this folder.

Here is a sample uploader file

project_name/test/uploaders/picture_uploader_test.rb

##########################################################################
```
require 'test_helper'
require 'minitest/autorun'
require 'rmagick'

class PictureUploaderTest < ActiveSupport::TestCase
  include Magick

  setup do
    PictureUploader.enable_processing = true
    file_path = File.join( fixture_path, "files","imgs", "cat_1.jpeg")
    data_url  = "data:image/jpeg;base64,"
    data_url += Base64.encode64(File.open(file_path).read)
    cat = Cat.create(name: 'Mr Snuggles', picture: data_url)
    @uploader = PictureUploader.new(cat, :picture)
    File.open(file_path) { |f| @uploader.store!(f) }
  end

  test "img scales down landscape to fit within 200 by 133 pixels" do
    assert_be_no_larger_than(@uploader.current_path, 200, 133)
  end

  test "thumbnail scales down to exactly 100 by 67 pixels" do
    assert_have_dimensions(@uploader.thumb.current_path, 100, 67)
  end

  test "adds the correct permissions" do
    assert_have_permissions(@uploader.current_path,"700")
  end

  test "thumbnail is the same as the expected thumbnail file" do
    example = File.join(fixture_path,"files","example_imgs","thumb.jpeg")
    assert_identical_files(example,@uploader.thumb.current_path)
  end

  test "image is the same as the expected image file" do
    example = File.join(fixture_path,"files","example_imgs","cat_uploaded.jpeg")
    assert_identical_files(example,@uploader.current_path)
  end

  test "File is in the expected folder location" do
    assert_file_location(@uploader.current_path)
  end

  test "processes the thumbnail to the proper mb size" do
    assert_file_size(@uploader.thumb.current_path,65817)
  end

  test "processes the image to the proper mb size" do
    assert_file_size(@uploader.current_path,80467.0)
  end

  test "has the correct format" do
    assert_format(@uploader.current_path,"JPEG")
  end

end
```
##########################################################################

Under

project_name/config/locales/some_language.yml

you can customize the error messages.

Here is the default.
```
en:
  cwa:
    expected_permissions: "Expected permissions: "
    actual_permissions: "Actual permissions: "
    expected_format: "Expected format: "
    actual_format: "Actual format: "
    expected_size: "Expected file size: "
    actual_size: "Actual file size: "
    wrong_location: "File was not found at the expected location \n"
    not_identical: "\n Is not identical to \n"
    expected_height: "Expected height: "
    actual_height: "Actual height: "
    expected_width: "Expected width: "
    actual_width: "Actual width: "
    expected_height_no_larger_than: "Expected height to be no larger than: "
    expected_width_no_larger_than: "Expected width to be no larger than: "
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hcfairbanks/carrierwave_asserts.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
