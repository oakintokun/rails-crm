
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

  
test "should display customers in alphabetical order" do
  Customer.create!(
    full_name: "Zara Williams",
    phone_number: "204-555-1111"
  )

  Customer.create!(
    full_name: "Alice Brown",
    phone_number: "204-555-2222"
  )

  get customers_alphabetized_url

  assert_response :success

  names = css_select(".customer-card h2").map(&:text)

  assert_operator names.index("Alice Brown"), :<, names.index("Zara Williams")
end


 
test "should display only customers with missing emails" do
  Customer.create!(
    full_name: "Daniel Smith",
    phone_number: "204-555-1111",
    email_address: ""
  )

  Customer.create!(
    full_name: "Michael Davis",
    phone_number: "204-555-2222",
    email_address: nil
  )

  Customer.create!(
    full_name: "Jane Doe",
    phone_number: "204-555-3333",
    email_address: "jane@example.com"
  )

  get customers_missing_email_url

  assert_response :success
  assert_select ".customer-card h2", text: "Daniel Smith"
  assert_select ".customer-card h2", text: "Michael Davis"
  assert_select ".customer-card h2", text: "Jane Doe", count: 0
end

end
