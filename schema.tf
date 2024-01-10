resource "null_resource" "schema" {

# This makes sure that this null_resource will only be executed post the creation of the RDS only
    depends_on = [aws_db_instance.docdb]

     provisioner "local-exec" {
        command = <<EOF
            cd /tmp
            wget https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem
            curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
            unzip -o mongodb.zip
            cd mysql-main
            ls -ltr
            mongo --ssl --host roboshop-dev-docdb.cluster-cfo0ayugi4wp.us-east-1.docdb.amazonaws.com:27017 --sslCAFile global-bundle.pem --username admin1 --password roboshop1 < catalogue.js
            
            mongo --ssl --host roboshop-dev-docdb.cluster-cfo0ayugi4wp.us-east-1.docdb.amazonaws.com:27017 --sslCAFile global-bundle.pem --username admin1 --password roboshop1 < users.js

        EOF
    } 

}