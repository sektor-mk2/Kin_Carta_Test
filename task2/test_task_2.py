import re
from playwright.sync_api import Page, expect
from pages.BrokersList import BrokersList

BASE_URL = "https://www.yavlena.com/en/broker?city=Sofia"


def test_task_2(page: Page):
    current = BrokersList(page, BASE_URL)
    current.goto()
    current.validate_is_current()
    current.load_all_brokers()
    names = current.get_brokers()

    # WARNING
    # The remainder of the code has data validation
    # The good practice is for QA to provide expected test data
    # Page object to provide api for extracting that data
    # Then the test is to compare expected with actual data
    # But I ran out of time so the following cuts corners

    # validate all brokers exist
    expected = 130
    actual = len(names)
    assert expected == actual, f"Expected brokers: {expected}, Actual brokers: {actual}"

    for name in names:
        current.search(name=name)

        # Please note Playwright has a functionality called soft assertions which would be very convenient here
        # They do not interrupt the test, print output, but also populate the test report
        # Unfortunately they are not ported to Python from the JS api

        # validate only 1 broker is loaded
        try:
            expect(page.locator(".MuiGrid-item")).to_have_count(1)
        except AssertionError:
            expected = 1
            actual = len(page.locator(".MuiGrid-item").all())
            print(f"WARNING: Multiple brokers called {name}, Expected: {expected}, Actual: {actual}")
            print(f"WARNING: Ignoring this broker")
            current.clear_search()
            continue

        # validate the correct broker is loaded
        expect(page.locator(".MuiGrid-item")).to_contain_text(name)

        current.expand()
        # validate data
        expect(page.locator(".MuiGrid-item")).to_contain_text(" properties")

        try:
            expect(page.locator(".MuiGrid-item").locator('[data-testid="BadgeOutlinedIcon"]')).to_have_count(1)
        except AssertionError:
            expected = 1
            actual = len(page.locator(".MuiGrid-item").locator('[data-testid="BadgeOutlinedIcon"]').all())
            print(f"WARNING: Broker is {name}, Expected Addresses: {expected}, Actual Addresses {actual}")

        try:
            expect(page.locator(".MuiGrid-item").locator('[data-testid="PhoneOutlinedIcon"]')).to_have_count(2)
        except AssertionError:
            expected = 2
            actual = len(page.locator(".MuiGrid-item").locator('[data-testid="PhoneOutlinedIcon"]').all())
            print(f"WARNING: Broker is {name}, Expected Phones: {expected}, Actual Phones {actual}")

        current.clear_search()
