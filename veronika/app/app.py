import os
import psycopg2
from flask import Flask, render_template

app = Flask(__name__)

BIRD_SLUG = os.getenv("BIRD_SLUG", "bee-eater")

def get_bird(slug):
    conn = psycopg2.connect(
        host=os.getenv("DB_HOST"),
        port=os.getenv("DB_PORT", "5432"),
        dbname=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
    )

    cur = conn.cursor()
    cur.execute(
        """
        SELECT name, location, image_url
        FROM birds
        WHERE slug = %s
        """,
        (slug,)
    )

    row = cur.fetchone()
    cur.close()
    conn.close()

    return row  # (name, location, image_url)


@app.route("/")
def index():
    name, location, image_url = get_bird(BIRD_SLUG)

    return render_template(
        "index.html",
        title=name,
        description=location,
        image_url=image_url
    )


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=False)
