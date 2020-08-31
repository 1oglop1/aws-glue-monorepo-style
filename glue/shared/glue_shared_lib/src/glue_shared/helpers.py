"""Helper functions used across this library."""
import os
import re
from functools import partial
from itertools import islice
from typing import Tuple

EXTENSIONS = re.compile(r".+py$|.+zip$|.+egg$")


def take(n, iterable):
    """
    Return first n items of the iterable as a list

    Notes
    -----
    From itertools recipes:
    https://docs.python.org/3.6/library/itertools.html#itertools-recipes
    """

    return list(islice(iterable, n))


def chunked(iterable, n):
    """Break *iterable* into lists of length *n*:

        >>> list(chunked([1, 2, 3, 4, 5, 6], 3))
        [[1, 2, 3], [4, 5, 6]]

    If the length of *iterable* is not evenly divisible by *n*, the last
    returned list will be shorter:

        >>> list(chunked([1, 2, 3, 4, 5, 6, 7, 8], 3))
        [[1, 2, 3], [4, 5, 6], [7, 8]]

    To use a fill-in value instead, see the :func:`grouper` recipe.

    :func:`chunked` is useful for splitting up a computation on a large number
    of keys into batches, to be pickled and sent off to worker processes. One
    example is operations on rows in MySQL, which does not implement
    server-side cursors properly and would otherwise load the entire dataset
    into RAM on the client.

    Notes
    -----
    Reimplemented from more itertools to avoid the installation of the package.
    https://more-itertools.readthedocs.io/en/stable/api.html#more_itertools.chunked
    """
    return iter(partial(take, n, iter(iterable)), [])


def get_py_zip_egg_files(path: str) -> Tuple[str, ...]:
    """
    Find all .py, .zip, .egg files in sys.path.

    This method is a workaround needed for Glue2.0 as of 2020-05-11
    """

    return tuple(
        e.path for e in filter(lambda ent: EXTENSIONS.match(ent.name), os.scandir(path))
    )
