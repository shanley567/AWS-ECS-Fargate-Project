from app import app


def test_health_endpoint():

    client = app.test_client()

    response = client.get("/")

    assert response.status_code == 200


def test_health_response():

    client = app.test_client()

    response = client.get("/")

    expected = {
        "service": "devops-ecs-demo",
        "status": "healthy"
    }

    assert response.get_json() == expected