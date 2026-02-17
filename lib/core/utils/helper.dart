String getShortProjectId(String id) {
  if (id.length <= 4) return id;
  return "${id.substring(4)}....";
}
