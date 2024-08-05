from playwright.sync_api import Page
from .utils import continuous_wait


class BasePage:
    def __init__(self, page: Page, url: str):
        self.page = page
        self.url = url
        self.pendingRequests = set()

        def add_r(r):
            banned_urls = [
                ".clarity.ms",
                "facebook.com",
                "userimages.yavlena.com",
                "yavlena.com/bg/api/auth/session",
                "conversations-widget.brevo.com",
                ".analytics.google.com",
                ".googletagmanager.com",
                ".hotjar.io"
            ]

            for banned in banned_urls:
                if banned in r.url:
                    return

            self.pendingRequests.add(r)

        def remove_r(r):
            if r in self.pendingRequests:
                self.pendingRequests.remove(r)

        self.page.on("request", add_r)
        self.page.on("response", lambda response: remove_r(response.request))
        self.page.on("requestfinished", remove_r)
        self.page.on("requestfailed", remove_r)

    def goto(self):
        self.page.goto(self.url)

    def smart_wait(self):
        """
            Here lives our strategy for waiting for the page to load
            By default Playwright waits correctly, this covers the cases when it does not

            This implementation waits for the network to be idle for <length> milliseconds
            Network idle by itself is almost never a sufficient condition
            But waiting for a continuous interval of idleness solves 99% of issues

            Side Note:
            Network idle is a heuristics approach, you may not agree with it
            A better strategy would be to inject some JS in browser and wait for the web framework we use
            For example - ready state of jquery or angular
            But that is project-dependent
            My current implementation is generic and this is a better starting point
            I use it in multiple projects and it works well

            Critical Side Note:
            Please note that the playwright network API is a bit buggy
            This has nothing to do with the app under test or with the chosen waiting strategy, but with the tool
            Workarounds are easy, but I have not caught all cases for this app

            Side Note:
            Out of the box Playwright offers functionality that looks similar to this
            Do not use that
            Docs are misleading, it does something different

            Sode Note:
            In our industry, when the default strategy of playwright is not enough we often do the following
            We wait explicitly for a specific dynamic element
            This solves the same problem of waiting for the page all over and over again repeatedly on case by case basis
            Please do not do that

            Side Note:
            Please note that app under test has a performance problem and a specific request to your BE api takes too long

            Length param should not be lower than 500, may break on req chains
            Length param should not be higher than 1000, may break on analitics
        """

        def condition():
            return len(self.pendingRequests) == 0

        try:
            continuous_wait(condition, 0.7, 10)
        except:
            print(f"WARNING: the following requests are taking too long: {self.pendingRequests}")
