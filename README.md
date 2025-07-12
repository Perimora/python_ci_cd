# python_ci_cd

A modern Python project template with robust CI/CD, code quality, and security tooling.

## Features
- Isolated development environment with `venv`
- Linting: `black`, `flake8`, `isort`, `mypy`
- Security: `bandit`, `safety`, `pip-audit`
- Testing: `pytest` with coverage enforcement
- Pre-commit hooks
- Makefile for common tasks
- GitHub Actions CI pipeline with caching and artifact upload

## Quickstart

### 1. Clone and Install
```bash
make install-dev
source .venv/bin/activate
```

### 2. Code Quality
- Lint: `make lint`
- Format: `make format`
- Security: `make security`

### 3. Testing
- Fast tests: `make test-fast`
- Full coverage: `make test`
- Coverage report: `make coverage-report`
- Enforce 80% coverage: `make coverage-check`

### 4. Pre-commit
- Install hooks: `make install-pre-commit`
- Run all hooks: `make pre-commit`

### 5. Cleaning
- Remove build/test artifacts: `make clean`

## CI/CD
- Automated on push and PR via GitHub Actions
- Caches pip dependencies for faster builds
- Enforces lint, security, and test coverage
- Uploads coverage reports as artifacts

## Project Structure
```
├── src/                # Application code
│   └── __init__.py
├── test/               # Tests
│   └── __init__.py
├── config/             # Config files (pyproject.toml, setup.cfg, etc.)
├── requirements-dev.txt
├── Makefile
├── .pre-commit-config.yaml
├── .github/workflows/ci.yml
```