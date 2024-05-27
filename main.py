from fastapi import FastAPI, HTTPException, Query
from fastapi.middleware.cors import CORSMiddleware
import librosa
import numpy as np
import uvicorn
import tempfile
import joblib
import requests

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

model = joblib.load('model/accent_detection_model.pkl')

def extract_features(file):
    audio, sample_rate = librosa.load(file, res_type='kaiser_fast')
    mfccs = librosa.feature.mfcc(y=audio, sr=sample_rate, n_mfcc=40)
    mfccs_scaled = np.mean(mfccs.T, axis=0)
    return mfccs_scaled

@app.get("/predict-accent/")
async def predict_accent(url: str = Query(..., description="URL of the audio file")):
    # Download the audio file from the URL
    try:
        response = requests.get(url)
        response.raise_for_status()
    except requests.exceptions.RequestException as e:
        raise HTTPException(status_code=400, detail=f"Error downloading the file: {e}")

    # Save the downloaded file temporarily
    with tempfile.NamedTemporaryFile(suffix=".wav", delete=False) as temp_audio:
        temp_audio.write(response.content)
        temp_audio_path = temp_audio.name
        print(f"Downloaded file saved as {temp_audio_path}")

    # Extract features from the .wav file
    features = extract_features(temp_audio_path)

    # Predict
    prediction = model.predict([features])
    accent = "UK" if prediction[0] == 0 else "US"

    # Clean up temporary audio file
    temp_audio.close()

    return {"accent": accent}

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
