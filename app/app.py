from flask import Flask

app = Flask(__name__)

@app.route("/")
def health():

    return {
        "service": "devops-ecs-demo",
        "status": "healthy"
    }

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

# Triggering workflow to test OIDC authentication
# These comments can be removed after testing is complete.
#