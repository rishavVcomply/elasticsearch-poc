const axios = require("axios");

const { PIPELINE } = require("./0_constants");

async function createPipeline() {
  const response = await axios.put(
    `http://localhost:9200/_ingest/pipeline/${PIPELINE}`,
    {
      description: "Extract attachment information",
      processors: [
        {
          attachment: {
            field: "data",
            indexed_chars: -1,
          },
        },
      ],
    }
  );
  if (response.data.acknowledged)
    console.log("Successfully created ingestion pipeline named: " + PIPELINE);
  else {
    console.log("Couldn't create ingestion pipeline");
    console.log(response.data);
  }
}

createPipeline();
