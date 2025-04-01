import pytest
import json
from app.main import app


@pytest.fixture
def client():
    """Fixture to set up the test client."""
    with app.test_client() as client:
        yield client


def test_hello_world(client):
    response = client.get('/')
    assert response.status_code == 200
    assert response.data.decode('utf-8') == 'Hello!'


def test_get_example(client):
    response = client.get('/get')
    assert response.status_code == 200
    assert response.data.decode('utf-8') == 'This is a GET request example.'


def test_post_example(client):
    test_data = {'key': 'value'}
    response = client.post('/post',
                          data=json.dumps(test_data),
                          content_type='application/json')
    assert response.status_code == 200
    expected_response = (
        f'This is a POST request example. Received data: {test_data}'
    )
    assert response.data.decode('utf-8') == expected_response
