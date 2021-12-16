# HHA 504 E2E 
 Database Design final assignment

*Step 1:Setting up the Virtual Machine *
Go to https://azure.microsoft.com/en-us/.
Create a student account by logging in with your stonybrook email.
Open your azure portal and click on virtual machines
Click create virtual machine and set up your machines settings. For this instance we chose the standard B1s size
Review and create your machine
Once machine is deployed click on your machines name and go onto the sidebar to "networking" under setttings. Click on "add inbound port rule" and add the MySQL port of 3306
Step 2: Access remote machine using your computers terminal
Search "terminal" on your computers spotlight search and open it
Type ssh the username you created for your instance@ ip address for your instance which can be found on your azure portal
You will then be prompted to enter your password you made for your instance in step 1
Once in the virtual machine type "sudo apt-get update"
Next type "sudo apt install mysql-server mysql-client", this will install MySql onto your virtual machine
Once the installation is complete type "sudo mysql" this will enter you into mysql
Type "show databases;"
You will then have to create a user, type "CREATE USER ‘DBA'@'%' IDENTIFIED BY ‘AHI2021’;
To make sure your user has been created you can type, "select user from mysql.user;"
Next you will need to grant this user privileges, type "GRANT ALL PRIVILEGES ON . TO 'USERNAME'@'%' WITH GRANT OPTION;"
To confirm type, "show grants for DBA;"
To exit MySQL click control + D
Step 3: Create a new database called ‘e2e’
First you need to log back into MySQL on your terminal, this can be done by typing "mysql -u DBA -p" and entering your password when prompted
Next type Create database e2e;
To confirm your database was created, type "show databases;"
Step 4: Write a python or R script that connects to your SQL instance
In the script create a new table called ‘h1n1’, that lives within the ‘e2e’ database - with the following data: https://www.kaggle.com/arashnic/flu-data
Type the following code, import pandas as pd import sqlalchemy from sqlalchemy import create_engine ! pip install pymysql import pymysql as db !pip install cryptography !pip install django-cryptographic-fields !pip install PyMySQL[rsa]
MYSQL_HOSTNAME = 'IP address of your instance' MYSQL_USER = 'username' MYSQL_PASSWORD = 'passsword' MYSQL_DATABASE = 'database name'

connection_string= f'mysql+pymysql://{MYSQL_USER}:{MYSQL_PASSWORD}@{MYSQL_HOSTNAME}/{MYSQL_DATABASE}' engine = create_engine(connection_string)

from google.colab import files uploaded = files.upload() ( you will then be prompted to upload your csv file your downloaded) import io import pandas as pd h1n1df= pd.read_csv(io.BytesIO(uploaded['H1N1_Flu_Vaccines.csv'])) h1n1df.to_sql('H1N1_Flu_Vaccines.csv', con=engine, if_exists ='append')

We will then need to go back into the terminal and update MySQL configuration file.
In the terminal then enter the code "sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf"
Scroll down with arrow keys until you see "bind-address" change those numbers to 0.0.0.0
Then do Control + O to save and Control + X to exit
Next type the following code "/etc/init.d/mysql restart"
Once this process has finished go back to you phyton file and rerun
To check log into MySQL in your terminal and type "show databases;", "use e2e;" , and finally "show tables;", you can also log into MySQL workbench to check.
Step 5: Create a dump (.sql) file that contains a physical backup of the file
Create a second instance using the same steps on microsoft azure to make a second virtual machine with all the same settings
Go to your terminal with your first VM still running and type the code "sudo mysqldump e2e > backup_e2e.sql" then type "ls"
To look at the dump file type the code "nano backup_e2e.sql"
Launch your second VM in the terminal to make sure it is working
Switch back to your first VM in the terminal and type the code, "scp dump.sql USERNAME@IP of second VM:/home/USERNAME"
You will be prompted to enter the password of your second VM
Enter the code "ls" to save
Step 6: Create a trigger
Create a trigger which follows these rules, that pushes an error message to the user when a new row is inserted that has h1n1_concern greater than a value of 3. The trigger should be called h1n1_concern_trigger and should have the following error message: “H1N1 concern should be a numerical value between 0 and 3. Please try again.”
A file will be on this repo with the command for the trigger
