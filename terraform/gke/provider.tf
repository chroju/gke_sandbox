provider "google" {
  #   credentials = "${file("~/.config/gcloud/credential.json")}"
  credentials = "${file("./credential.json")}"
  project     = "k8s-sandbox-193502"
  region      = "us-central1"
}
