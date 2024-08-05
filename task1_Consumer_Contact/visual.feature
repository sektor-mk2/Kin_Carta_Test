Feature: Consumer Contact - Visual

    Scenario: Visual Test
        Given I open an url
            | url                   |
            | URLS.CUSTOMER_SUPPORT |
        When I select a topic 
            | topic     |
            | "<topic>" |
        And I expand all FAQ questions
        Then what I see is the same as the screenshot
            | screenshot        |
            | "<screenshot_p1>" |
        When I navigate to next customer support page
        Then what I see is the same as the screenshot
            | screenshot        |
            | "<screenshot_p2>" |
        
        Examples:
            | topic                         | screenshot_p1     | screenshot_p2     |
            | Delivery, Return or Refund    | path_to_file.png  | path_to_file.png  |
            | Order or Payment Related      | path_to_file.png  | path_to_file.png  |
            | Product Registration          | path_to_file.png  | path_to_file.png  |
            | Product Information           | path_to_file.png  | path_to_file.png  |
            | Maintenance and Usage         | path_to_file.png  | path_to_file.png  |
            | General Question              | path_to_file.png  | path_to_file.png  |
