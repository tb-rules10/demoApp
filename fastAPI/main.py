import uvicorn
from fastapi import Request, FastAPI, Depends
from EmotionDetector import EmotionDetector
from EmotionDetector import EmotionGenre
import pickle
import json
# from pprint import pprint
# from typing import Union

app = FastAPI()
pickle_in = open('classifier.pkl', "rb")
classifier = pickle.load(pickle_in)

@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.post("/api/input")
async def preferences(req: Request):
    data:EmotionGenre = json.loads(await req.body())
    # print(data)
    return { "status": True, "msg": "Hi, I'm FastAPI" }


@app.post("/api/predict")
async def predict_Emotion(req: Request):
    data:EmotionGenre = json.loads(await req.body())
    input =  data['text']
    res = classifier.predict([input])[0]
    return { "status": True, "msg": f'{input}   ->   {res}' }



# uvicorn main:app --reload --host 0.0.0.0 --port 5000