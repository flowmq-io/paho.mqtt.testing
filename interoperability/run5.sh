#!/bin/bash

# Array of test parameters
tests=(
    'test_assigned_clientid'
    'test_basic'
    'test_client_topic_alias'
    'test_dollar_topics'
    'test_flow_control1'
    'test_flow_control2'
    'test_keepalive'
    'test_maximum_packet_size'
    'test_offline_message_queueing'
    'test_overlapping_subscriptions'
    'test_payload_format'
    'test_publication_expiry'
    'test_redelivery_on_reconnect'
    'test_request_response'
    'test_retained_message'
    'test_server_keep_alive'
    'test_server_topic_alias'
    'test_session_expiry'
    'test_shared_subscriptions'
    'test_subscribe_failure'
    'test_subscribe_identifiers'
    'test_subscribe_options'
    'test_unsubscribe'
    'test_user_properties'
    'test_will_delay'
    'test_will_message'
    'test_zero_length_clientid'
)

# Loop through each test parameter
for test in "${tests[@]}"; do
    echo "Running test: $test"
    docker rm -f flowmq 
    docker run --name flowmq -d -p 1883:1883 ghcr.io/flowmq-io/flowmq:0.3.0 --data-dir /tmp --storage sqlite
    sleep 1

    python3 client_test5.py "Test.$test" -v
    # Add a small delay between tests (optional)
    # sleep 1
done

echo "All tests completed!"
