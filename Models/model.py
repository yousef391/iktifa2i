from fastapi import FastAPI, File, UploadFile, Form
from fastapi.responses import JSONResponse
import requests
import json
import base64
from PIL import Image
import io

app = FastAPI()

# API Keys
LLM_API_URL = "https://api-inference.huggingface.co/models/HuggingFaceH4/zephyr-7b-alpha"
LLM_API_TOKEN =  "# Replace with your actual token"

PLANT_ID_API_URL = "https://plant.id/api/v3/health_assessment"
PLANT_ID_API_KEY =   "# Replace with your Plant.id API key"

llm_headers = {
    "Authorization": f"Bearer {LLM_API_TOKEN}",
    "Content-Type": "application/json"
}

plant_id_headers = {
    "Api-Key": PLANT_ID_API_KEY,
    "Content-Type": "application/json"
}


def get_plant_state_from_image(img_bytes):
    encoded_image = base64.b64encode(img_bytes).decode("utf-8")
    payload = json.dumps({
        "images": [encoded_image],
        "latitude": 49.207,
        "longitude": 16.608,
        "similar_images": True,
        "health": "auto"
    })

    response = requests.post(PLANT_ID_API_URL, headers=plant_id_headers, data=payload)

    if response.status_code == 201:
        try:
            data = response.json()
            is_plant = data["result"].get("is_plant", {}).get("binary", False)
            if not is_plant:
                return None  # 🚫 Not a plant image

            is_healthy_binary = data["result"].get("is_healthy", {}).get("binary", False)

            if is_healthy_binary:
                return "healthy"
            else:
                suggestions = data["result"].get("disease", {}).get("suggestions", [])
                if suggestions:
                    disease_name = suggestions[0].get("name", "unknown")
                    return disease_name.lower()
                else:
                    return "unknown"
        except (KeyError, IndexError, TypeError):
            return "unknown"
    else:
        return "unknown"

# Function to get structured plant tasks from the LLM
def get_structured_plant_tasks(plant_type, state):
    prompt = (
        f"Act like a plant and tree care assistant that has experinced with {plant_type}."
        f"The plant you are caring for is currently diagnosed with the following condition: '{state}'.\n\n"
        f"Based on this specific state condition and plant type, generate 4 to 5 practical care tasks in JSON format. "
        f"if it's {plant_type} is tree do what tree needs and if its plant do what plant does ). Each task should be a short command, starting with a verb. Include tasks for moving the plant based on its environmental needs (e.g., "
        f"move it to a sunny spot, or keep it in a shaded place, etc.).\n\n"
        
        f"Examples:\n"
        f"- If the state indicates a nutrient deficiency, suggest fertilizing or soil treatment.\n"
        f"- If it's a fungal infection, suggest pruning infected parts or applying fungicide.\n"
        f"- If it's healthy, focus on maintenance and environmental optimization.\n"
        
        f"Each task must include:\n"
        f"- 'task': a short command like 'Water the plant' or 'Move plant to sunny spot'\n"
        f"- 'amount': how much or how often (e.g., '200ml every 3 days', '5g once a month')\n"
        f"- 'icon': an emoji representing the task\n"
        f"- 'effect': a benefit like '+10% health' or '+15% growth'\n"
        f"- 'xp': experience points as an integer (e.g., 10)\n"
        f"Only return a JSON array of these task objects. Do not include explanations or additional text."
    )


    payload = {
        "inputs": prompt,
        "parameters": {
            "max_new_tokens": 512,
            "temperature": 0.7,
            "return_full_text": False
        }
    }

    response = requests.post(LLM_API_URL, headers=llm_headers, json=payload)

    if response.status_code == 200:
        try:
            result = response.json()
            text_output = result[0]["generated_text"]

            # Try parsing just the JSON structure
            json_start = text_output.find("[")
            json_end = text_output.rfind("]") + 1
            task_json = text_output[json_start:json_end]
            tasks = json.loads(task_json)

            return {
                "plant_type": plant_type,
                "state": state,  # Include the state in the response
                "tasks": tasks
            }

        except (json.JSONDecodeError, KeyError):
            return {"error": "Failed to parse generated JSON.", "raw_output": text_output}
    else:
        return {"error": f"Request failed: {response.status_code}", "details": response.text}

def get_structured_plant_tasks_without_state(plant_type):
    prompt = (
        f"You are an expert plant care assistant. Generate exactly 4 or 5 JSON tasks for a '{plant_type}'. "
        f"Each task must be something to do in the next 3 days.  "
        f"Return only a valid JSON array, no extra text.\n\n"
        f"Each task must include:\n"
        f"- 'verb': short action like 'Water the plant'\n"
        f"- 'amount': how much/how often\n"
        f"- 'icon': an emoji (e.g., 🌊, ✂️)\n"
        f"- 'effect': e.g., '+10% health'\n"
        f"- 'xp': integer XP (e.g., 10)\n\n"
        f"Respond ONLY with a JSON array like this:\n"
        f"[{{'verb': ..., 'amount': ..., 'icon': ..., 'effect': ..., 'xp': ...}}, ...]"
    )


    payload = {
        "inputs": prompt,
        "parameters": {
            "max_new_tokens": 512,
            "temperature": 0.7,
            "return_full_text": False
        }
    }

    # ✅ Use the LLM API here instead
    response = requests.post(LLM_API_URL, headers=llm_headers, json=payload)

    if response.status_code == 200:
        try:
            result = response.json()
            text_output = result[0]["generated_text"]

            json_start = text_output.find("[")
            json_end = text_output.rfind("]") + 1
            task_json = text_output[json_start:json_end]
            tasks = json.loads(task_json)

            return {
                "plant_type": plant_type,
                "tasks": tasks
            }

        except (json.JSONDecodeError, KeyError) as e:
            return {"error": "Failed to parse generated JSON.", "raw_output": text_output}
    else:
        return {"error": f"Request failed: {response.status_code}", "details": response.text}

def get_plant_usage_suggestions(plant_name):
    prompt = (
        f"You are a culinary and nutrition expert. A user provides the plant: '{plant_name}'. "
        f"Suggest 3 to 5 different culinary uses such as meals, juices, jams, or drying methods. "
        f"For each use, return a single valid JSON object in this format:\n\n"
        f"[{{\n"
        f'  "name": "e.g. Tomato soup",\n'
        f'  "step": "Short preparation description",\n'
        f'  "time": "e.g. 30 min",\n'
        f'  "difficulty": "Easy | Medium | Hard",\n'
        f'  "calories": number,\n'
        f'  "protein": number,\n'
        f'  "carbs": number,\n'
        f'  "fat": number,\n'
        f'  "servings": number\n'
        f"}}]\n\n"
        f"Output ONLY a valid JSON array using double quotes and no units like 'g' for numbers. Do not include any explanation or example outside the JSON array."
    )

    payload = {
        "inputs": prompt,
        "parameters": {
            "max_new_tokens": 512,
            "temperature": 0.7,
            "return_full_text": False
        }
    }

    response = requests.post(LLM_API_URL, headers=llm_headers, json=payload)

    if response.status_code == 200:
        try:
            result = response.json()
            text_output = result[0]["generated_text"]

            json_start = text_output.find("[")
            json_end = text_output.rfind("]") + 1
            suggestions_json = text_output[json_start:json_end]

            suggestions = json.loads(suggestions_json)
            return {"plant": plant_name, "suggestions": suggestions}

        except (json.JSONDecodeError, KeyError):
            return {"error": "Failed to parse generated JSON.", "raw_output": text_output}
    else:
        return {"error": f"Request failed: {response.status_code}", "details": response.text}

@app.post("/analyze-plant/")
async def analyze_plant(file: UploadFile = File(...), plant_type: str = Form(...)):
    try:
        img_bytes = await file.read()

        # Step 1: Detect plant condition
        plant_state = get_plant_state_from_image(img_bytes)

        if plant_state is None:
            return JSONResponse(status_code=400, content={"message": "The uploaded image is not recognized as a plant."})

        # Step 2: Get care tasks based on diagnosis
        tasks = get_structured_plant_tasks(plant_type, plant_state)

        return JSONResponse(content=tasks)
    except Exception as e:
        return JSONResponse(status_code=500, content={"error": str(e)})

    
@app.post("/grow-plant/")
async def grow_plant_without_state(plant_type: str = Form(...)):
    try:

        # Step 2: Get care tasks based on diagnosis
        tasks = get_structured_plant_tasks_without_state(plant_type)

        return JSONResponse(content=tasks)
    except Exception as e:
        return JSONResponse(status_code=500, content={"error": str(e)})
    

@app.post("/suggest-uses/")
async def suggest_uses(plant_name: str = Form(...)):
    try:
        suggestions = get_plant_usage_suggestions(plant_name)
        return JSONResponse(content=suggestions)
    except Exception as e:
        return JSONResponse(status_code=500, content={"error": str(e)})
