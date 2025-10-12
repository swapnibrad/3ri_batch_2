# 3ri_batch_2
for learning purpose, to be access by batch
================================
Error:    
+ sudo apt-get update -y
sudo: a terminal is required to read the password; either use the -S option to read from standard input or configure an askpass helper
sudo: a password is required

Solution:
in sudoers file add => jenkins ALL=(ALL) NOPASSWD:ALL
================================
For SSH Access
manage jenkins => Security => Git Host Key Verification Configuration => Host Key Verification Strategy => no verification

Verifying host key using known hosts file
You're using 'Known hosts file' strategy to verify ssh host keys, but your known_hosts file does not exist, please go to 'Manage Jenkins' -> 'Security' -> 'Git Host Key Verification Configuration' and configure host key verification.
================================
