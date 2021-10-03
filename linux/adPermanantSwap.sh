# Add Permanent SWAP 8GB
   # Create swap file
   sudo fallocate -l 8G /swapfile

   #Change Permissions
   sudo chmod 600 /swapfile 

   #Mark the file as swap space 
   sudo mkswap /swapfile

   #enable the swap file, allowing our system to start utilizing it
   sudo swapon /swapfile

   #Verify that the swap is available
   sudo swapon --show

   #Check Memory for the server
   free -h

   #Backup fstab file before modifying
   sudo cp /etc/fstab /etc/fstab.bak-21

   #Add a line to fstab to make swap permanant
   echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
   
   #Print the fstab file contents
   sudo cat /etc/fstab