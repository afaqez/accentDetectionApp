from fastapi import FastAPI, File, UploadFile
import librosa
import numpy as np
import uvicorn
import tempfile

app = FastAPI()

# Load your pre-trained model (this is a placeholder, adjust accordingly)
# For example, using a saved scikit-learn model
import joblib
model = joblib.load('model/accent_detection_model.pkl')

def extract_features(file):
    audio, sample_rate = librosa.load(file, res_type='kaiser_fast')
    mfccs = librosa.feature.mfcc(y=audio, sr=sample_rate, n_mfcc=40)
    mfccs_scaled = np.mean(mfccs.T, axis=0)
    return mfccs_scaled

@app.post("/predict-accent/")
async def predict_accent(file: UploadFile = File(...)):
    # Read the uploaded file
    contents = await file.read()

    # Save the uploaded mp3 file temporarily
    with tempfile.NamedTemporaryFile(suffix=".mp3", delete=False) as temp_mp3:
        temp_mp3.write(contents)
        temp_mp3_path = temp_mp3.name

    # Extract features from the mp3 file
    features = extract_features(temp_mp3_path)

    # Predict
    prediction = model.predict([features])
    accent = "UK" if prediction[0] == 0 else "US"

    # Clean up temporary file
    temp_mp3.close()

    return {"accent": accent}

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
