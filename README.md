# Future Internet SS19 Mini-Project

## Introduction

This repo contains docs, slides and source code for a Mini-project as part of the future internet course at the University of Paderborn.

The goal of this project is to create a complex service consisting of multiple VNFDs and deploy it on OpenStack using Open Source MANO as the orchestrator.

---

## Environment setup

I have used VMs provided by the university to install OpenStack and Open Source MANO. Minimum configuration is 8GB ram, 4 cpu and 250GB disk.

+ OpenStack
    + Devstack as an easy to use setup of OpenStack 
    + Follow this guide to install - https://docs.openstack.org/devstack/latest/

+ Open Source MANO
    + Orchestrator for deploying and managing virtual functions
    + Follow this guide to install - https://osm.etsi.org/wikipub/index.php/OSM_Release_FIVE

+ Ubuntu Cloud Image
    + Pre-installed light weight images for the cloud, to be used for building the VNFs.
    + Using qcow image format for OpenStack
    + Download qcow image from here (Xenial here) -  https://cloud-images.ubuntu.com/

---

## VNF Image Preparation

### cloud-init

+ OpenStack and cloud-init 
    - https://raymii.org/s/tutorials/Automating_Openstack_with_Cloud_init_run_a_script_on_VMs_first_boot.html

    - https://www.tuxfixer.com/configure-openstack-instance-at-boot-time-using-cloud-init-user-data/

+ Example config files - https://cloudinit.readthedocs.io/en/latest/topics/examples.html#yaml-examples

### Ubuntu cloud image

+ Running and preparing qcow2 image - https://www.poftut.com/linux-qemu-img-command-tutorial-examples-create-change-shrink-disk-images/

+ Openstack instance SSH - https://docs.openstack.org/horizon/latest/user/configure-access-and-security-for-instances.html

+ Debugging openstack networking - https://docs.openstack.org/ocata/admin-guide/compute-networking-nova.html

+ Creating ubuntu base image for openstack with cloud-init - https://docs.openstack.org/image-guide/ubuntu-image.html


### HAProxy

+ Basic introduction - https://www.digitalocean.com/community/tutorials/an-introduction-to-haproxy-and-load-balancing-concepts

+ HAProxy on ubuntu - https://www.digitalocean.com/community/tutorials/how-to-use-haproxy-to-set-up-http-load-balancing-on-an-ubuntu-vps

+ Related - https://raymii.org/s/articles/Building_HA_Clusters_With_Ansible_and_Openstack.html

---

## Descriptor Creation (NSD/VNFD)

+ Definition - https://osm.etsi.org/wikipub/index.php/Release_0_Data_Model_Details

+ Creating new VNFD - https://osm.etsi.org/wikipub/index.php/Creating_your_own_VNF_package 

+ Tree structure of descriptors
    - http://osm-download.etsi.org/repository/osm/debian/ReleaseFIVE/docs/osm-im/osm_im_trees/vnfd.html
    - http://osm-download.etsi.org/repository/osm/debian/ReleaseFIVE/docs/osm-im/osm_im_trees/nsd.html

+ OSM Hackfest Files - https://osm-download.etsi.org/ftp/osm-5.0-five/6th-hackfest/
    - Slides - https://osm-download.etsi.org/ftp/osm-5.0-five/6th-hackfest/presentations/
    - Descriptors - https://osm-download.etsi.org/ftp/osm-5.0-five/6th-hackfest/packages/

---

## VNF Forwarding Graph

+ OpenStack SFC demo
    - https://blog.cafarelli.fr/2016/11/service-function-chaining-demo-with-devstack/
    - link to script - https://github.com/voyageur/openstack-scripts/blob/master/simple_sfc_vms.sh

+ OSM VNFFG Implementation - https://osm.etsi.org/wikipub/index.php/OSM_RO_VNFFG_implementation

+ OSM vnffgd example NSD - https://osm.etsi.org/gitweb/?p=osm/RO.git;a=blob;f=scenarios/examples/v3_3vnf_2vdu_1vnffg_nsd.yaml;h=efe975f768da589bd83c6baab7a994805546c5ef;hb=HEAD

+ Interesting intern project with a simple vnffg - https://wiki.opnfv.org/display/sfc/OSM+guide

+ networking-sfc commands - https://docs.openstack.org/networking-sfc/newton/command_extensions.html#list-of-new-neutron-cli-commands

+ Some info about port pairs, etc - https://docs.openstack.org/newton/networking-guide/config-sfc.html
