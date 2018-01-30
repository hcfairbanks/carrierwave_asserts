require "carrierwave_asserts/version"
require 'minitest/assertions'
require 'rmagick'

# https://www.sitepoint.com/creating-your-first-gem/
#
# Now in your main program you can just require your module and give it any file to parse. In Rails, we would probably put a module like this in the lib folder. You can create large module 'libraries' consisting of many nested modules and classes. Here is a more complex example module used for processing data.May 5, 2016
#
# bundle gem carrierwave_asserts
# add code
# gem build carrierwave_asserts.gemspec
# gem install carrierwave_asserts.gemspec
# add this to a local rails Gemfile
# gem 'carrierwave_asserts'
# BROKEN
# https://github.com/seattlerb/minitest/issues/730
# https://chriskottom.com/blog/2014/08/customize-minitest-assertions-and-expectations/


module CarrierwaveAsserts
  #https://lingohub.com/blog/2013/08/internationalization-for-ruby-i18n-gem/

  #YAML.load_file('/home/deploy/Desktop/git/carrierwave_asserts/config/locales/en.yml')
  module Minitest::Assertions
    include Magick
    #https://lingohub.com/blog/2013/08/internationalization-for-ruby-i18n-gem/
    require 'i18n'
    #I18n.load_path = Dir['./*.yml', './*.rb']
    I18n.load_path = Dir['/home/deploy/Desktop/git/carrierwave_asserts/config/locales/en.yml']

    def assert_have_permissions(file_path,permissions)
      file_permissions = (File.stat(file_path).mode & 0777).to_s(8)
      msg = "Expected file permissions #{permissions},
              actual file permissions #{file_permissions}"
      assert file_permissions == permissions ? true : false, msg
    end

    def assert_have_dimensions(file_path,width,height)
      msg = check_width_equal_to(file_path,width)
      msg += check_height_equal_to(file_path,height)

      assert msg.blank? ? true : false, msg
    end

    def assert_be_no_larger_than(file_path, width, height)
      msg = check_width_no_larger_than(file_path,width)
      msg += check_height_no_larger_than(file_path,height)
      assert msg.blank? ? true : false, msg
    end

#I18n.t 'success.true'

    def assert_format(file_path,file_format)
      img = Magick::Image.ping( file_path ).first
      msg = I18n.t("cwa.expected_format") + " " + file_format + " " + I18n.t("cwa.actual_format") + img.format
      #msg = "Expected format #{file_format}, actual format #{img.format}."
      assert file_format == img.format ? true : false, msg
    end

    def assert_file_size(file_path,file_size)
      actual_size = File.size(file_path)
      msg = "Expected size #{file_size}, actual size #{actual_size}."
      assert actual_size == file_size ? true : false, msg
    end

    def assert_file_location(file_path)
      msg = "File was not found at the expected location #{file_path}."
      assert File.file?(file_path), msg
    end

    def assert_identical_files(comparison_file_path,file_path)
      msg = "File #{file_path} was not identical to #{comparison_file_path}."
      assert FileUtils.identical?(comparison_file_path,file_path), msg
    end

    private

    def check_width_no_larger_than(file_path,width)
      img = Magick::Image.ping( file_path ).first
      img.columns <= width ? "" : "Expected width to be less than #{width}, "\
                                    "actual width #{img.columns}. "
    end

    def check_height_no_larger_than(file_path,height)
      img = Magick::Image.ping( file_path ).first
      img.rows <= height ? "" : "Expected height to be less than #{height}, "\
                                  "actual height #{img.rows}."
    end

    def check_width_equal_to(file_path,width)
      img = Magick::Image.ping( file_path ).first
      img.columns == width ? "" : "Expected width #{width}, "\
                                "actual width #{img.columns}. "
    end

    def check_height_equal_to(file_path,height)
      img = Magick::Image.ping( file_path ).first
      img.rows == height ? "" : "Expected height #{height}, "\
                                  "actual height #{img.rows}."
    end

  end

end
