import kfp.dsl as dsl

from s00_sample import sample_op
from _notify import notify_op


@dsl.pipeline(
    name="ape-sauvignon pipeline",
    description="Retrieves from `manju` and BigQuery and caches recommendation data into Memorystore",
)
def recommendation_cache_pipeline():
    s00_sample = sample_op()

    is_error = s00_sample.outputs["is_error"]
    slack_notif_msg = s00_sample.outputs["slack_notif_msg"]

    with dsl.ParallelFor(s00_sample.outputs["loop_list"]) as item:
        notify_op(
            is_error=is_error, slack_notif_msg=slack_notif_msg, item=item
        )
