import json
import os
from flask import Blueprint, render_template


def build_blueprint(url_prefix: str) -> Blueprint:
    bp = Blueprint("main", __name__, url_prefix=url_prefix or None)

    @bp.get("/")
    def index():
        raw = os.getenv("APPS_JSON", "[]")
        try:
            apps = json.loads(raw)
            if not isinstance(apps, list):
                apps = []
        except json.JSONDecodeError:
            apps = []
        return render_template(
            "index.html",
            prefix=url_prefix or "/",
            apps=apps,
        )

    return bp
