# download the the list of course id and url from MIT OpenCourseWare

from bs4 import BeautifulSoup

root="http://ocw.mit.edu"

def extract_id_url(source_htm):
    soup = BeautifulSoup(open(source_htm).read())
    alltrs = soup.findAll("tr")
    for tr in alltrs:
        allas = tr.findAll('a')
        if len(allas) == 3:
            print allas[0].text.strip(), root+allas[0]['href']

if __name__ == "__main__":
    extract_id_url("courses.htm")
