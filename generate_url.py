from typing import List
import sys
import itertools
import datetime
import requests
import calendar
import humanfriendly


PRINT_URLS = True  # prints urls instead of date/filesize


def days(year: int, month: int, weekday: int) -> List[datetime.date]:
    """Returns all dates that are a specific `weekday` on a specific `month`/`year`."""
    return [datetime.date(year, month, week[weekday]) for week in calendar.monthcalendar(year, month) if week[weekday] > 0]


def generate_url(d: datetime.date, pcap=False):
    date = f'{d.year}{d.month:02d}{d.day:02d}1400'
    extension = 'pcap' if pcap else 'dump'
    url = f'http://mawi.nezu.wide.ad.jp/mawi/samplepoint-F/{year}/{date}.{extension}.gz'
    return url


def request_date(date, pcap=False):
    url = generate_url(date, pcap)
    response = requests.head(url)
    if PRINT_URLS:
        response.headers['content-length']
        print(url)
    else:
        print(f'{date}: {humanfriendly.format_size(int(response.headers["content-length"]))}')


if __name__ == '__main__':
    year = int(sys.argv[1])
    month = int(sys.argv[2])
    nr = int(sys.argv[3])
    d = days(year, month, 2)[nr]  # 2 is wednesdays
    try:
        request_date(d)
    except KeyError:
        request_date(d, True)
#    years = [2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019]
#    months = [1, 7]
#    for year, month in itertools.product(years, months):
#        if year == 2019 and month == 7:  # skip future
#            continue
#        for d in days(year, month, 2)[:4]:  # 2 is wednesdays
#            try:
#                request_date(d)
#            except KeyError:
#                request_date(d, True)

