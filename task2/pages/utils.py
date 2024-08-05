from typing import Callable
import time


def continuous_wait(condition: Callable[[], bool], length: float, timeout: float) -> None:
    """
    This function waits for a condition to be true for an interval of time equal to length seconds
    """
    start_time = time.time()
    step = 0.05
    state = False
    start_truth_time = 0.0
    elapsed_time_since_truth = 0.0
    while elapsed_time_since_truth < length:
        time.sleep(step)
        now = time.time()
        old_state = state
        state = condition()

        # follow 3 cases
        if (not old_state) and state:
            start_truth_time = now

        if old_state and state:
            elapsed_time_since_truth = now - start_truth_time

        if not state:
            elapsed_time_since_truth = 0.0

        # terminate on timeout
        total_elapsed_time = now - start_time
        if total_elapsed_time > timeout:
            raise Exception("Timeout on Continuous Wait")
