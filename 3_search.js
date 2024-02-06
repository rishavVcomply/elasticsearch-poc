const axios = require("axios");
const readline = require("readline");

const { INDEX } = require("./0_constants");
const { extractFilenameFromFileId } = require("./utils");

const cliInterface = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

async function searchInPDF() {
  cliInterface.question(`Enter text to search for: `, async (searchTerm) => {
    const response = await axios.get(
      `http://localhost:9200/${INDEX}/_search?q=${searchTerm}`
    );
    const fileNames = response.data.hits.hits.map((hit) =>
      extractFilenameFromFileId(hit._id)
    );
    console.log(`Files containing '${searchTerm}':`, fileNames);
    cliInterface.close();
  });
}

searchInPDF();
