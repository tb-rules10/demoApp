import uvicorn
from fastapi import Request, FastAPI
from EmotionDetector import EmotionDetector
from EmotionDetector import EmotionGenre
import pickle
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
    return { "status": True, "msg": "Hi, I'm FastAPI" }


# @app.post("/api/predict")
# async def predict_Emotion(req: Request):
#     data = await req.json()
#     print(data)
#     res = classifier.predict([data['text']])[0]
#     print(res)
#     # return { "status": True, "msg": {res} }
#     return { "status": True, "msg": "Hi, I'm FastAPI" }


@app.post("/api/predict")
async def predict_Emotion(data: EmotionDetector):
    data = data.dict()
    # print(data)
    res = classifier.predict([data['text']])[0]
    # print(res)
    return { "status": True, "msg": f'{res}' }


# uvicorn main:app --reload --host 0.0.0.0 --port 5000