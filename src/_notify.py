import kfp.components as comp


def notify(is_error: bool, slack_notif_msg: str, item: str) -> None:
    """
    Sample

    :return: is_error, slack_notif_msg
    """

    import logging

    logging.basicConfig(
        format="%(asctime)s %(levelname)-8s %(message)s",
        level=logging.INFO,
        datefmt="%Y-%m-%d %H:%M:%S",
    )

    logger = logging.getLogger(__name__)

    logger.warning(
        f"is_error: {is_error}, slack_notif_msg: {slack_notif_msg}, store_id: {item}"
    )


notify_op = comp.func_to_container_op(func=notify)
