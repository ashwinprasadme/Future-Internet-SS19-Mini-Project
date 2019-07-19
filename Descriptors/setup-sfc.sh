
# Get port list from openstack

# + Client
# 02aa17fd-d188-424a-b919-140fdbc09afb | eth1         | fa:16:3e:41:ac:4f | ip_address='172.17.17.21', subnet_id='ae5c02ed-155e-4f8c-ab7b-7eb0c02c23f5'           
# bedb6b58-452e-4709-adbf-d60ca87dcd59 | eth0         | fa:16:3e:51:b0:b6 | ip_address='10.0.0.69', subnet_id='cad3eb32-ec29-41d8-bcfa-afde271b968e'             

# + tcpdump
# d83aa737-4dde-4191-8359-a82ad636b330 | eth1         | fa:16:3e:e5:a3:5b | ip_address='172.17.17.22', subnet_id='ae5c02ed-155e-4f8c-ab7b-7eb0c02c23f5'          
# 298a3132-6843-47f9-8ece-b23b0019f1b7 | eth0         | fa:16:3e:6c:19:63 | ip_address='10.0.0.71', subnet_id='cad3eb32-ec29-41d8-bcfa-afde271b968e'             

# ----

SOURCE_IP=172.17.17.21
DEST_IP=172.17.17.11
source_vm_port=02aa17fd-d188-424a-b919-140fdbc09afb

tcp_in=d83aa737-4dde-4191-8359-a82ad636b330
tcp_out=298a3132-6843-47f9-8ece-b23b0019f1b7

# HTTP Flow classifier (catch the web traffic from source_vm to dest_vm)
openstack sfc flow classifier create \
    --ethertype IPv4 \
    --source-ip-prefix ${SOURCE_IP}/24 \
    --destination-ip-prefix ${DEST_IP}/24 \
    --protocol tcp \
    --destination-port 80:80 \
    --logical-source-port ${source_vm_port} \
    FC_http

# UDP flow classifier (catch all UDP traffic from source_vm to dest_vm, like traceroute)
openstack sfc flow classifier create \
    --ethertype IPv4 \
    --source-ip-prefix ${SOURCE_IP}/24 \
    --destination-ip-prefix ${DEST_IP}/24 \
    --protocol udp \
    --logical-source-port ${source_vm_port} \
    FC_udp


# Create the port pairs for all 3 VMs
openstack sfc port pair create --ingress=${tcp_in} --egress=${tcp_out} PP1

# And the port pair groups
openstack sfc port pair group create --port-pair PP1 PG1

# The complete chain
openstack sfc port chain create --port-pair-group PG1 --flow-classifier FC_udp --flow-classifier FC_http PC1

# forward packets on tcpdump image
sudo sh -c 'echo 1 > /proc/sys/net/ipv4/ip_forward'

# Start packet capture
sudo tcpdump -i any port 80