from app.app import app


def test_home_page():
    app.testing = True
    client = app.test_client()

    response = client.get("/")

    assert response.status_code == 200

    data = response.get_json()

    assert data["message"] == "Welcome to our DevOps CI/CD Automation Platform!"
    assert data["status"] == "Application is running"
    assert data["version"] == "1.0.0"


def test_health_endpoint():
    app.testing = True
    client = app.test_client()

    response = client.get("/health")

    assert response.status_code == 200

    data = response.get_json()

    assert data["status"] == "healthy"
