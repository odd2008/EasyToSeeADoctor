from application import db
from werkzeug.security import generate_password_hash


class User(db.Model):
    __tablename__ = 'user'
    uid = db.Column(db.Integer, primary_key=True, autoincrement=True)
    username = db.Column(db.String(64), server_default='')
    password = db.Column(db.String(225))
    gender = db.Column(db.Integer)  #0为女性，1位男性
    age = db.Column(db.Integer)
    telephone = db.Column(db.String(12), unique=True)
    money = db.Column(db.Integer)

    def to_dict(self):
        return {
            'uid': self.uid,
            'username': self.username,
            'gender': self.gender,
            'age': self.age,
            'telephone': self.telephone,
            'money': self.money
        }

    def __init__(self, username, password, telephone):
        self.username = username
        self.password = generate_password_hash(password)
        self.telephone = telephone
        self.money = 60


class AppBook(db.Model):
    __tablename__ = 'appbook'
    aid = db.Column(db.Integer, primary_key=True, autoincrement=True)
    uid = db.Column(db.Integer, db.ForeignKey(User.uid))
    person_name = db.Column(db.String(32), server_default='')
    time = db.Column(db.String(32), server_default='')
    doctor = db.Column(db.String(64), server_default='')
    hospital = db.Column(db.String(64), server_default='')
    telephone = db.Column(db.String(12), server_default='')
    person_id = db.Column(db.String(32), server_default='')
    person_des = db.Column(db.String(1000), server_default='')

    def to_dict(self):
        return {
            'aid': self.aid,
            'uid': self.uid,
            'time': self.time,
            'doctor': self.doctor,
            'hospital': self.hospital,
            'telephone': self.telephone,
            'person_name': self.person_name,
            'person_id': self.person_id,
            'person_des': self.person_des
        }

    def __init__(self, uid, person_name, time, doctor, hospital, telephone, person_id, person_des):
        self.uid = uid
        self.person_name = person_name
        self.time = time
        self.doctor = doctor
        self.hospital = hospital
        self.telephone = telephone
        self.person_id = person_id
        self.person_des = person_des


class Hospital(db.Model):
    __tablename__ = 'hospital'
    hid = db.Column(db.Integer, primary_key=True, autoincrement=True)
    h_name = db.Column(db.String(64), server_default='')
    production = db.Column(db.String(1000),server_default='')
    advantage = db.Column(db.String(1000),server_default='')
    honor = db.Column(db.String(1000), server_default='')
    image_name = db.Column(db.String(64), server_default='')
    grade = db.Column(db.String(64), server_default='')

    def to_dict(self):
        return {
            'hid': self.hid,
            'h_name': self.h_name,
            'production': self.production,
            'advantage': self.advantage,
            'honor': self.honor,
            'grade': self.grade,
            'image_name': self.image_name
        }


class Doctor(db.Model):
    __tablename__ = 'doctor'
    did = db.Column(db.Integer, primary_key=True, autoincrement=True)
    d_name = db.Column(db.String(64), server_default='')
    title = db.Column(db.String(64), server_default='')
    good_at = db.Column(db.String(1000), server_default='')
    in_hospital = db.Column(db.Integer, db.ForeignKey(Hospital.hid))
    office = db.Column(db.String(64), server_default='')
    work_time = db.Column(db.String(30), server_default='')
    fee = db.Column(db.Integer)
    image_name = db.Column(db.String(64), server_default='')
    introduction = db.Column(db.String(1000), server_default='')

    def to_dict(self):
        return {
            'did': self.did,
            'd_name': self.d_name,
            'title': self.title,
            'good_at': self.good_at,
            'in_hospital': self.in_hospital,
            'office': self.office,
            'work_time': self.work_time,
            'fee': self.fee,
            'image_name': self.image_name,
            'introduction': self.introduction
        }


def create_tables():
    # db.drop_all()
    db.create_all()











