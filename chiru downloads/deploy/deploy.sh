
function stopTomcat()
{
  echo "*** STOPPING TOMCAT INSTANCE***"
   ssh root@192.168.160.128 "sh /home/vagrant/apache-tomcat-7.0.67/bin/shutdown.sh"
}
function startTomcat()
{
  echo "*** STARTING TOMCAT INSTANCE***"
  ssh root@192.168.160.128 "sh /home/vagrant/apache-tomcat-7.0.67/bin/startup.sh"
  ssh root@192.168.160.128 "sleep 5"
}
#function Localise()
#{
 # ssh vagrant@192.168.33.32 "sleep 3"
  #myAppPath="/home/vagrant/apache-tomcat-7.0.67/webapps/leadapp/WEB-INF/classes"
  #echo "Localisation of config property"
  #ssh vagrant@192.168.33.32 "sed -i "s/DB_IP/192.168.33.30/g" $myAppPath/hibernate.cfg.xml"
  #ssh vagrant@192.168.33.32 "sed -i "s/DB_NAME/MyDB/g" $myAppPath/hibernate.cfg.xml"
  #ssh vagrant@192.168.33.32 "sed -i "s/DB_USER/lead/g" $myAppPath/hibernate.cfg.xml"
  #ssh vagrant@192.168.33.32 "sed -i "s/DB_PWD/lead/g" $myAppPath/hibernate.cfg.xml"
#}
#function backupApp()
#{
 # echo "*** Backup of Application  ***"
 #ssh vagrant@192.168.33.32  "mkdir -p /home/vagrant/backup"
 #ssh vagrant@192.168.33.32 "if [ -f /home/vagrant/apache-tomcat-7.0.67/webapps/leadapp.war ]; then mv /home/vagrant/apache-tomcat-7.0.67/webapps/leadapp.war /home/vagrant/backup/leadapp_`date +%Y-%m-%d-%s`.war; rm -rf /home/vagrant/apache-tomcat-7.0.67/webapps/leadapp; fi"\

#}
#function backupDB()
#{
  #echo "*** Backup of DB schema ***"
  # ssh vagrant@192.168.33.30  "mkdir -p /home/vagrant/backup"
 # ssh vagrant@192.168.33.30 "mysqldump -u lead -plead MyDB > /home/vagrant/backup/dbBackup_`date +%Y-%m-%d-%s`.sql"
}
function deployApp()
{
  echo "*** Deplyo the WAR file on Tomcat ***"
  scp dist/AntExample1.war root@192.168.160.128:/home/root/apache-tomcat-7.0.67/webapps
}
#function deployDB()
#{
 # echo "***Deploymebt of DB schema ***"
  #scp src/database/schema.sql vagrant@192.168.33.30:/home/vagrant/
  #ssh vagrant@192.168.33.30 "mysql -u lead -plead MyDB < schema.sql"
  i#f [ $? -eq 0 ]
  #then
   #  echo "The DB Deployment happend Succesfully"
 #else
  #   echo "ALERT:!!  Something went wrong wioth deployment , please check"
  #fi
#}

echo "***** DEPLOLYMET STARTED TIME `date`" 
if [ $# -eq 1 ]
then
op=$1
echo "Entered oepration is $op"

case $op in 

deploy )  stopTomcat
         backupApp 
         #backupDB
	 #deployDB
	 deployApp
	 startTomcat
      #   Localise
         stopTomcat
         startTomcat;;
restart ) stopTomcat
	 startTomcat ;;
#dbDeploy ) deployDB ;;

*) 	echo "Please enter correct operation" ;;

esac

else
   echo "USAGE: sh deploy.sh deploy"
fi
echo "***** DEPLOLYMET COMPLETED TIME `date`"

