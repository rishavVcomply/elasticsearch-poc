## Full Text Search even within binary files using Elasticsearch:

Elasticsearch is a distributed, RESTful search and analytics engine. It centrally stores our data for lightning-fast search with fine‑tuned relevancy and powerful analytics that scale with ease. <br>

It stores data in clusters of nodes where each node is a collection of indices. <br>

For storing the indices it uses inverted indices with finite state transducers for full-text querying, and BKD trees for storing numeric and geo data.

### Uploading data to an index:

As mentioned before, elasticsearch stores our data and then performs queries on the data. So, we first need to upload our data to it. <br>

We can upload any kind of string text data. But the thing to keep in mind is that each data item must be stored under an index and must have its own unique id within that index. <br>

So, while uploading data, we **must** mention:

- The name of an **index** under which the data is to be stored
- The unique **id** for the file under the index
- The **type** for the data we are uploading (`_doc` for base64 encoded string of binary files)

<br>

**Note**: If there exists no index having the index name we mentioned, then a new index with that name will be created. If it does exist from before, then our data item gets stored into it, with the id we provided.

<br>

**Note**: If in the index, there already exists a data item with the id we mentioned, then the existing data item will get updated with the new data that we provided.

<br>

Like mentioned before, elasticsearch is a RESTful engine. So we have to communicate with it through the REST api that it provides. <br>

**API specifications for uploading(or updating) data:**

```
PUT http://localhost:9200/<index>/<type>/<id>
{
    data: <string or text data to be stored in the data item>
}
```

**What about non-textual or binary files?**

We can upload binary file data into indices by uploading the `base64 encoded string` generated from their binary data. <br>

This base64 encoded string can then be processed by the `ingest plugin` of elasticsearch, which can extract text data out even from this binary data (like, of docx or pdf files). <br>

For that, we first have to install the ingest plugin with the following command:

```

```

After that, we can use the functionality provided by the plugin at `/_ingest`. <br>

For processing base64 data of files, be need to create a `pipeline`. <br>

**API specifications for creating a pipeline for uploading binary data:**

```
PUT http://localhost:9200/_ingest/pipeline/<pipeline name>
{
  description: "Extract attachment information",
  processors: [
    {
      attachment: {
        field: "data",
        indexed_chars: -1
      }
    }
  ]
}
```

After that, we can use this pipeline for processing the base64 encoded string of the file. <br>

**API specifications for uploading binary data and processing it through a pipeline before storage:**

```
PUT http://localhost:9200/<index>/<type>/<id>?pipeline=<pipeline name>
{
    data: <base64 encoded string of the binary file data>
}
```

On processing the data through the ingest plugin's pipeline, it generates a parameter named `attachments` and stores the text that it extracted into `attachments.content`. The searching on such files, we have to query on this `attachments.content` feild only.

### Searching for data in an index:

After storing data into indices, we can perform full text search over all fields of all data present in the index.

**API specifications for performing full text search over all data items in an index:**

```
GET http://localhost:9200/<index>/_search?q=<searchTerm>
```

This will return all data items that contain the `searchTerm`. <br>

We can also use the same route for fetching list of all data items under that index along with their ids and metadata. <br>

**API specifications for fetching all data items from an index:**

```
GET http://localhost:9200/<index>/_search
```

### Deleting data item from an index:

We can delete data items from an index using their unique id.

**API specifications for deleting data items from an index:**

```
DELETE http://localhost:9200/<index>/_doc/<id>
```
