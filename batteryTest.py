#!/usr/bin/env python2.7  
# script to log to a file every 60 seconds  
# by Alex Eames http://RasPi.TV  
# http://raspi.tv/?p=3516  
# the idea is that when the power gets cut, we'll be  
# able to see what the last reading was and work out  
# how long the battery powered the Pi for  
  
import time  
from time import gmtime, strftime  
  
def write_log(logline):  
    logfile = open('battery_log-RS.txt', 'a')  
    logfile.write(logline + '\n')  
    logfile.close()  
  
# create log file, overwriting any previous one  
item = 'Battery log data'  
logfile = open('battery_log-RS.txt', 'w')  
logfile.write(item + '\n')  
logfile.close()  
  
while True:  
    logline = str(strftime("%Y-%m-%d %H:%M:%S", gmtime()))  
    print "adding %s to log file" % logline  
    write_log(logline)  
    time.sleep(60)
