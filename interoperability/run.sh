#!/bin/bash

# Array of test parameters
tests=(
    "testBasic"
    "test_dollar_topics"
    "test_keepalive"
    "test_offline_message_queueing"
    "test_overlapping_subscriptions"
    "test_redelivery_on_reconnect"
    "test_retained_message"
    "test_subscribe_failure"
    "test_unsubscribe"
    "test_zero_length_clientid"
)

# Loop through the tests array
for test in "${tests[@]}"; do
    docker rm -f flowmq 
    docker run --name flowmq -d -p 1883:1883 ghcr.io/flowmq-io/flowmq:0.3.0 --data-dir /tmp --storage sqlite
    sleep 1

    echo "Running test: Test.$test"
    python3 client_test.py "Test.$test"
    # Optional: Add a sleep between tests if needed
    # sleep 1
done

echo "All tests completed!"
