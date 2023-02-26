from typing import Union
from fastapi import Request, FastAPI
from pprint import pprint
import uvicorn

app = FastAPI()


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.post("/api/input")
async def preferences(req: Request):
    return { "status": True, "response": "Hi, I'm FastAPI" }

# uvicorn main:app --reload --host 0.0.0.0 --port 5000