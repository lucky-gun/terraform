## Instance Image ##
data "openstack_images_image_v2" "vm_image" {
name = var.vm_image
most_recent = true
}

## Network ##
data "openstack_networking_network_v2" "vm_network" {
matching_subnet_cidr = data.openstack_networking_subnet_v2.vm_subnet.cidr
}

data "openstack_networking_subnet_v2" "vm_subnet" {
cidr = var.vm_network_cidr
}

data "openstack_networking_network_v2" "floating_network" {
external = true
}

