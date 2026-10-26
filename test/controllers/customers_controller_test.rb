
require "test_helper"

class CustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get index and display customers" do
    Customer.create!(
      full_name: "Jane Doe",
      phone_number: "204-555-1234",
      email_address: "jane@example.com"
    )

    get root_url

    assert_response :success
    assert_select "h1", text: /Customers/i
    assert_select "h2", text: "Jane Doe"
    assert_select "p", text: /204-555-1234/
    assert_select "p", text: /jane@example.com/
  end

  test "should get alphabetized" do
    get customers_alphabetized_url
    assert_response :success
  end

  test "should get missing_email" do
    get customers_missing_email_url
    assert_response :success
  end
end
