from flask_login import UserMixin
from datetime import date

#Her er det ekstra synlig at jeg har ikke gjennomtenkt og planlagt variabelnavn og slikt helt fra starten.
#Det hadde vært mye bedre hvis jeg hadde de samme kolonne/variabelnavn gjennom det hele. 

class User(UserMixin):
    def __init__(self, user_id, fornavn, etternavn, telefonnummer, role):
        self.id = user_id
        self.fornavn = fornavn
        self.etternavn = etternavn
        self.telefonnummer = telefonnummer
        self.role = role
    
    def get_id(self):
        return str(self.id)

class OngoingRental:
    def __init__(self, *args):
        self.id = args[0]
        self.user_id = args[2]
        self.cust_name = args[3]
        self.eq_id = args[4]
        self.inst_id = args[5]
        self.brand = args[6]
        self.model = args[7]
        self.type = args[8]
        self.cat = args[9]
        self.dateout = args[10]

    def get_id(self):
        return str(self.id)

class FinishedRental:
    def __init__(self, *args):
        self.id = args[0]
        self.user_id = args[2]
        self.cust_name = args[3]
        self.eq_id = args[4]
        self.inst_id = args[5]
        self.brand = args[6]
        self.model = args[7]
        self.type = args[8]
        self.cat = args[9]
        self.dateout = args[10]
        self.datein = args[11]
        self.dayprice = args[13]
        self.delivery_cost = args[14]


    def calculate_total_cost(self):
        days = (self.datein - self.dateout).days
        return days * self.dayprice + self.delivery_cost
    
    def get_id(self):
        return str(self.id)


class EquipmentInstance:
    def __init__(self, *args): #hadde sykt lyst til å kjøre kwargs og en loop her men ville ha like variabelnavn for samme ting i alle klasser
        self.eq_id = args[1]
        self.inst_id = args[0]
        self.type = args[2]
        self.brand = args[3]
        self.model = args[4]
        self.category = args[5]
        self.status = args[6]
        self.prev_maint = args[7]
        self.next_maint = args[8]
        self.amount_of_orders = args[9]
        self.total_days_out = args[10]
        self.dayprice = args[11]
        self.description = args[12]
        self.days_until_maint = (self.next_maint - date.today()).days

    def calculate_total_profit(self):
        return self.total_days_out * self.dayprice
    
    def calculate_avg_rental_length(self):
        return self.total_days_out / self.amount_of_orders
    
    def get_available_bool(self):
        return True if self.status == "Tilgjengelig" else False

    def get_days_until_maint(self): #kan nok fjernes hvis init
        return (self.next_maint - date.today()).days



class EquipmentType:
    def __init__(self, *args):
        self.eq_id = args[0]
        self.type = args[1]
        self.brand = args[2]
        self.model = args[3]
        self.category = args[4]
        self.description = args[5]
        self.dayprice = args[6]



class Customer:
    def __init__(self, *args):
        self.cust_id = args[0]
        self.cust_name = args[1]
        self.cust_type = args[2]
        self.order_count = args[3]
        self.email = args[4]
        if args[5]:
            self.phones = [nr for nr in args[5].split(", ")]
        else:
            self.phones = ""
        self.billing_street = args[6]
        self.billing_house = args[7]
        self.billing_code = args[8]
        self.billing_city = args[9]
        self.delivery_street = args[10]
        self.delivery_house = args[11]
        self.delivery_code = args[12]
        self.delivery_city = args[13]



if __name__ == "__main__":

    pass