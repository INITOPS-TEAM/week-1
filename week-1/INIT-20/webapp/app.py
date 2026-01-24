from flask import Flask, render_template

app = Flask(__name__)

@app.get("/")
def index():
    return render_template(
        "index.html",
        title="INIT-20 Web App",
        description="Simple web application displaying an image and a short description."
    )

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=False)
