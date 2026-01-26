from flask import Flask, render_template

app = Flask(__name__)

@app.route("/")
def hello(name="DevOps engineer Mykola"):
    return render_template('index.html', person=name)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)