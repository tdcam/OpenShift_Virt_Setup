# OpenShift_Virt_Setup
This is a set of scripts, playbooks, and roles for standing up OCP-virt.
No warranty is implied or offered. If this breaks, you get to keep all
the pieces. sPlease take pictures of any flames shooting out of your server 
that I can add to my collection. Patches cheerfully accepted. Feel free to 
open any issues.

The shell script install-kube-descheduler.sh is just a brute force script
to get the descheduler configured so that the hypervisors don't accidentally
evict a VM.

The install-kube-descheduler.yaml playbooks is an all-in-one playbook which
does basically the same thing.

The install-kube-descheduler-role.yaml playbook calls the kube-descheduler role
under roles, You can peruse that simple role to see what I had in mind.

The install-kube-descheduler-role.yaml is a playbook which calls the 
kube-descheduler-deluxe role to get everything set up. You can peruse the 
role directory to see what I'm doing in the role. Its slightly more 
complicated but I've tried to write it so that it's easily followed.
