from src.app import greet


def test_greet_with_name() -> None:
    assert greet("Alice") == "Hello, Alice!"


def test_greet_without_name() -> None:
    assert greet("") == "Hello, Stranger!"
