from flask import Flask, request, jsonify

app = Flask(__name__)


@app.route("/", methods=["GET"])
def home():
    return "Flask Backend is running successfully!"


@app.route("/api/submit", methods=["POST"])
def submit_form():
    data = request.get_json()

    name = data.get("name")
    email = data.get("email")
    message = data.get("message")

    if not name or not email or not message:
        return jsonify({
            "success": False,
            "message": "All fields are required."
        }), 400

    return jsonify({
        "success": True,
        "message": "Form submitted successfully!",
        "data": {
            "name": name,
            "email": email,
            "message": message
        }
    })


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)