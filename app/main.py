from flask import Flask, request

app = Flask(__name__)


@app.route("/")
def hello_world():
    return "Hello!"


# GET route
@app.route("/list", methods=["GET"])
def get_example():
    return "This is a GET request example."


# POST route
@app.route("/create", methods=["POST"])
def post_example():
    data = request.json
    return f"This is a POST request example. Received data: {data}"


if __name__ == "__main__":
    app.run(port=8080, host="0.0.0.0", debug=True)
