from flask import Flask, render_template, redirect, url_for, request, flash
from flask_wtf import CSRFProtect
from flask_login import LoginManager, login_user, logout_user, login_required, current_user
from werkzeug.security import generate_password_hash, check_password_hash
import secrets
from datetime import datetime, date

from database import DataBase
from classes import User, OngoingRental, FinishedRental, EquipmentInstance, EquipmentType, Customer
from forms import NyBrukerForm, LoginForm, ReturnForm, RentalForm, NyKundeForm, EndreKundeForm

app = Flask(__name__)
app.secret_key = secrets.token_urlsafe(16)


csrf = CSRFProtect(app)

login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = "login"

#region User Management
@login_manager.user_loader
def load_user(user_id):
    with DataBase() as db:
        user = db.load_user_by_id(user_id)
    if user:
        return User(user[0], user[1], user[2], user[3], user[5])
    return None

@app.route("/login", methods = ['GET', 'POST'])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        with DataBase() as db:
            user = db.load_user_by_username(form.username.data)
            if user and check_password_hash(user[4], form.password.data):
                login_user(User(user[0], user[1], user[2], user[3], user[5]))
                return redirect(url_for("dashboard"))
        return render_template("login.html", form = form, error = "Feil brukernavn eller passord")
    return render_template("login.html", form = form)

@app.route("/nybruker", methods = ["GET", "POST"])
@login_required
def nybruker(): #Registrerer nytt ansatt
    form = NyBrukerForm()
    if form.validate_on_submit():
        with DataBase() as db:
            try:
                username = db.create_user(
                    form.firstname.data,
                    form.lastname.data,
                    generate_password_hash(form.password.data),
                    form.phonenr.data,
                    "admin" if form.adminrights.data else "user"
                )

                flash(f"Assigned username: {username} . Please write it down!", "warning")
            except Exception as e:
                flash(f"Feil ved registrering: {e}")
        return redirect(url_for("nybruker", form=form))
    return render_template("nybruker.html", form=form)

@app.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect(url_for("login"))
#endregion

#region Rental Management

@app.route("/ny-utleie", methods = ["GET", "POST"])
@login_required
def rent_out_equipment():
    form = RentalForm()
    with DataBase() as db:
        customers = [Customer(*arg) for arg in db.fetch_all_customers()]
        equipment = [EquipmentInstance(*arg) for arg in db.fetch_available_equipment()]
        form.customer.choices = [(c.cust_id, f"{c.cust_name}") for c in customers]
        form.equipment.choices = [
            (f"{e.eq_id}:{e.inst_id}", f"{e.type} - {e.brand} {e.model}, ({e.dayprice} kr/døgn)") 
            for e in equipment
            ]

        if form.validate_on_submit():
            customer = form.customer.data
            raw_equipment = form.equipment.data

            if not raw_equipment:
                flash("Ingen utstyr valgt", "warning")
                return render_template("reg_utlev.html", form=form, customers=customers, equipment=equipment)
            
            selected_eqs = []
            for id_str in raw_equipment:
                parts = id_str.split(':')
                selected_eqs.append((int(parts[0]), int(parts[1])))

            try:
                for eq_id, inst_id in selected_eqs:
                    db.rent_out_equipment(
                        eq_id,
                        inst_id,
                        customer, 
                        datetime.today(),
                        form.payment.data,
                        1 if form.delivery.data else 0,
                        int(form.delivery_cost.data),
                        current_user.id
                        )
                flash(f"{len(selected_eqs)} enhet(er) er leid ut!", "success")
                return redirect(url_for("rent_out_equipment"))

            except Exception as e:
                flash(f"En feil oppstod: {str(e)}", "danger")

                return render_template("reg_utlev.html", customers=customers, equipment=equipment, form=form)

        return render_template("reg_utlev.html", customers=customers, equipment=equipment, form=form)

    return render_template("reg_utlev.html", customers = customers, equipment = equipment, form = form)

@app.route("/returner", methods=["GET", "POST"])
@login_required
def return_equipment():
    form = ReturnForm()
    with DataBase() as db:
        if request.method == "POST":
            selected_ids = request.form.getlist("rental_ids")
            if not selected_ids:
                flash("Ingen utstyr valgt", "warning")
                return redirect(url_for("return_equipment"))
        
            timestamp = date.today()
            try:
                db.return_equipment(selected_ids, timestamp)
            except:
                flash(f"Feil i retur-registrering", "danger")
                return redirect(url_for("return_equipment"))
            
            return_rentals = [FinishedRental(*arg) for arg in db.fetch_rentals_by_id(selected_ids)]
            for rental in return_rentals:
                flash(f"Utleie {rental.get_id()} fra {rental.cust_name} returnert! TOTAL PRIS {rental.calculate_total_cost()}", "success")

        rentals = [OngoingRental(*arg) for arg in db.fetch_ongoing_rentals()]    
    return render_template("reg_innlev.html", rentals = rentals, form=form)

#endregion

#region Customer Management

@app.route("/kundeoversikt")
@login_required
def display_customers():
    customers = [] #To prevent unassignment errors that would stop the page from loading at all
    with DataBase() as db:
        try:
            customers = [Customer(*arg) for arg in db.fetch_all_customers()]
        except Exception as e:
            flash(f"En feil oppstod: {str(e)}", "danger")
            
    return render_template("customers.html", customers=customers)
    

@app.route("/nykunde", methods=['GET', 'POST']) #Veldig messy og uoptimalt. 
@login_required
def nykunde():
    form = NyKundeForm()
    if form.validate_on_submit():
        with DataBase() as db:
            try:
                new_customer_id = db.new_customer(
                    form.name.data,
                    form.type.data,
                    form.email.data)
                
                address_d = [form.delivery_street.data, form.delivery_house.data, form.delivery_code.data, form.delivery_city.data]
                address_b = [form.billing_street.data, form.billing_house.data, form.billing_code.data, form.billing_city.data]
                
            except Exception as e:
                flash(f"Feil ved kunderegistrering: {e}")

            try:
                db.new_phonenr(form.phone.data, new_customer_id)
            except Exception as e:
                flash(f"Feil ved telefonnummer-registrering: {e}")

            try:
                db.new_postcode(form.billing_code.data, form.billing_city.data)
                #Queryen er bygget opp slik at ingenting skjer hvis koden allerede finnes
            except Exception as e:
                flash(f"Feil ved postnummer-registrering: {e}")

            try:
                deliv_id = db.new_address(
                    form.delivery_street.data,
                    form.delivery_house.data,
                    form.delivery_code.data
                    )
                if address_d != address_b and any(address_b):
                    bill_id = db.new_address(
                    form.billing_street.data,
                    form.billing_house.data,
                    form.billing_code.data,
                    )
                else:
                    bill_id = deliv_id
            except Exception as e:
                flash(f"Feil ved adresseregistrering: {e}")

            try:    
                db.link_customer_address(new_customer_id, deliv_id, bill_id)
            except Exception as e:
                flash(f"Feil ved adresse-kunde kobling: {e}")

            return render_template("nykunde.html", form=form)
        return 
    return render_template("nykunde.html", form=form)

@app.route("/kunde-endring", methods=['GET', 'POST'])
@login_required
def change_customer():
    form = EndreKundeForm()
    with DataBase() as db:
        customers = [Customer(*arg) for arg in db.fetch_all_customers()]
        form.customer.choices = [(c.cust_id, f"{c.cust_name}") for c in customers]

        if form.validate_on_submit():
            customer = next((c for c in customers if c.cust_id == form.customer.data), None)

            #siden dette potensielt endrer på verdier i 3 forskjellige tabeller, 
            #var det smartere å kode hvert felt enn å iterere. Jeg prøvde.
            update_customer_table = False
            new_customer_data = {}

            if form.name.data and customer.cust_name != form.name.data:
                update_customer_table = True
                new_customer_data["name"] = form.name.data
            if customer.cust_type != form.type.data: #her får man data uansett
                update_customer_table = True
                new_customer_data["type"] = form.type.data
            if form.email.data and customer.email != form.email.data:
                update_customer_table = True
                new_customer_data["email"] = form.email.data

            if update_customer_table:
                db.edit_customer(customer.cust_id, new_customer_data.get("name"), new_customer_data.get("type"), new_customer_data.get("email"))

            if form.phone.data:
                existing_phones = [phone for phone in db.fetch_phones()]
                if form.phone.data in customer.phones: #kunden har allerede dette telefonnummeret
                    pass 
                elif form.phone.data in existing_phones: #telefonnummeret finnes allerede, men koblet mot en annen kunde
                    flash("""Telefonnummeret er allerede koblet opp mot en annen kunde. 
                          Her hadde jeg gjerne bedt deg dobbeltsjekke og spurt om lov til å koble nummer til denne kunden,
                          men jeg har ikke tid til å implementere dette nå.""", "warning")
                else: #nytt nummer
                    db.new_phonenr(form.phone.data, customer.cust_id)
            


            if (form.street.data and form.house.data and form.code.data and form.city.data): #velger å ikke implementere sjekk om adresse finnes eller ikke.
                db.new_postcode(form.code.data, form.city.data)
                adr_id = db.new_address(form.street.data, form.house.data, form.code.data)
                if form.adr_type.data == "Begge":
                    shipping = adr_id
                    billing = adr_id
                elif form.adr_type.data == "Levering":
                    shipping = adr_id
                    billing = None
                elif form.adr_type.data == "Faktura":
                    billing = adr_id
                    shipping = None

                db.link_customer_address(customer.cust_id, shipping, billing)


            elif (form.street.data or form.house.data or form.code.data or form.city.data):
                flash("Adressen må endres som en helhet", "warning")
            else: #ingen adresseendringer
                pass

            








    return render_template("edit_customer.html", customers = customers, form=form)



@app.route("/del-customer") #nedprioritert
@login_required
def delete_customer():
    pass

#endregion

#region Equipment Management
@app.route("/utstyrsoversikt")
@login_required
def display_equipment():
    equipment = []
    with DataBase() as db:
        try:
            equipment = [EquipmentInstance(*arg) for arg in db.fetch_all_equipment()]
        except Exception as e:
            flash(f"En feil oppstod: {str(e)}", "danger")
    return render_template("equipment.html", equipment=equipment)


@app.route("/item/<int:eq_id>")
def display_item(eq_id):
    with DataBase() as db:
        eq_data = db.fetch_equipment_type(eq_id)
        available = 0
        if eq_data:
            available = int(db.fetch_count_available(eq_id)[0])
            eq_info = EquipmentType(*db.fetch_equipment_type(eq_id))
        else:
            return "Equipment not found", 404
    return render_template("item.html", eq_info=eq_info, available = available)

#endregion


#region Statistics etc
@app.route("/")
def dashboard():
    if current_user.is_authenticated:
        return render_template("dashboard.html", user = current_user)
    else:
        return redirect(url_for("login"))


#endregion




def main():
    app.run(debug=True)

if __name__ == "__main__":
    main()