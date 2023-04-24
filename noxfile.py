import nox


@nox.session(python=["3.7", "3.8", "3.9", "3.10", "3.11", "pypy3.7", "pypy3.8", "pypy3.9"])
def tests(session):
    session.install("pytest", "testfixtures", "pytest-xdist")
    session.run("pip", "install", ".")
    session.run("pytest", "-n", "4")
