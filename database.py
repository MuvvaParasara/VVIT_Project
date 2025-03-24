import pymysql
import bcrypt
import os

# RDS Database Configuration (Replace with your actual values)
DB_HOST = "terraform-20250324022411021000000002.c4dcm0aqkg6p.us-east-1.rds.amazonaws.com"
DB_USER = "admin"
DB_PASSWORD = "password123"
DB_NAME = "project_db"

# Function to connect to the RDS MySQL database
def get_db_connection():
    return pymysql.connect(
        host=DB_HOST,
        user=DB_USER,
        password=DB_PASSWORD,
        database=DB_NAME,
        cursorclass=pymysql.cursors.DictCursor
    )

# Function to hash passwords
def hash_password(password):
    return bcrypt.hashpw(password.encode(), bcrypt.gensalt()).decode()

# Function to verify passwords
def verify_password(stored_password, provided_password):
    return bcrypt.checkpw(provided_password.encode(), stored_password.encode())

# Create users table in MySQL RDS
def create_table():
    conn = get_db_connection()
    with conn.cursor() as cursor:
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS users (
                id INT AUTO_INCREMENT PRIMARY KEY,
                name VARCHAR(100) NOT NULL,
                email VARCHAR(255) UNIQUE NOT NULL,
                age INT NOT NULL,
                gender ENUM('Male', 'Female', 'Other') NOT NULL,
                otp INT,
                image LONGBLOB,
                password VARCHAR(255) NOT NULL  
            )
        """)
    conn.commit()
    conn.close()

# Function to add a user
def add_user(name, email, age, gender, otp, image, password):
    conn = get_db_connection()
    try:
        with conn.cursor() as cursor:
            hashed_password = hash_password(password)
            image_data = image.read() if image else None
            sql = "INSERT INTO users (name, email, age, gender, otp, image, password) VALUES (%s, %s, %s, %s, %s, %s, %s)"
            cursor.execute(sql, (name, email, age, gender, otp, image_data, hashed_password))
        conn.commit()
        return True
    except pymysql.IntegrityError:
        return False
    finally:
        conn.close()

# Function to authenticate a user
def authenticate_user(email, password):
    conn = get_db_connection()
    with conn.cursor() as cursor:
        cursor.execute("SELECT * FROM users WHERE email = %s", (email,))
        user = cursor.fetchone()
    conn.close()
    if user and verify_password(user["password"], password):
        return user
    return None

# Function to fetch user details
def fetch_user(email):
    conn = get_db_connection()
    with conn.cursor() as cursor:
        cursor.execute("SELECT * FROM users WHERE email = %s", (email,))
        user = cursor.fetchone()
    conn.close()
    user = list(user.values())
    return user

# Function to update OTP
def update_otp(email, otp):
    conn = get_db_connection()
    with conn.cursor() as cursor:
        cursor.execute("UPDATE users SET otp = %s WHERE email = %s", (otp, email))
    conn.commit()
    conn.close()

# Function to fetch OTP
def fetch_otp(email):
    conn = get_db_connection()
    with conn.cursor() as cursor:
        cursor.execute("SELECT otp FROM users WHERE email = %s", (email,))
        otp = cursor.fetchone()
    conn.close()
    return otp["otp"] if otp else None

# Create the table when script runs
create_table()

