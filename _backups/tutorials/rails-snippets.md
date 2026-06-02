# Rails Snippets

## Active Storage Configuration with Amazon S3 Intelligent Tiering

```yml
local:
  service: Disk
  root: <%= Rails.root.join("storage") %>

test:
  service: Disk
  root: <%= Rails.root.join("tmp/storage") %>

amazon_s3:
  service: S3
  bucket: bucket_name
  upload:
    storage_class: INTELLIGENT_TIERING # STANDARD REDUCED_REDUNDANCY INTELLIGENT_TIERING STANDARD_IA ONEZONE_IA GLACIER DEEP_ARCHIVE
```

## Debug SQL Queries and Execution Time

```ruby
time_start = Time.now
queries = []

# Subscribe to SQL queries before executing code
subscription = ActiveSupport::Notifications.subscribe('sql.active_record') do |_name, _start, _finish, _id, payload|
  # Filter out schema queries if needed
  unless payload[:name] == 'SCHEMA'
    queries << payload[:sql]
  end
end

# ... Run your code here ...

# Unsubscribe to avoid memory leaks
ActiveSupport::Notifications.unsubscribe(subscription)

{
  total_time: Time.now - time_start,
  queries_count: queries.count,
  queries: queries
}
```
