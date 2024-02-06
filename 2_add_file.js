const fs = require("fs");
const readline = require("readline");
const path = require("path");
const axios = require("axios");

const { INDEX, PIPELINE } = require("./0_constants");

const cliInterface = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

async function readAndEncodePDF(filePath) {
  const data = await fs.promises.readFile(filePath);
  const base64Content = Buffer.from(data).toString("base64");
  return base64Content;
}

async function addFile() {
  cliInterface.question(`Enter path to file: `, async (filePath) => {
    const base64Content = await readAndEncodePDF(filePath);

    const filename = path.basename(filePath);
    const fileId = new Date().toISOString() + "_" + filename;

    const response = await axios.put(
      `http://localhost:9200/${INDEX}/_doc/${fileId}?pipeline=${PIPELINE}`,
      {
        data: base64Content,
      }
    );

    if (response.data.result === "created") {
      console.log(
        `File successfully stored with id ${fileId} under the index ${INDEX}`
      );
    } else {
      console.log("Something went wrong");
    }

    console.log("Complete response data:");
    console.log(response.data);

    cliInterface.close();
  });
}

addFile();
