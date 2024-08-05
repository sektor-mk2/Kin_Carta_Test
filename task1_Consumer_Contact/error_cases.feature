Feature: Consumer Contact - Error Cases

# Note on single responsibility principle
# Here a test is responsible for multiple error cases on multiple fields
# This violates the principle that a single test should have a single responsibility
# The benefit is performance, more manageable volume of code, less noisy test results

# Alternatively we may agree to test email validation on only one of these pages, less coverage, but simpler

    Scenario: Error cases for topic "Delivery, Return or Refund"
        Given I open an url
            | url                   |
            | URLS.CUSTOMER_SUPPORT |
        When I select a topic 
            | topic                         |
            | Delivery, Return or Refund    |
        And I navigate to next customer support page
        # Case - missing mandatory fields
        And I submit form for "Delivery, Return or Refund" with the following data
            | order_number      | item      | description       | first_name        | last_name     | email     | verify_email      | phone | country |
            |                   |           |                   |                   |               |           |                   |       |         |
        Then I see the following errors on topic "Delivery, Return or Refund"
            | order_number        | item                | description         | first_name          | last_name           | email               | verify_email        | phone                 | country                |
            | "copy err from app" | "copy err from app" | "copy err from app" | "copy err from app" | "copy err from app" | "copy err from app" | "copy err from app" | "copy err from app"   | "copy err from app"    |
        # Case - malformed email
        And I submit form for "Delivery, Return or Refund" with the following data
            | order_number          | item      | description       | first_name        | last_name     | email           | verify_email    | phone_nat | phone | country |
            | aqa_order_number_123  | aqa_item  | aqa_description   | aqa_first_name    | aqa_last_name | broken@broken   | broken@broken   | UK        | 123   | UK      |
        Then I see the following errors on topic "Delivery, Return or Refund"
            | email                 |
            | "copy err from app"   |
        # Case - 2 emails mismatch
        And I submit form for "Delivery, Return or Refund" with the following data
            | order_number          | item      | description       | first_name        | last_name     | email                 | verify_email          | phone_nat | phone | country |
            | aqa_order_number_123  | aqa_item  | aqa_description   | aqa_first_name    | aqa_last_name | aqa_email1@email.com  | aqa_email2@email.com  | UK        | 123   | UK      |
        Then I see the following errors on topic "Delivery, Return or Refund"
            | verify_email          |
            | "copy err from app"   |

    Scenario: Error cases for topic "Order or Payment Related"
        Given I open an url
            | url                   |
            | URLS.CUSTOMER_SUPPORT |
        When I select a topic 
            | topic                         |
            | Order or Payment Related      |
        And I navigate to next customer support page
        # Case - missing mandatory fields
        And I submit form for "Order or Payment Related" with the following data
            | description     | first_name    | last_name     | email     | verify_email  | phone | street_1      | city      | postal    | country |
            |                 |               |               |           |               |       |               |           |           |         |
        Then I see the following errors on topic "Order or Payment Related"
            | description           | first_name             | last_name           | email                 | verify_email          | phone                 | street_1             | city                   | postal               | country                |
            | "copy err from app"   | "copy err from app"    | "copy err from app" | "copy err from app"   | "copy err from app"   | "copy err from app"   | "copy err from app"  | "copy err from app"    | "copy err from app"  | "copy err from app"    |
        # Case - malformed email
        And I submit form for "Order or Payment Related" with the following data
            | description       | first_name        | last_name     | email           | verify_email    | phone_nat | phone | street_1      | street_2      | city      | postal    | country |
            | aqa_description   | aqa_first_name    | aqa_last_name | broken@broken   | broken@broken   | UK        | 123   | aqa street 1  | aqa street 2  | London    | 123       | UK      |
        Then I see the following errors on topic "Order or Payment Related"
            | email                 |
            | "copy err from app"   |
        # Case - 2 emails mismatch
        And I submit form for "Order or Payment Related" with the following data
            | description       | first_name        | last_name     | email                  | verify_email           | phone_nat | phone | street_1      | street_2      | city      | postal    | country |
            | aqa_description   | aqa_first_name    | aqa_last_name | aqa_email1@email.com   | aqa_email2@email.com   | UK        | 123   | aqa street 1  | aqa street 2  | London    | 123       | UK      |
        Then I see the following errors on topic "Order or Payment Related"
            | verify_email          |
            | "copy err from app"   |

    Scenario: Error cases for topic "Product Registration"
        Given I open an url
            | url                   |
            | URLS.CUSTOMER_SUPPORT |
        When I select a topic 
            | topic                   |
            | Product Registration    |
        And I navigate to next customer support page
        # Case - missing mandatory fields
        And I submit form for "Product Registration" with the following data
            | serial   | purchase_date | purchase_location | description    | first_name    | last_name     | email         | verify_email  | phone | street_1     | city      | country |
            |          |               |                   |                |               |               |               |               |       |              |           |         |
        Then I see the following errors on topic "Product Registration"
            | serial                 | purchase_date         | purchase_location    | description           | first_name             | last_name           | email                 | verify_email          | phone                 | street_1             | city                 | country                  |
            | "copy err from app"    | "copy err from app"   | "copy err from app"  | "copy err from app"   | "copy err from app"    | "copy err from app" | "copy err from app"   | "copy err from app"   | "copy err from app"   | "copy err from app"  | "copy err from app"  | "copy err from app"      |
        # Case - malformed email and malformed date
        And I submit form for "Product Registration" with the following data
            | serial    | no_serial    | purchase_date | purchase_location | description       | first_name        | last_name     | email           | verify_email    | phone_nat | phone | street_1      | street_2      | city      | country |
            | 123       |              | 123           | Online            | aqa_description   | aqa_first_name    | aqa_last_name | broken@broken   | broken@broken   | UK        | 123   | aqa street 1  | aqa street 2  | London    | UK      |
        Then I see the following errors on topic "Product Registration"
            | purchase_date        | email                 |
            | "copy err from app"  | "copy err from app"   |
        # Case - 2 emails mismatch
        And I submit form for "Product Registration" with the following data
            | serial    | no_serial    | purchase_date | purchase_location | description       | first_name        | last_name     | email                  | verify_email           | phone_nat | phone | street_1      | street_2      | city      | country |
            | 123       |              | 07-Aug-2024   | Online            | aqa_description   | aqa_first_name    | aqa_last_name | aqa_email1@email.com   | aqa_email2@email.com   | UK        | 123   | aqa street 1  | aqa street 2  | London    | UK      |
        Then I see the following errors on topic "Product Registration"
            | verify_email          |
            | "copy err from app"   |

    Scenario: Error cases for topic "Product Information"
        Given I open an url
            | url                   |
            | URLS.CUSTOMER_SUPPORT |
        When I select a topic 
            | topic                  |
            | Product Information    |
        And I navigate to next customer support page
        # Case - missing mandatory fields
        And I submit form for "Product Information" with the following data
            | item         | description       | first_name        | last_name     | email     | verify_email  | phone | street_1     | city      | country |
            |              |                   |                   |               |           |               |       |              |           |         |
        Then I see the following errors on topic "Product Information"
            | item                | description           | first_name             | last_name           | email                 | verify_email          | phone                 | street_1             | city                   | country               |
            | "copy err from app" | "copy err from app"   | "copy err from app"    | "copy err from app" | "copy err from app"   | "copy err from app"   | "copy err from app"   | "copy err from app"  | "copy err from app"    | "copy err from app"   |
        # Case - malformed email
        And I submit form for "Product Information" with the following data
            | item         | description       | first_name        | last_name     | email           | verify_email    | phone_nat | phone | street_1      | street_2      | city      | country |
            | aqa_item_123 | aqa_description   | aqa_first_name    | aqa_last_name | broken@broken   | broken@broken   | UK        | 123   | aqa street 1  | aqa street 2  | London    | UK      |
        Then I see the following errors on topic "Product Information"
            | email                 |
            | "copy err from app"   |
        # Case - 2 emails mismatch
        And I submit form for "Product Information" with the following data
            | item         | description       | first_name        | last_name     | email                  | verify_email           | phone_nat | phone | street_1      | street_2      | city      | country |
            | aqa_item_123 | aqa_description   | aqa_first_name    | aqa_last_name | aqa_email1@email.com   | aqa_email2@aqa_email   | UK        | 123   | aqa street 1  | aqa street 2  | London    | UK      |
        Then I see the following errors on topic "Product Information"
            | verify_email          |
            | "copy err from app"   |

    Scenario: Error cases for topic "Maintenance and Usage"
        Given I open an url
            | url                   |
            | URLS.CUSTOMER_SUPPORT |
        When I select a topic 
            | topic                    |
            | Maintenance and Usage    |
        And I navigate to next customer support page
        # Case - missing mandatory fields
        And I submit form for "Maintenance and Usage" with the following data
            | item         | description       | first_name        | last_name     | email         | verify_email      | phone | street_1    | city     | country |
            |              |                   |                   |               |               |                   |       |             |          |         |
        Then I see the following errors on topic "Maintenance and Usage"
            | item                | description           | first_name             | last_name           | email                 | verify_email          | phone                 | street_1             | city                   | country                  |
            | "copy err from app" | "copy err from app"   | "copy err from app"    | "copy err from app" | "copy err from app"   | "copy err from app"   | "copy err from app"   | "copy err from app"  | "copy err from app"    | "copy err from app"      |
        # Case - malformed email
        And I submit form for "Maintenance and Usage" with the following data
            | item         | description       | first_name        | last_name     | email           | verify_email    | phone_nat | phone | street_1      | street_2      | city      | country |
            | aqa_item_123 | aqa_description   | aqa_first_name    | aqa_last_name | broken@broken   | broken@broken   | UK        | 123   | aqa street 1  | aqa street 2  | London    | UK      |
        Then I see the following errors on topic "Maintenance and Usage"
            | email                 |
            | "copy err from app"   |
        # Case - 2 emails mismatch
        And I submit form for "Maintenance and Usage" with the following data
            | item         | description       | first_name        | last_name     | email                  | verify_email           | phone_nat | phone | street_1      | street_2      | city      | country |
            | aqa_item_123 | aqa_description   | aqa_first_name    | aqa_last_name | aqa_email1@email.com   | aqa_email2@email.com   | UK        | 123   | aqa street 1  | aqa street 2  | London    | UK      |
        Then I see the following errors on topic "Maintenance and Usage"
            | verify_email          |
            | "copy err from app"   |

    Scenario: Error cases for topic "General Question"
        Given I open an url
            | url                   |
            | URLS.CUSTOMER_SUPPORT |
        When I select a topic 
            | topic                         |
            | General Question    |
        And I navigate to next customer support page
        # Case - missing mandatory fields
        And I submit form for "General Question" with the following data
            | description       | first_name        | last_name     | email                 | verify_email          | phone | country |
            |                   |                   |               |                       |                       |       |         |
        Then I see the following errors on topic "General Question"
            | description           | first_name            | last_name           | email                 | verify_email          | phone                 | country                  |
            | "copy err from app"   | "copy err from app"   | "copy err from app" | "copy err from app"   | "copy err from app"   | "copy err from app"   | "copy err from app"      |
        # Case - malformed email
        And I submit form for "General Question" with the following data
            | description       | first_name        | last_name     | email           | verify_email    | phone_nat | phone | country |
            | aqa_description   | aqa_first_name    | aqa_last_name | broken@broken   | broken@broken   | UK        | 123   | UK      |
        Then I see the following errors on topic "General Question"
            | email                 |
            | "copy err from app"   |
        # Case - 2 emails mismatch
        And I submit form for "General Question" with the following data
            | description       | first_name        | last_name     | email                  | verify_email           | phone_nat | phone | country |
            | aqa_description   | aqa_first_name    | aqa_last_name | aqa_email1@email.com   | aqa_email2@email.com   | UK        | 123   | UK      |
        Then I see the following errors on topic "General Question"
            | verify_email          |
            | "copy err from app"   |

