# Adding a data entry to elastic search:

# create new or modify, by {index, type, id}
curl -X POST -H "Content-Type: application/json" -d '{ "message": "Hello World!" }' 'http://localhost:9200/tutorial/helloworld/1' 

# fetch by {index, type, id}
curl -X GET 'http://localhost:9200/tutorial/helloworld/1' 
# more readable results
curl -X GET 'http://localhost:9200/tutorial/helloworld/1?pretty'


curl -H 'Content-Type: application/x-ndjson' -XPOST 'localhost:9200/bank/_bulk?pretty' --data-binary @accounts.json
curl -H 'Content-Type: application/x-ndjson' -XPOST 'localhost:9200/shakespeare/_bulk?pretty' --data-binary @shakespeare.json
curl -H 'Content-Type: application/x-ndjson' -XPOST 'localhost:9200/_bulk?pretty' --data-binary @logs.jsonl