#!/bin/sh

# create 3000 votes (2000 for option a, 1000 for option b)
ab -n 50 -c 10 -p posta -T "application/x-www-form-urlencoded" http://nginx:8001/
ab -n 50 -c 10 -p postb -T "application/x-www-form-urlencoded" http://nginx:8001/
ab -n 50 -c 10 -p posta -T "application/x-www-form-urlencoded" http://nginx:8001/
