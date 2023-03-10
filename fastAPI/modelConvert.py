import joblib
import tensorflow as tf

# Load the scikit-learn model
pickle_in = open('classifier.joblib', "rb")
sklearn_model = pickle.load(pickle_in)

# Create a new TensorFlow model
tf_model = tf.keras.Sequential([
    tf.keras.layers.Input(shape=(sklearn_model.coef_.shape[0],)),
    tf.keras.layers.Dense(1, use_bias=False)
])

# Set the weights of the TensorFlow model to match the scikit-learn model
tf_model.layers[0].set_weights([sklearn_model.coef_.T])

# Save the TensorFlow model to a file
tf_model.save('tf_model')
