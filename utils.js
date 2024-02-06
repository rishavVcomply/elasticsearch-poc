function extractFilenameFromFileId(fileId) {
  const underscoreIndex = fileId.indexOf("_");
  return fileId.substring(underscoreIndex + 1);
}

module.exports.extractFilenameFromFileId = extractFilenameFromFileId;
