resource "google_compute_network" "this" {
  name                    = var.network_name
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "private" {
  name          = var.subnet_name
  region        = var.region
  network       = google_compute_network.this.id
  ip_cidr_range = var.subnet_cidr

  private_ip_google_access = true
}

resource "google_compute_firewall" "ssh_from_aws" {
  name    = "${var.network_name}-allow-ssh-from-aws"
  network = google_compute_network.this.name

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = [var.aws_subnet_cidr]

  target_tags = ["poc-gcp-vm"]
}

resource "google_compute_firewall" "iap_ssh" {
  name    = "${var.network_name}-allow-iap-ssh"
  network = google_compute_network.this.name

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["35.235.240.0/20"]

  target_tags = ["poc-gcp-vm"]
}

resource "google_compute_instance" "this" {
  name         = var.vm_name
  zone         = var.zone
  machine_type = var.machine_type

  tags = ["poc-gcp-vm"]

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.private.id
    network_ip = var.vm_private_ip
  }
}
