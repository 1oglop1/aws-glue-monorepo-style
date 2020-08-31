def test_chunked():
    from glue_shared.helpers import chunked

    l1 = [x for x in range(10)]
    l2 = [x for x in range(12)]

    assert tuple(chunked(l1, 3)) == ([0, 1, 2], [3, 4, 5], [6, 7, 8], [9])
    assert tuple(chunked(l1, 5)) == ([0, 1, 2, 3, 4], [5, 6, 7, 8, 9])
    assert tuple(chunked(l1, 10)) == ([0, 1, 2, 3, 4, 5, 6, 7, 8, 9],)
    assert tuple(chunked(l2, 3)) == ([0, 1, 2], [3, 4, 5], [6, 7, 8], [9, 10, 11])
    assert tuple(chunked(l2, 10)) == ([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], [10, 11])
