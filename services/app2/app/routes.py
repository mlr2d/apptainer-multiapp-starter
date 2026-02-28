from flask import Blueprint, render_template


def build_blueprint(url_prefix: str) -> Blueprint:
    bp = Blueprint("main", __name__, url_prefix=url_prefix or None)

    @bp.get("/")
    def index():
        return render_template(
            "index.html",
            prefix=url_prefix or "/",
            color="success",
        )

    return bp
