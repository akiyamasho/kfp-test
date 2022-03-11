import kfp.components as comp
from typing import NamedTuple


def sample() -> NamedTuple(
    "SampleOutputs",
    [("is_error", bool), ("slack_notif_msg", str), ("loop_list", list)],
):
    """
    Sample

    :return: is_error, slack_notif_msg, loop_list
    """

    from collections import namedtuple

    output_gen = namedtuple(
        "SampleOutputs", ["is_error", "slack_notif_msg", "loop_list"]
    )

    return output_gen(False, "sample_message", [1, 2, 3, 4, 5])


sample_op = comp.func_to_container_op(func=sample)
