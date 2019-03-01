from application import app
from application.database import *
from flask import request, Response
from application.extensions import resultify
from werkzeug.security import check_password_hash
import os


@app.route('/adduser', methods=['POST'])
def add_user():
    data = request.get_json() or {}
    if 'telephone' not in data or 'password' not in data:
        return resultify(code=-1, message='注册失败！')
    telephone = data['telephone']
    if User.query.filter_by(telephone=telephone).first() is not None:
        return resultify(code=-1, message='号码已被注册');
    user = User(username=data['username'], password=data['password'],telephone=data['telephone'])
    db.session.add(user)
    db.session.commit()
    return resultify(user.to_dict(), code=200, message='注册成功')


@app.route('/update', methods=['POST'])
def update_user():
    data = request.get_json() or {}
    uid = data['uid']
    username = data['username']
    password = data['password']
    gender = data['gender']
    age = data['age']
    telephone = data['telephone']

    user = User.query.filter_by(uid=uid).first()
    if user is None:
        return resultify(result=None, code=-1, message='更新失败')
    user.username = username
    user.password = generate_password_hash(password)
    user.gender = gender
    user.age = age
    user.telephone = telephone
    db.session.commit()
    return resultify(user.to_dict(), code=200, message='修改成功')


@app.route('/login', methods=['POST'])
def login():
    data = request.get_json() or {}
    if 'telephone' not in data:
        return resultify(code=-1, message="登录失败!")
    telephone = data['telephone']
    password = data['password']
    user = User.query.filter_by(telephone=telephone).first()
    if check_password_hash(user.password, password):
        return resultify(user.to_dict(), code=200)
    return resultify(code=-1, message="登录失败!")


@app.route('/getrecord/<uid>', methods=['GET'])
def get_record(uid):
    records = AppBook.query.filter_by(uid=uid).all()
    results = [record.to_dict() for record in records]
    return resultify(results, code=200)


@app.route('/gethospitals', methods=['GET'])
def get_hospitals():
    hospitals = Hospital.query.all()
    hospitals = [hospital.to_dict() for hospital in hospitals]
    return resultify(hospitals, code=200)


@app.route('/getdoctors', methods=['POST'])
def get_doctors():
    data = request.get_json() or {}
    office = data['office']
    in_hospital = data['in_hospital']
    doctors = Doctor.query.filter_by(office=office, in_hospital=in_hospital).all()
    doctors = [doctor.to_dict() for doctor in doctors]
    return resultify(doctors, code=200)


@app.route('/getimage/<imagename>', methods=['GET'])
def get_image(imagename):
    parent = os.path.dirname(__file__)
    path = os.path.normpath(os.path.join(parent, '../images/' + imagename))
    with open(path, 'rb') as f:
        image = f.read()
    return Response(image, mimetype="image/jpeg")


@app.route('/addrecord', methods=['POST'])
def add_record():
    data = request.get_json() or {}
    uid = data['uid']
    money = data['money']
    user = User.query.filter_by(uid=uid).first()
    if user.money < money:
        return resultify(-1, '余额不足')
    user.money = user.money - money
    person_name = data['person_name']
    time = data['time']
    doctor = data['doctor']
    hospital = data['hospital']
    telephone = data['telephone']
    person_id = data['person_id']
    person_des = data['person_des']
    record = AppBook(uid=uid, person_name=person_name,time=time, doctor=doctor, hospital=hospital, telephone=telephone, person_id=person_id,person_des=person_des)
    db.session.add(record)

    did = data['did']
    work_time = data['work_time']
    doctor = Doctor.query.filter_by(did=did).first()
    doctor.work_time = work_time
    db.session.commit()
    return resultify(user.to_dict(), code=200)


@app.route('/addmoney', methods=['POST'])
def add_money():
    data = request.get_json() or {}
    uid = data['uid']
    money = data['money']
    user = User.query.filter_by(uid=uid).first()
    user.money = user.money+money
    db.session.commit()
    return resultify(user.to_dict(),code=200)


if __name__ == '__main__':
    create_tables()

    app.run(debug=True)
    # app.run(host='0.0.0.0', debug=True)


