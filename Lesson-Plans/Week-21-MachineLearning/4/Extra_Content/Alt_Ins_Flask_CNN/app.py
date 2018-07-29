# Example from http://flask.pocoo.org/docs/0.12/patterns/fileuploads/
import os
from flask import Flask, request, redirect, url_for, jsonify
from flask import send_from_directory
from werkzeug.utils import secure_filename

UPLOAD_FOLDER = 'uploads'
ALLOWED_EXTENSIONS = set(['png', 'jpg', 'jpeg', 'gif'])

app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER


import numpy as np
import tensorflow as tf

import keras
from keras.preprocessing import image
from keras.applications.xception import (
    Xception, preprocess_input, decode_predictions)
# from tensorflow.contrib.keras.python.keras.backend import clear_session
from keras import backend as K

model = Xception(
    include_top=True,
    weights='imagenet')
graph = K.get_session().graph

image_size = (299, 299)


def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route('/', methods=['GET', 'POST'])
def upload_file():
    data = {"success": False}
    if request.method == 'POST':
        # check if the post request has the file part
        if 'file' not in request.files:
            return redirect(request.url)
        file = request.files['file']
        # if user does not select file, browser also
        # submit a empty part without filename
        if file.filename == '':
            return redirect(request.url)
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            filepath = os.path.join(app.config['UPLOAD_FOLDER'])
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            # Preprocess image for model prediction
            # This step handles scaling and normalization for Xception
            global graph
            with graph.as_default():
                img = image.load_img(os.path.join(app.config['UPLOAD_FOLDER'], file.filename), target_size=image_size)
                x = image.img_to_array(img)
                x = np.expand_dims(x, axis=0)
                x = preprocess_input(x)
                predictions = model.predict(x)
                results = decode_predictions(predictions, top=3)
                # print(results)
                data["predictions"] = []

                # loop over the results and add them to the list of
                # returned predictions
                for (xceptionID, label, prob) in results[0]:
                    r = {"label": label, "probability": float(prob)}
                    data["predictions"].append(r)

                # indicate that the request was a success
                data["success"] = True
            return jsonify(data)
            # return redirect(url_for('uploaded_file',
                                    # filename=filename))
    return '''
    <!doctype html>
    <title>Upload new File</title>
    <h1>Upload new File</h1>
    <form method=post enctype=multipart/form-data>
      <p><input type=file name=file>
         <input type=submit value=Upload>
    </form>
    '''
@app.route('/uploads/<filename>')
def uploaded_file(filename):
    return send_from_directory(app.config['UPLOAD_FOLDER'],
                               filename)

if __name__ == "__main__":
    app.run(debug=True)
