import mysql.connector

#region dotenv
#This block is for using .env to store your database connection info.
from dotenv import load_dotenv
import os
load_dotenv()
#endregion

class DataBase():
    def __init__(self):
        self.mysqlConnector = mysql.connector.connect(
            host = #TODO add info for your connection,
            port = #TODO and remember to add a comma,
            user = #TODO like this,
            password = os.getenv("DB_PASSWORD"), #TODO adjust if needed
            database = "Utstyrutleie"
        )


    def __enter__(self):
        try:
            self.cursor = self.mysqlConnector.cursor()
            return self
        except mysql.connector.Error as error:
            print("Error while connecting to MySQL", error)

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.mysqlConnector.commit()
        self.cursor.close()
        self.mysqlConnector.close()

#region Equipment stats 

    def fetch_all_equipment(self):       
        try:
            self.cursor.execute("SELECT * FROM utstyrsoversikt")
            return self.cursor.fetchall()
        except Exception as e:
            raise Exception(f"Error fetching equipment: {str(e)}") from e


    def fetch_available_equipment(self, eq_id = None, category = None):
        query = "SELECT * FROM utstyrsoversikt WHERE status = 'Tilgjengelig'"
        params = []
        if eq_id:
            query += " AND utstyr_id = %s"
            params.append(eq_id)
        if category:
            query += " AND kategori = %s"
            params.append(category)

        self.cursor.execute(query, params)
        return self.cursor.fetchall()
    
    def fetch_count_available(self, eq_id = None):
        query = "SELECT COUNT(*) FROM utstyrsoversikt WHERE status COLLATE utf8mb4_unicode_ci = 'Tilgjengelig'"
        params = []
        if eq_id:
            query += "AND utstyr_id = %s"
            params.append(eq_id)

        self.cursor.execute(query, params)
        return self.cursor.fetchone()

    def fetch_equipment_type(self, eq_id):
        self.cursor.execute(f"SELECT * from mal_utstyr WHERE utstyr_id COLLATE utf8mb4_unicode_ci = {eq_id}")
        return self.cursor.fetchone()

#endregion

#region Rental events

    def rent_out_equipment(self, eq_id, inst_id, customer, today, payment, delivery, delivery_cost, user_id):
        self.cursor.execute("""INSERT INTO utleie
        (utstyr_id, instans_id, kunde_nr, utleid_dato, innlevert_dato, betalingsmåte, leveres, leveringskostnad, behandler_id)
        VALUES  (%s, %s, %s, %s, NULL, %s, %s, %s, %s)""", (eq_id, inst_id, customer, today, payment, delivery, delivery_cost, user_id)) 

        return self.cursor.rowcount

    def return_equipment(self, ids, timestamp):
        placeholder = '%s'
        placeholders = ",".join([placeholder] * len(ids))
        id_list = [int(x) for x in ids]
        values = (timestamp, ) + tuple(id_list)
        query = f"UPDATE utleie SET innlevert_dato = {placeholder} WHERE rental_id IN ({placeholders})"
        self.cursor.execute(query, tuple(values))
        return self.cursor.rowcount

#endregion

#region Rental stats #TODO
    def fetch_ongoing_rentals(self, user = None): #rentals without return date, filter by user or fetch all

        query = "SELECT * FROM utleieoversikt WHERE Innlevert IS Null"
        parameters = []

        if user:
            query += " AND behandler_id = %s"
            parameters.append(user)

        self.cursor.execute(query, parameters)
        return self.cursor.fetchall()
    

    def fetch_rentals_by_id(self, ids):
        placeholders = ','.join(['%s'] * len(ids))
        ids_tuple = tuple(int(x) for x in ids)
        self.cursor.execute(f"SELECT * FROM utleieoversikt WHERE utleie_id IN ({placeholders})", ids_tuple)
        return self.cursor.fetchall()
    
    
    def fetch_recent_rentals(self, amount, user = None): #fetch n latest rentals, optional filter by employee
        pass

    def fetch_all_finished_rentals(self): #kan hende det er nyttig?
        self.cursor.execute("SELECT * FROM utleieoversikt WHERE Innlevert IS NOT Null")
        return self.cursor.fetchall()

#endregion



#region Customer management
    def fetch_all_customers(self): 
        self.cursor.execute("SELECT * FROM kundeoversikt")
        return self.cursor.fetchall()
    

    def new_customer(self, name, type, email):
        self.cursor.execute("INSERT INTO kunde (navn, type, epost, levering_adr, faktura_adr) VALUES (%s, %s, %s, NULL, NULL)", (name, type, email))
        return self.cursor.lastrowid
    
    def new_address(self, street, house, code, postbox = None):
        self.cursor.execute("INSERT INTO adresseliste (gate, husnr, postnr, postboks) VALUES (%s, %s, %s, %s)", (street, house, code, postbox))
        return self.cursor.lastrowid
    
    def fetch_postcodes(self):
        self.cursor.execute("SELECT postnr from poststed")
        return self.cursor.fetchall()
    
    def new_postcode(self, code, city):
        self.cursor.execute("INSERT IGNORE INTO poststed (postnr, poststed) VALUES (%s, %s)", (code, city))

    def new_phonenr(self, number, customer):
        self.cursor.execute("INSERT INTO telefonliste (tel_nr, kunde_kunde_nr) VALUES (%s, %s)",(number, customer))

    def fetch_phones(self):
        self.cursor.execute("SELECT * FROM telefonliste")
        return self.cursor.fetchall()

    def link_customer_address(self, customer, shipping = None, billing = None):
        query = "UPDATE kunde SET "
        params = []
        if shipping and not billing:
            query += "levering_adr = %s "
            params.append(shipping)

        elif shipping and billing:
            query += "levering_adr = %s, faktura_adr = %s "
            params.append(shipping, billing)

        elif billing and not shipping:
            query +="faktura_adr = %s "
            params.append(billing)

        else: #funksjonen kalt uten adresse skal ikke gjøre noe
            return
        
        query += "WHERE kunde_nr = %s"
        params.append(customer)
        self.cursor.execute(query, params)

    def edit_customer(self, id, name = None, type = None, email = None): 
        query = "UPDATE kunde SET "
        params = []
        if name: 
            query += "navn = %s,"
            params.append(name)
        if type:
            query += "type = %s,"
            params.append(type)
        if email:
            query += "email = %s,"
            params.append(email)

        query = query[-1] #fjerner siste komma
        query += " WHERE kunde_nr = %s"
        params.append(id)

        self.cursor.execute(query, params)


    def delete_customer(self, customer): #lowest lowest pri
        pass
#endregion

#region User management
    def load_user_by_id(self, user_id):
        self.cursor.execute("SELECT * FROM brukerliste WHERE user_id = %s", (user_id, ))
        return self.cursor.fetchone()

    def load_user_by_username(self,username):
        self.cursor.execute("SELECT * FROM brukerliste where username = %s", (username, ))
        return self.cursor.fetchone()

    def create_user(self, firstname, surname, password, phone=None, role = "user"):
        username_base = (firstname[:3] + surname[:3]).lower()
        self.cursor.execute(
            "INSERT INTO brukerliste (fornavn, etternavn, telefonnummer, password_hash, role, username) VALUES (%s, %s, %s, %s, %s, NULL)",
            (firstname, surname, phone, password, role)
            )
        user_id = self.cursor.lastrowid
        username = f"{username_base}{user_id}"
        self.cursor.execute(
            "UPDATE brukerliste SET username = %s WHERE user_id = %s",
            (username, user_id)
        )
        return username
    
#endregion
