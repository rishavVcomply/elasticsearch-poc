const axios = require("axios");

const { INDEX } = require("./0_constants");
const { extractFilenameFromFileId } = require("./utils");

async function getAllFiles() {
  const response = await axios.get(`http://localhost:9200/${INDEX}/_search`);
  const fileDetails = response.data.hits.hits.map((hit) => ({
    fileId: hit._id,
    filename: extractFilenameFromFileId(hit._id),
  }));
  console.log(fileDetails);
}

getAllFiles();
