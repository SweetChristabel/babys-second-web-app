# DTE-2509
UiT Database &amp; Web Application course

An incomplete but somewhat usable web app for a fictional Norwegian equipment rental service with MySQL database connection, WTForms and Bootstrap. Some javascript is used on the rental handling pages to help make the UI neater and more intuitive. This project was possible to do in groups, but I chose to do it alone. 



To initialize:
* Host a MySQL database
* Create schema in your database - run Utstyrutleie2.sql
* Insert your connection details and credentials into database.py
* Create a virtual environment (optional but recommended)
* Install dependencies (pip install -requirements.txt)
* Run app.py
* Click on the pretty link in the console :D

 The equipment in and out functions work as intended, the customer registration seems to work as intended (but may need more thorough testing), and the customer editing does not work despite looking like it might, and lacks proper error handling. Implementing a proper dashboard also had to be sacrificed to time constraints. With the existing codebase it should be relatively simple.

During development, considerations have been taken to minimise redundant querying, nested loops and such to make the code nice and fat, but I definitely cannot guarantee that everything is implemented in the optimal way. In any future project, I would also establish a naming convention from the very start for consistency between the database, the code and the forms. Towards the end of the project those inconsistencies limited my choices in how to implement things considerably - that is best seen by taking a quick glance at the classes.py file. Tidying it up would have meant altering the entire database which I had fully built earlier in the same course; I decided to prioritise finishing the app. The same applies to error handling. 
