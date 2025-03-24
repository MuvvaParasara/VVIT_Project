# Project Run book

## Starting the project
- Login to EC2 instance as `ec2-user` user
- Goto `VVIT-2.6` folder
  ```
  $ cd VVIT-2.6
  ```
- Run the command to start the project
  ```
  $ streamlit run app.py
  ```
  Above command runs the project in the foreground.
  
  To start the project in background use below command
  ```
  $ nohup streamlit run app.py > streamlit.log 2>&1 &
  ```

## Stopping the project
- Login to EC2 instance as `ec2-user` user
- Find the process and kill it using below command
  ```
  kill -9 $(pgrep streamlit)
  ```

## Using Bash script to start and stop the project
- In the project folder use start.sh to start the project
  ```
  $ cd VVIT-2.6
  $ . start.sh
  ```
- In the project folder use stop.sh to stop the project
  ```
  $ cd VVIT-2.6
  $ . stop.sh
  ```
