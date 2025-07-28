resource "google_compute_address" "jumpbox-ip" {
  name = "${var.env_id}-jumpbox-ip"
}

output "jumpbox_url" {
  value = "${google_compute_address.jumpbox-ip.address}:22"
}

output "external_ip" {
  value = "${google_compute_address.jumpbox-ip.address}"
}

output "director_address" {
  value = "https://${google_compute_address.jumpbox-ip.address}:25555"
}

resource "google_compute_firewall" "jumpbox_agent_debug" {
  name    = "${var.env_id}-jumpbox-agent-debug"
  network = google_compute_network.bbl_network.name

  allow {
    protocol = "tcp"
    ports    = ["6868"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["${var.env_id}-jumpbox"]

  priority   = 900
  direction  = "INGRESS"
  description = "Allow external access to jumpbox agent for debugging"
}
