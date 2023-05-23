from flask import Flask, jsonify, request, render_template
from flask_cors import CORS
import pandas as pd
import joblib

app = Flask(__name__)
CORS(app)


model = joblib.load('RFclf.joblib')


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


        return jsonify({'result': result}), 200, {'Content-Type': 'application/json'}

    except Exception as e:
        # Log the error message
        print('Error:', str(e))

        # Return the error message as a JSON response
        return jsonify({'error': str(e)}), 400, {'Content-Type': 'application/json'}


if __name__ == '__main__':
    app.run(debug=True)
