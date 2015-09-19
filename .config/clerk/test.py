#!/usr/bin/env python3

with open(r'/home/carnager/.config/clerk/test.cache', 'r') as f:
    for line in f:
        data = line.split('\t')    # Splits on whitespace
        print('{0[0]:<15}{0[1]:<15}{0[2]:<5}{0[3]:<15}{0[4]:>15}').format(data)
