def greet(name: str) -> str:
    if not name:
        return "Hello, Stranger!"
    return f"Hello, {name}!"


if __name__ == "__main__":
    print(greet("World"))
