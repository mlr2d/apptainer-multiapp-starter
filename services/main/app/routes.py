from flask import Blueprint, render_template
import os


def build_blueprint(url_prefix: str) -> Blueprint:
    bp = Blueprint("main", __name__, url_prefix=url_prefix or None)

    @bp.get("/")
    def index():
        app1_url = os.getenv("APP1_URL", "http://localhost:8071/app1")
        app2_url = os.getenv("APP2_URL", "http://localhost:8072/app2")
        apps = [
            {
                "name": "App 1",
                "description": "Core service endpoint",
                "icon": "bi-hdd-network",
                "url": app1_url,
            },
            {
                "name": "App 2",
                "description": "Dispatch and processing endpoint",
                "icon": "bi-send-check",
                "url": app2_url,
            },
        ]
        return render_template("index.html", prefix=url_prefix or "/", apps=apps)

    return bp
