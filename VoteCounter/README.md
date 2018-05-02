#clone the project to your ec2 instance(linux)
git clone https://github.com/jacksonleehk01/01_onsite_test.git

#enter the directory
cd VoteCounter

#install virtual env
virtualenv -p python3 venv

#activate virtual env
source venv/bin/activate

#install the requirements
pip3 install -r requirements.txt

#Run the program
python3 run.py

#at browser enter (where 0.0.0.0 should replace by the public IP of your EC2 instance
http://0.0.0.0:8008

