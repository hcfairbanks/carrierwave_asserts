require "carrierwave_asserts/version"
require 'minitest/assertions'
require 'rmagick'

module CarrierwaveAsserts
  module Minitest::Assertions
    include Magick
    require 'i18n'

    I18n.load_path = Dir[File.expand_path('../config/locales/*.yml', File.dirname(__FILE__))]

    def assert_have_permissions(file_path,permissions)
      file_permissions = (File.stat(file_path).mode & 0777).to_s(8)
      msg = I18n.t("cwa.expected_permissions") + permissions.to_s + "\n" +
              I18n.t("cwa.actual_permissions") + file_permissions
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

    def assert_format(file_path,file_format)
      img = Magick::Image.ping( file_path ).first
      msg = I18n.t("cwa.expected_format") + file_format + "\n" +
              I18n.t("cwa.actual_format") + img.format
      assert file_format == img.format ? true : false, msg
    end

    def assert_file_size(file_path,file_size)
      actual_size = File.size(file_path)
      msg = I18n.t("cwa.expected_size") +
              file_size.to_s + "\n" +
              I18n.t("cwa.actual_size") + actual_size.to_s
      assert actual_size == file_size ? true : false, msg
    end

    def assert_file_location(file_path)
      msg = "\n" + I18n.t("cwa.wrong_location") + file_path
      assert File.file?(file_path), msg
    end

    def assert_identical_files(comparison_file_path,file_path)
      msg = "\n" + file_path + I18n.t("cwa.not_identical") + comparison_file_path
      assert FileUtils.identical?(comparison_file_path,file_path), msg
    end

    private

    def check_width_no_larger_than(file_path,width)
      img = Magick::Image.ping( file_path ).first
      msg = I18n.t("cwa.expected_width_no_larger_than") + width.to_s + "\n" +
              I18n.t("cwa.actual_width") + img.columns.to_s + "\n"
      img.columns <= width ? "" : msg
    end

    def check_height_no_larger_than(file_path,height)
      img = Magick::Image.ping( file_path ).first
      msg = I18n.t("cwa.expected_height_no_larger_than") + height.to_s + "\n" +
              I18n.t("cwa.actual_height") + img.rows.to_s + "\n"
      img.rows <= height ? "" : msg
    end

    def check_width_equal_to(file_path,width)
      img = Magick::Image.ping( file_path ).first
      msg = I18n.t("cwa.expected_width") + width.to_s + "\n" +
              I18n.t("cwa.actual_width") + img.columns.to_s + "\n"
      img.columns == width ? "" : msg
    end

    def check_height_equal_to(file_path,height)
      img = Magick::Image.ping( file_path ).first
      msg = I18n.t("cwa.expected_height") + height.to_s + "\n" +
              I18n.t("cwa.actual_height") + img.rows.to_s + "\n"
      img.rows == height ? "" : msg
    end

  end

end
