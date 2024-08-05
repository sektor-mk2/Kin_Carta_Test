import time

from playwright.sync_api import Page, expect
import re
from .BasePage import BasePage


class BrokersList(BasePage):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        # init locators
        self.brokers_loc = self.page.locator(".MuiGrid-item")
        self.search_name_loc = self.page.locator("input#broker-keyword")
        self.clear_search_loc = self.page.get_by_role("button").get_by_text("Clear")

    def validate_is_current(self):
        """
        All page objects should provide a method that validates if this is the currently open page
        """

        # Ideally this method should be more detailed
        expect(self.page).to_have_title(re.compile("Yavlena"))

    def search(self, name: str):
        self.search_name_loc.fill(name)
        self.smart_wait()

    def clear_search(self):
        self.clear_search_loc.click()
        self.smart_wait()

    def expand(self):
        self.brokers_loc.get_by_role("button").get_by_text("Details").first.click()

    def load_all_brokers(self):
        """
        WARNING:
        Page under test uses an infinite scroll functionality. This is standard practice and easy to automate

        Unfortunately this scroll is buggy
        This has nothing to do with automation, it is trivial to break it manually, without automation and not load brokers

        Automating buggy software is a lot more expensive than automating working software
        The good practice is to negotiate with PO to get it fixed first
        Unfortunately we are not in this situation

        I reverse-engineered how it works and this functionality is a hacky workaround
        Current implementation is expected to work under different broker counts and under different resolutions
        """
        while True:
            before_scroll = len(self.brokers_loc.all())
            self.page.evaluate("window.scrollBy(0, document.body.scrollHeight / 8)")
            self.smart_wait()
            self.page.evaluate("window.scrollBy(0, document.body.scrollHeight / 8)")
            self.smart_wait()
            self.page.evaluate("window.scrollBy(0, document.body.scrollHeight / 8)")
            self.smart_wait()
            self.page.evaluate("window.scrollBy(0, document.body.scrollHeight / 8)")
            self.smart_wait()
            self.brokers_loc.all()[0].scroll_into_view_if_needed()
            self.smart_wait()
            after_scroll = len(self.brokers_loc.all())
            if before_scroll == after_scroll:
                break

    def get_brokers(self):
        return [loc.locator("h6").text_content() for loc in self.brokers_loc.all()]
