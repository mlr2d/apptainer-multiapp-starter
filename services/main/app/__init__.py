import os
from flask import Flask, redirect


def _clean_prefix(value: str) -> str:
    value = (value or "").strip()
    if not value or value == "/":
        return ""
    if not value.startswith("/"):
        value = "/" + value
    return value.rstrip("/")


def create_app() -> Flask:
    app = Flask(__name__)
    url_prefix = _clean_prefix(os.getenv("URL_PREFIX", ""))

    from .routes import build_blueprint

    app.register_blueprint(build_blueprint(url_prefix))

    if url_prefix:
        @app.get("/")
        def root_redirect():
            return redirect(f"{url_prefix}/", code=302)

    return app
