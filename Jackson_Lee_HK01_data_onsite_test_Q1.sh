#By Jackson Lee

#Q1
#get file to local
wget ftp://ita.ee.lbl.gov/traces/NASA_access_log_Aug95.gz

#unzip the package, get the log 
gunzip NASA_access_log_Aug95.gz

#A) Count the total number of HTTP requests
cat NASA_access_log_Aug95 | grep -c -e '-0400] "GET'
#result = 1565812



#B) Find the top­10 (host) hosts makes most requests from 18th Aug to 20th Aug
cat NASA_access_log_Aug95 | grep -E "(18/Aug/1995|19/Aug/1995|20/Aug/1995)"|sort -n|cut -d' ' -f1|uniq -c|sort -rn|head -10
#result: (most left number is the request count)    
# 851 piweba4y.prodigy.com
# 612 www-b3.proxy.aol.com
# 602 www-c3.proxy.aol.com
# 539 piweba3y.prodigy.com
# 507 www-d1.proxy.aol.com
# 456 piweba5y.prodigy.com
# 430 www-d4.proxy.aol.com
# 419 www-c6.proxy.aol.com
# 411 www-b5.proxy.aol.com
# 395 www-b2.proxy.aol.com



#C) Find out the country with most requests originating from (according the source host/IP)
#Firstly, find the most request hostname
cat NASA_access_log_Aug95 |sort -n|cut -d' ' -f1|uniq -c|sort -rn|head -1
# result: 6530 edams.ksc.nasa.gov  <-this hostname requested for 6530 times

#let's resolve this hostname and reteive its IP
host edams.ksc.nasa.gov
#result edams.ksc.nasa.gov has address 163.206.118.106
#let's pass this ip to ipinfo.io API
curl ipinfo.io/163.206.118.10
#result:
# {
#   "ip": "163.206.118.10",
#   "city": "Cleveland",
#   "region": "Ohio",
#   "country": "US",
#   "loc": "41.4352,-81.8108",
#   "postal": "44135",
#   "org": "AS1843 National Aeronautics and Space Administration"
# }

#The hostname with the most requests is from US (United State).



