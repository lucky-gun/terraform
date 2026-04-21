resource "openstack_compute_instance_v2" "instance" {
count       = var.instance_count
name        = var.instance_name
flavor_name = var.instance_flavor
availability_zone = var.kc_availability_zone
key_pair        = "TechCS" # 처음 테스트시에는 TechCS.pem으로 입력하여 오류가 2번 났었습니다. 다만 끝까지 terraform 진행되지 않고 끝났습니다.

block_device {
    uuid                  = data.openstack_images_image_v2.vm_image.id
    source_type           = "image"
    volume_size           = 50
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
}

network {
    port = openstack_networking_port_v2.instance[count.index].id
}
}

