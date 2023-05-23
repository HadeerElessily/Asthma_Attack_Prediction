from flask import Flask, jsonify, request, render_template
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS
import pandas as pd
import joblib

app = Flask(__name__)
CORS(app)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///asthma_data.db'  # Update the database URI if needed
db = SQLAlchemy(app)

model = joblib.load('RFclf.joblib')


class AsthmaData(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    cough = db.Column(db.String(50))
    phlegm = db.Column(db.String(50))
    wheeze = db.Column(db.String(50))
    Dysp = db.Column(db.String(50))
    Exe = db.Column(db.String(50))
    AR = db.Column(db.String(50))
    par2 = db.Column(db.String(50))
    RIr = db.Column(db.String(50))
    REm = db.Column(db.String(50))
    Ecz = db.Column(db.String(50))
    Food = db.Column(db.String(50))
    Cold = db.Column(db.String(50))
    AP = db.Column(db.String(50))
    Psmoke = db.Column(db.String(50))
    Animal = db.Column(db.String(50))
    Damp = db.Column(db.String(50))
    asthma = db.Column(db.String(50))


@app.route('/', methods=['POST'])
def predict():
    try:
        data = request.json
        features = ['cough', 'phlegm', 'wheeze', 'Dysp', 'Exe', 'AR', 'par2', 'RIr', 'REm', 'Ecz', 'Food', 'Cold', 'AP',
                    'Psmoke', 'Animal', 'Damp']

        # Extract the feature values from the request data
        feature_values = [data[feature] for feature in features]

        # Create a pandas DataFrame using the feature values
        df = pd.DataFrame([feature_values], columns=features)

        # Make the prediction using the loaded model
        prediction = model.predict(df)

        if prediction[0] == 0:
            result = 'You do not have asthma attack risk.'
        else:
            result = 'You may have asthma attack risk. Please consult a doctor.'

        print('Prediction:', prediction[0])  # Print the prediction

        # Create a new AsthmaData object
        asthma_data = AsthmaData(
            cough=data['cough'],
            phlegm=data['phlegm'],
            wheeze=data['wheeze'],
            Dysp=data['Dysp'],
            Exe=data['Exe'],
            AR=data['AR'],
            par2=data['par2'],
            RIr=data['RIr'],
            REm=data['REm'],
            Ecz=data['Ecz'],
            Food=data['Food'],
            Cold=data['Cold'],
            AP=data['AP'],
            Psmoke=data['Psmoke'],
            Animal=data['Animal'],
            Damp=data['Damp'],
            asthma=result  
        )

        with app.app_context():
            # Add the AsthmaData object to the database session
            db.session.add(asthma_data)

            # Commit the changes to the database
            db.session.commit()

        return jsonify({'result': result}), 200, {'Content-Type': 'application/json'}

    except Exception as e:
        # Log the error message
        print('Error:', str(e))

        # Return the error message as a JSON response
        return jsonify({'error': str(e)}), 400, {'Content-Type': 'application/json'}


@app.route('/dashboard')
def dashboard():
    with app.app_context():
        # Retrieve all data from the database
        asthma_data = AsthmaData.query.all()
    
    # Render the dashboard template with the data
    return render_template('dashboard.html', asthma_data=asthma_data)


if __name__ == '__main__':
    app.run(debug=True)
