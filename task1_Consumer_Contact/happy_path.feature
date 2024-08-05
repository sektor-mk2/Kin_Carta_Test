Feature: Consumer Contact - Happy Path
    As a non-logged in user
    I want to be able to submit a customer feedback

# Note on file upload
# All happy path tests run an example with all fields filled, including a file upload, and another example with only mandatory fields
# Feel free to comment (and disable) the example with file upload, if the batch volume becomes a problem
# A good compromise would be to have file upload on 1-2 places only and comment the rest

# Note on special characters and symbols
# I believe the tests below are sufficient, but in case the product has repeating issues with special characters and symbols
# we could easily extend existing examples with an instance with rare symbols
# extensibility here is by design

    Scenario: Happy path for topic "Delivery, Return or Refund"
        Given I open an url
            | url                   |
            | URLS.CUSTOMER_SUPPORT |
        When I select a topic 
            | topic                         |
            | Delivery, Return or Refund    |
        And I navigate to next customer support page
        And I submit form for "Delivery, Return or Refund" with the following data
            | order_number      | item      | description       | first_name        | last_name     | email       | verify_email       | phone_nat       | phone       | country     | file        |
            | "<order_number>"  | "<item>"  | "<description>"   | "<first_name>"    | "<last_name>" | "<email>"   | "<verify_email>"   | "<phone_nat>"   | "<phone>"   | "<country>" | "<file>"    |
        Then my customer feedback is submitted successfully

        Examples:
            | order_number          | item      | description       | first_name        | last_name     | email                 | verify_email          | phone_nat | phone | country | file                |
            # example with all fields, this includes a file
            | aqa_order_number_123  | aqa_item  | aqa_description   | aqa_first_name    | aqa_last_name | aqa_email@email.com   | aqa_email@email.com   | UK        | 123   | UK      | path_to_file.png    |
            # example with only mandatory fields
            | aqa_order_number_123  | aqa_item  | aqa_description   | aqa_first_name    | aqa_last_name | aqa_email@email.com   | aqa_email@email.com   | UK        | 123   | UK      |                     |

    Scenario: Happy path for topic "Order or Payment Related"
        Given I open an url
            | url                   |
            | URLS.CUSTOMER_SUPPORT |
        When I select a topic 
            | topic                         |
            | Order or Payment Related      |
        And I navigate to next customer support page
        And I submit form for "Order or Payment Related" with the following data
            | description       | first_name        | last_name     | email       | verify_email       | phone_nat      | phone       | street_1      | street_2      | city      | postal           | country        | file        |
            | "<description>"   | "<first_name>"    | "<last_name>" | "<email>"   | "<verify_email>"   | "<phone_nat>"  | "<phone>"   | "<street_1>"  | "<street_2>"  | "<city>"  | "<postal>"       | "<country>"    | "<file>"    |
        Then my customer feedback is submitted successfully

        Examples:
            | description       | first_name        | last_name     | email                 | verify_email          | phone_nat | phone | street_1      | street_2      | city      | postal    | country | file                |
            # example with all fields, this includes a file
            | aqa_description   | aqa_first_name    | aqa_last_name | aqa_email@email.com   | aqa_email@email.com   | UK        | 123   | aqa street 1  | aqa street 2  | London    | 123       | UK      | path_to_file.png    |
            # example with only mandatory fields
            | aqa_description   | aqa_first_name    | aqa_last_name | aqa_email@email.com   | aqa_email@email.com   | UK        | 123   | aqa street 1  |               | London    | 123       | UK      |                     |

    Scenario: Happy path for topic "Product Registration"
        Given I open an url
            | url                   |
            | URLS.CUSTOMER_SUPPORT |
        When I select a topic 
            | topic                   |
            | Product Registration    |
        And I navigate to next customer support page
        And I submit form for "Product Registration" with the following data
            | serial     | no_serial     | purchase_date         | purchase_location        | description       | first_name        | last_name     | email       | verify_email       | phone_nat     | phone      | street_1      | street_2      | city      | postal     | country       | file        |
            | "<serial>" | "<no_serial>" | "<purchase_date>"     | "<purchase_location>"    | "<description>"   | "<first_name>"    | "<last_name>" | "<email>"   | "<verify_email>"   | "<phone_nat>" | "<phone>"  | "<street_1>"  | "<street_2>"  | "<city>"  | "<postal>" | "<country>"   | "<file>"    |
        Then my customer feedback is submitted successfully

        Examples:
            | serial    | no_serial    | purchase_date | purchase_location | description       | first_name        | last_name     | email                 | verify_email          | phone_nat | phone | street_1      | street_2      | city      | postal    | country | file                |
            # example with all fields, this includes a file
            | 123       |              | 07-Aug-2024   | Online            | aqa_description   | aqa_first_name    | aqa_last_name | aqa_email@email.com   | aqa_email@email.com   | UK        | 123   | aqa street 1  | aqa street 2  | London    | 123       | UK      | path_to_file.png    |
            # example with only mandatory fields
            | 123       |              | 07-Aug-2024   | Online            | aqa_description   | aqa_first_name    | aqa_last_name | aqa_email@email.com   | aqa_email@email.com   | UK        | 123   | aqa street 1  |               | London    | 123       | UK      |                     |
            # test case - no serial and some data variation
            |           | True         | 07-Aug-2024   | Shop              | aqa_description   | aqa_first_name    | aqa_last_name | aqa_email@email.com   | aqa_email@email.com   | UK        | 123   | aqa street 1  |               | London    | 123       | UK      |                     |

    Scenario: Happy path for topic "Product Information"
        Given I open an url
            | url                   |
            | URLS.CUSTOMER_SUPPORT |
        When I select a topic 
            | topic                  |
            | Product Information    |
        And I navigate to next customer support page
        And I submit form for "Product Information" with the following data
            | item     | description       | first_name        | last_name     | email       | verify_email       | phone_nat       | phone      | street_1      | street_2      | city      | country      | file        |
            | "<item>" | "<description>"   | "<first_name>"    | "<last_name>" | "<email>"   | "<verify_email>"   | "<phone_nat>"   | "<phone>"  | "<street_1>"  | "<street_2>"  | "<city>"  | "<country>"  | "<file>"    |
        Then my customer feedback is submitted successfully

        Examples:
            | item         | description       | first_name        | last_name     | email                 | verify_email          | phone_nat | phone | street_1      | street_2      | city      | country | file                |
            # example with all fields, this includes a file
            | aqa_item_123 | aqa_description   | aqa_first_name    | aqa_last_name | aqa_email@email.com   | aqa_email@email.com   | UK        | 123   | aqa street 1  | aqa street 2  | London    | UK      | path_to_file.png    |
            # example with only mandatory fields
            | aqa_item_123 | aqa_description   | aqa_first_name    | aqa_last_name | aqa_email@email.com   | aqa_email@email.com   | UK        | 123   | aqa street 1  |               | London    | UK      |                     |

    Scenario: Happy path for topic "Maintenance and Usage"
        Given I open an url
            | url                   |
            | URLS.CUSTOMER_SUPPORT |
        When I select a topic 
            | topic                    |
            | Maintenance and Usage    |
        And I navigate to next customer support page
        And I submit form for "Maintenance and Usage" with the following data
            | item     | description       | first_name        | last_name     | email       | verify_email       | phone_nat       | phone       | street_1      | street_2      | city      | country          | file        |
            | "<item>" | "<description>"   | "<first_name>"    | "<last_name>" | "<email>"   | "<verify_email>"   | "<phone_nat>"   | "<phone>"   | "<street_1>"  | "<street_2>"  | "<city>"  | "<country>"      | "<file>"    |
        Then my customer feedback is submitted successfully

        Examples:
            | item         | description       | first_name        | last_name     | email                 | verify_email          | phone_nat | phone | street_1      | street_2      | city      | country | file                |
            # example with all fields, this includes a file
            | aqa_item_123 | aqa_description   | aqa_first_name    | aqa_last_name | aqa_email@email.com   | aqa_email@email.com   | UK        | 123   | aqa street 1  | aqa street 2  | London    | UK      | path_to_file.png    |
            # example with only mandatory fields
            | aqa_item_123 | aqa_description   | aqa_first_name    | aqa_last_name | aqa_email@email.com   | aqa_email@email.com   | UK        | 123   | aqa street 1  |               | London    | UK      |                     |

    Scenario: Happy path for topic "General Question"
        Given I open an url
            | url                   |
            | URLS.CUSTOMER_SUPPORT |
        When I select a topic 
            | topic                         |
            | General Question    |
        And I navigate to next customer support page
        And I submit form for "General Question" with the following data
            | description       | first_name        | last_name     | email       | verify_email       | phone_nat      | phone       | country         | file        |
            | "<description>"   | "<first_name>"    | "<last_name>" | "<email>"   | "<verify_email>"   | "<phone_nat>"  | "<phone>"   | "<country>"     | "<file>"    |
        Then my customer feedback is submitted successfully

        Examples:
            | description       | first_name        | last_name     | email                 | verify_email          | phone_nat | phone | country | file                |
            # example with all fields, this includes a file
            | aqa_description   | aqa_first_name    | aqa_last_name | aqa_email@email.com   | aqa_email@email.com   | UK        | 123   | UK      | path_to_file.png    |
            # example with only mandatory fields
            | aqa_description   | aqa_first_name    | aqa_last_name | aqa_email@email.com   | aqa_email@email.com   | UK        | 123   | UK      |                     |
