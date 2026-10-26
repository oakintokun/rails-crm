
require "test_helper"

class CustomerTest < ActiveSupport::TestCase
  test "customer is valid with a full name and phone number" do
    customer = Customer.new(
      full_name: "Jane Doe",
      phone_number: "204-555-1234"
    )

    assert customer.valid?
  end

  test "customer must have a full name" do
    customer = Customer.new(
      full_name: "",
      phone_number: "204-555-1234"
    )

    assert_not customer.valid?
    assert customer.errors[:full_name].any?
  end

  test "customer must have a phone number" do
    customer = Customer.new(
      full_name: "Jane Doe",
      phone_number: ""
    )

    assert_not customer.valid?
    assert customer.errors[:phone_number].any?
  end

  test "customer can have a missing email address" do
    customer = Customer.new(
      full_name: "Jane Doe",
      phone_number: "204-555-1234",
      email_address: ""
    )

    assert customer.valid?
  end

  test "customer cannot have an invalid email address" do
    customer = Customer.new(
      full_name: "Jane Doe",
      phone_number: "204-555-1234",
      email_address: "invalid-email"
    )

    assert_not customer.valid?
    assert customer.errors[:email_address].any?
  end
end
