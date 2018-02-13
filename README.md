# Refigured to work with an Anaconda install of Python3 on MacOS 10.13.3 and email positive results

# Campsite Availability Scraping
This is a simple script for scraping availability of campgrounds! The recreation.gov api doesn't reveal campsite availability, so this script spoofs a session through their search portal to allow programmatic polling of campsite availability.

It's currently hardcoded for yosemite, but with a bit of network sniffing you can reconfigure for other national parks.

### Sample Output
List of campsites with availabilities on queried dates + links.
```
UPPER PINES, Booking Url: http://www.recreation.gov/unifSearchInterface.do?interface=bookcamp&contractCode=NRSO&parkId=70925
LOWER PINES, Booking Url: http://www.recreation.gov/unifSearchInterface.do?interface=bookcamp&contractCode=NRSO&parkId=70928
NORTH PINES, Booking Url: http://www.recreation.gov/unifSearchInterface.do?interface=bookcamp&contractCode=NRSO&parkId=70927
```

# Instructions
Install requirements:
```
pip install -r requirements.txt
```
Use: `python campsites.py --start_date 2015-04-24 --end_date 2015-04-25`

Best use is to set a crontab on a ~5 minute interval (I've found that a 10-minute interval is too long because the campsites will be taken by the time I'm able to act on the alert).

To configure gmail to send from within the shell script follow the directions found here:
https://codana.me/2014/11/23/sending-gmail-from-os-x-yosemite-terminal/

I recommend setting up a special purpose gmail account which you do not use for anything else.  That way you do not need to use 2-factor and you can configure the security settings to low.

`campsites.sh` Now sends an email with the Booking URL to you.

## Searching for parks other than Yosemite

### Get LOCATION_PAYLOAD request data
* Use your preferred proxy or network analyzer to capture requests (Charles Proxy, Wireshark, etc)
* Visit recreation.gov in your browser
* Enter target park name - click the park in the prefilled Auto-suggest dropdown that appears
* Find logs for the POST request to www.recreation.gov/unifSearch.do
* Copy the REQUEST body params as JSON into the `LOCATION_PAYLOAD` dict in `campsites.py`
* (keep the search results page open and continue to next section)

### Whitelist campsites by id in PARKS dict
* From the list of campgrounds and attractions listed in the results for your park, choose the campgrounds you'd like to stay at
* For each campground you choose, copy the campground's link URL
* Grab the parkId URL param and add it as a key to the PARKS dict in `campsites.py`, the value should be a human readable campground name.


