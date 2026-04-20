from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField, BooleanField, SelectField, SelectMultipleField, EmailField
from wtforms.validators import DataRequired, Length, EqualTo, Regexp


class NyBrukerForm(FlaskForm):
    firstname = StringField("Fornavn", validators=[DataRequired(), Length(min=2, max=50)])
    lastname =  StringField("Etternavn", validators=[DataRequired(), Length(min=2, max=50)])

    phonenr = StringField("Telefonnummer", validators=[Regexp(r'^\d{8}$', message = "Må være nøyaktig 8 tall - uten landkode")])
    
    password = PasswordField("Passord", validators=[
        DataRequired(), Length(min=8),
        Regexp(r'(?=.*\d)(?=.*[a-z])(?=.*[A-Z])', message="Må bestå av i minst 8 tegn og inneholde stor bokstav, liten bokstav og tall.")
        ])
    
    
    confirm_password = PasswordField("Bekreft passord", validators=[
        DataRequired(), EqualTo('password', message="Passord må være lik")
        ])
    
    adminrights = BooleanField("Gi administratormakt", default=False)

    submit = SubmitField("Registrer")

class LoginForm(FlaskForm):
    username = StringField("Brukernavn", validators=[DataRequired()])
    password = PasswordField("Passord", validators=[DataRequired()])
    submit = SubmitField("Logg inn")

class NyKundeForm(FlaskForm):
    name = StringField("Navn", validators=[DataRequired(), Length(min=2, max=150)])
    type = SelectField("Type", choices=["Privat", "Bedrift"])
    email = EmailField("E-post")

    phone = StringField("Telefonnummer", validators=[Regexp(r'^\d{8}$', message = "Må være nøyaktig 8 tall - uten landkode")])
    
    delivery_street = StringField("Gate", validators=[Length(min=2, max=50)])
    delivery_house = StringField("Husnr", validators=[Length(max=8)])
    delivery_code = StringField("Postnummer", validators=[Regexp(r'^\d{4}$')])
    delivery_city = StringField("Poststed")

    billing_street = StringField("Gate", validators=[Length(min=2, max=50)])
    billing_house = StringField("Husnr", validators=[Length(max=8)])
    billing_code = StringField("Postnummer", validators=[Regexp(r'^\d{4}$')])
    billing_city = StringField("Poststed")

    submit = SubmitField("Registrer")
    
class EndreKundeForm(FlaskForm):
    customer = SelectField("Kunde:", choices=[], coerce=int, validators=[DataRequired()])

    name = StringField("Nytt navn:", validators=[Length(max=150)], default="")
    type = SelectField("Endre på type:", choices=["Privat", "Bedrift"])
    email = EmailField("Ny E-post:")
    phone = StringField("Ny Telefonnummer", validators=[Regexp(r'^\d{8}$', message = "Må være nøyaktig 8 tall - uten landkode")], default="")
    
    street = StringField("Gate", validators=[Length(max=50)], default="")
    house = StringField("Husnr", validators=[Length(max=8)], default="")
    code = StringField("Postnummer", validators=[Regexp(r'^(\d{4})?$')], default="")
    city = StringField("Poststed")
    adr_type = SelectField("Adresse er til:", choices=["Levering", "Faktura", "Begge"])

    submit = SubmitField("Lagre endringer")



class ReturnForm(FlaskForm): #Trenger ikke noe fancy validation her
    pass

class RentalForm(FlaskForm):
    customer = SelectField("Kunde", choices=[], coerce=int, validators=[DataRequired()])
    equipment = SelectMultipleField("Utstyr", choices=[], validators=[DataRequired()])
    payment = SelectField("Betalingsmåte", choices=["Kontant", "Kort", "Vipps"], validators=[DataRequired()])
    delivery = BooleanField("Leveres", default=False)
    delivery_cost = StringField("Leveringskostnad (kroner)", validators=[Regexp(r'\d+')], default="0")
    submit = SubmitField("Registrer utleie")

    
