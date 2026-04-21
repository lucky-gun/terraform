## Port ##
resource "openstack_networking_port_v2" "instance" {
count              = var.instance_count
name               = var.instance_name
network_id         = data.openstack_networking_network_v2.vm_network.id
admin_state_up     = true
security_group_ids = [openstack_networking_secgroup_v2.instance.id]
}

resource "openstack_networking_floatingip_v2" "instance_fip" {
count = var.instance_count
pool  = data.openstack_networking_network_v2.floating_network.name
}

resource "openstack_networking_floatingip_associate_v2" "instance_fip_associate" {
count       = var.instance_count
floating_ip = openstack_networking_floatingip_v2.instance_fip[count.index].address
port_id     = openstack_networking_port_v2.instance[count.index].id
}

## Security Group ##
resource "openstack_networking_secgroup_v2" "instance" {
name        = var.instance_name
description = "description"
}

resource "openstack_networking_secgroup_rule_v2" "instance_ingress_rules" {
direction         = "ingress"
ethertype         = "IPv4"
protocol          = "tcp"
port_range_min    = 22
port_range_max    = 22
security_group_id = openstack_networking_secgroup_v2.instance.id
}

