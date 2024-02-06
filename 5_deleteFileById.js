const axios = require("axios");
const readline = require("readline");

const { INDEX } = require("./0_constants");

const cliInterface = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

async function searchInPDF() {
  cliInterface.question(`Enter file id: `, async (fileId) => {
    const response = await axios.delete(
      `http://localhost:9200/${INDEX}/_doc/${fileId}`
    );
    console.log(`Successfully deleted file`);
    cliInterface.close();
  });
}

searchInPDF();
