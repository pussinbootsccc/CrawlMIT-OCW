# extract the table contents from HTML (with the content order preserved)
from bs4 import BeautifulSoup
import sys
soup = BeautifulSoup(open(sys.argv[1]).read())
alltrs = soup.findAll("tr")
lec = []
for tr in alltrs:
    tds = tr.findAll("td")
    if len(tds) >= 2 and len(tds[1].text) > 0:
       lec.append(' '.join(tds[1].text.splitlines()))
nlec = len(lec)
calendar = " # ".join(lec).encode('utf-8')
if nlec != 0 and len(calendar)/nlec > 15:
    print calendar,
