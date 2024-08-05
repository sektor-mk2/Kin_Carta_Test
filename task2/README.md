# DATA

- Difficulty: easy, business as usual  
- Time: 2.5 days, half of time was waking up Python habits from sleep and translating Playwright experience from JS to Python

# HOW TO SETUP THIS PROJECT

From this folder:
```
pip install -r requirements.txt
playwright install
```

# HOW TO RUN THIS PROJECT

From this folder:
```
pytest -s --headed
```
- s param is for printing output
- headed param is so you see the browser

# STABILITY

The purpose of automation is to save time. Poorly done automation wastes resources instead
One way this happens (but not the only way) is unstable tests.
Tests must not be 90% stable, they must be 99% stable
The challenge for this particular page are:
- infinite scroll is broken, can be easily reproduced manually
- looks like BE api has a performance problem

I have workarounds for those, so I hit the 99% mark