from flask import jsonify


def resultify(result=None, code=0, message=''):
    if (result is None):
        obj = {
            "code": code,
            "message": message
        }
    else:
        obj = {
            "code": code,
            "message": "success",
            "result": result
        }
    return jsonify(obj)
