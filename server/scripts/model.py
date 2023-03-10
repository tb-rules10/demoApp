import joblib
import sys
import json
import pickle
import os 

# Load the pipeline model from disk
# pickle_in = open('scripts/classifier.pkl', "rb")
# classifier = pickle.load(pickle_in)
classifier = joblib.load('scripts/classifier.joblib')

# Get the input data from the command line arguments
# print(sys.argv[1])
data = sys.argv[1]

# Make predictions using the pipeline model
predictions = classifier.predict([data])

# Return the predictions as a JSON string
print(predictions[0])
