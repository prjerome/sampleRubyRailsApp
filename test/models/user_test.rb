require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Example', email: 'pj@example.com', password: 'foobar', password_confirmation: 'foobar')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = ''
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = '    '
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.email = 'a@' * 256
    assert_not @user.valid?
  end
  test 'valid emails should be accepted' do
    valid_email_addresses = %w[pj@gmail.com pj@gmx.net pj@yahoo.com]
    valid_email_addresses.each do |email_address|
      @user.email = email_address
      assert @user.valid?, "#{email_address.inspect} should be valid"
    end
  end
  test 'invalid emails should be rejected' do
    invalid_email_addresses = %w[pj@gmail,com pj@gmx..net pj@yahoo,com]
    invalid_email_addresses.each do |invalid_email_address|
      @user.email = invalid_email_address
      assert_not @user.valid?, "#{invalid_email_address.inspect} should be invalid"
    end
  end
  test 'users with the same email address should be rejected' do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end
  test 'email addresses should be saved as lower case' do
    mixed_case_email = 'Foo@ExAMPle.CoM'
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  test 'password should not be blank' do
    @user.password = ''
    @user.password_confirmation = '' * 6
    assert_not @user.valid?
  end
  test 'password length should be a minimum of 6 characters' do
    dup_user = @user.dup
    dup_user.password = dup_user.password_confirmation = 'a' * 5
    assert_not dup_user.valid?
  end
end
