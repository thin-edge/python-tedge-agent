"""MQTT Topics"""


def health_topic(root_topic: str = "te", topic_id: str = "device/main//") -> str:
    """Health topic for the child device"""
    return "/".join(
        [
            root_topic,
            topic_id,
            "status",
            "health",
        ]
    )


def measurement_topic(
    root_topic: str = "te", topic_id: str = "device/main//", typename: str = ""
) -> str:
    """Measurement topic for the child device"""
    return "/".join(
        [
            root_topic,
            topic_id,
            "m",
            typename,
        ]
    )


def event_topic(
    root_topic: str = "te", topic_id: str = "device/main//", typename: str = ""
) -> str:
    """Event topic for the child device"""
    return "/".join(
        [
            root_topic,
            topic_id,
            "e",
            typename,
        ]
    )
