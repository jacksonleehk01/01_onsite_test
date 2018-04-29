from flask import Flask, render_template, request, send_from_directory, send_file, url_for
from datetime import datetime, timedelta
import time, os, fnmatch, shutil
import json
import csv
import collections

import os
app = Flask(__name__,static_url_path='')
 
poll_data = {
   'question' : 'Vote for the next CE',
   'fields'   : ['John_Tsang', 'Carrie_Lam', 'Woo_Kwok_Hing']
}
filename = 'static/vote_result.csv'
 
@app.route('/')
def root():
    return render_template('poll.html', data=poll_data)
 
@app.route('/poll')
def poll():
    vote = request.args.get('field')
    utc8 = datetime.now() + timedelta(hours=8)
    sttime = format(utc8,'%Y%m%d_%H:%M:%S')


    out = open(filename, 'a')
    out.write( vote + ','+ sttime + '\n' )
    out.close()

    votes_count = collections.Counter()
    with open('static/vote_result.csv') as input_file:
        for row in csv.reader(input_file, delimiter=','):
            votes_count[row[0]] += 1
            with open('static/count.csv', 'w') as csv_file:
                writer = csv.writer(csv_file)
                for (key, value) in votes_count.items():
                    writer.writerow([key, value])
 
    return render_template('thankyou.html', data=poll_data)

@app.route('/count') # this is a job for GET, not POST
def plot_csv():
    return url_for('static', filename='count.csv')

@app.route('/static/<path:path>')
def send_js(path):
    return send_from_directory('static', path)

@app.route('/results')
def show_results():
    votes = {}
    for f in poll_data['fields']:
        votes[f] = 0
 
    f  = open(filename, 'r')
    for line in f:
        vote = x = line.split(',')[0]
        votes[vote] += 1
 
    return render_template('results.html', data=poll_data, votes=votes)
 
  
if __name__ == "__main__":
    app.run(host = '0.0.0.0',port=8008)
 
