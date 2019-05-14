provider "google" {
    project = "${var.gcp_project}"
    region = "${var.gcp_region}"
    zone = "${var.gcp_zone}" 
}

resource "google_compute_network" "default" {
    name = "${var.gcp_network_name}"
}

resource "google_compute_firewall" "default" {
    name    = "${var.gcp_firewall_rule_name}"
    description = "Firewall rules for Kubevirt lab"
    network = "${google_compute_network.default.name}"

    allow {
        protocol = "icmp"
    }

    allow {
      protocol = "tcp"
      ports    = ["80", "443", "8443"]
    }
    
    source_tags = ["${var.gcp_instance_tag}"]
}

module "gcp_kubevirt_lab" {
	source = "github.com/lumapps/terraform-google-compute-instance"
	
	amount       		= "${var.gcp_instances}"
	region       		= "${var.gcp_region}"
	name_prefix  		= "${var.hostname_prefix}"
	machine_type 		= "${var.gcp_instance_size}"
	boot_disk_size_gb   = "${var.gcp_boot_image_size_gb}"
	boot_disk_image   	= "${var.gcp_boot_image}"
    data_disk_size_gb   = "30"
    tag					= "${var.gcp_instance_tag}"
}
