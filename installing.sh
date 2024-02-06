# Steps from: https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-elasticsearch-on-ubuntu-20-04

# ========================================== ELASTICSEARCH INSTALLATION: ===============================================

# The Elasticsearch components are not available in Ubuntu’s default package repositories
# - Import the Elasticsearch public GPG key into APT by fetching the data and piping it into the apt-key program, 
#   which adds the public GPG key to APT
# - Add the Elastic source list to the sources.list.d directory, where APT will search for new sources
# - Update the package index on your server and install elasticsearch
curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt update
sudo apt install elasticsearch

# ===================== CONFIGURATION: =================
sudo nano /etc/elasticsearch/elasticsearch.yml

# ========= (RE)STARTING THE ELASTICSEARCH SERVICE WITH MODIFIED CONFIGURATIONS =========== 
# (to be done after each configuration change):
sudo systemctl start elasticsearch
sudo systemctl enable elasticsearch # enabling the service to start on boot

# ===================== VERIFYING THE INSTALLATION: =================

curl -X GET "http://localhost:9200"

# Expected Response:
# {
#   "name" : "DESKTOP-GN9N0BN",
#   "cluster_name" : "elasticsearch",
#   "cluster_uuid" : "tY843vgvRn-rLo8284qOqA",
#   "version" : {
#     "number" : "7.17.17",
#     "build_flavor" : "default",
#     "build_type" : "deb",
#     "build_hash" : "aba4da413a368e296dfc64fb20897334d0340aa1",
#     "build_date" : "2024-01-18T10:05:03.821431920Z",
#     "build_snapshot" : false,
#     "lucene_version" : "8.11.1",
#     "minimum_wire_compatibility_version" : "6.8.0",
#     "minimum_index_compatibility_version" : "6.0.0-beta1"
#   },
#   "tagline" : "You Know, for Search"
# }

# ============= Verify all the current settings for the node, cluster, application paths, modules, and more =================
curl -XGET 'http://localhost:9200/_nodes?pretty'

# ============================================ KIBANA INSTALLATION: ===================================================

sudo apt-get update && sudo apt-get install kibana
sudo systemctl enable kibana.service
sudo systemctl start kibana.service

# ===================== VERIFYING THE INSTALLATION: ====================
# Open your browser on http://localhost:5601 (default port of kibana), and you will be able to access the app
# It should auto detect elasticsearch installation and connect to it. In case it doesn't, we need to
# restart elastcsearch and capture a token, and pass it to kibana (I didn't need to do it though, it auto detected in my case)

# NOTE: Many tutorials tell to use some tools at paths like "/bin/<toolname>"
# These paths refer to => /usr/share/elasticsearch/bin/<toolname>
# These paths refer to => /usr/share/kibana/bin/<toolname>
