import nox


@nox.session(python=["3.7", "3.8", "pypy3.7"])
def tests(session):
    session.install("pytest", "testfixtures", "pytest-xdist")
    session.run("pip", "install", ".")
    session.run("pytest", "-n", "4")
