kc_region = "kr-central-2"
kc_availability_zone = "kr-central-2-a"
kc_auth_url = "https://iam.kakaocloud.com/identity/v3"
kc_application_credential_id = "a"
kc_application_credential_secret = "b"

# 아래 vm_network_cidr은 인스턴스를 생성할 Subnet의 CIDR 값을 입력합니다.
vm_network_cidr = "10.0.0.0/20" # vpc-techcs와 동일
instance_name = "vm-lucas-terraform-making"
instance_flavor = "m3az.large"
instance_count = 1
vm_image = "Ubuntu 20.04 - 5.4.0-173"

