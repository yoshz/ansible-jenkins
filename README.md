Ansible Jenkins
===============

Setup a server with Jenkins using Ansible.

## Installation

Install pip:

    sudo apt-get install python-pip

Install python requirements:

    sudo pip install -r ./requirements.txt

Copy vars.yml.dist to vars.yml and change the variables to your need.


### Digital Ocean configuration

Download the Digital Ocean dynamic inventory plugin:

    wget https://raw.githubusercontent.com/ansible/ansible/devel/plugins/inventory/digital_ocean.py -O dohosts && chmod 0755 dohosts
    wget https://raw.githubusercontent.com/ansible/ansible/devel/plugins/inventory/digital_ocean.ini

Create a new API key on the [API access page](https://cloud.digitalocean.com/api_access) and add the client_id and api_key to `digital_ocean.ini`.


### AWS Configuration

Create a new S3 bucket using the AWS Console and add the bucket name to `vars.yml`.

Create a new user using IAM and add the access_key and secret_key to `vars.yml`.

Add an user policy to the new user to allow access to the bucket. For example:

    ```
    {
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "s3:ListBucket",
            "s3:GetBucketLocation",
            "s3:ListBucketMultipartUploads"
          ],
          "Resource": "arn:aws:s3:::mybucket",
          "Condition": {}
        },
        {
          "Effect": "Allow",
          "Action": [
            "s3:AbortMultipartUpload",
            "s3:DeleteObject",
            "s3:DeleteObjectVersion",
            "s3:GetObject",
            "s3:GetObjectAcl",
            "s3:GetObjectVersion",
            "s3:GetObjectVersionAcl",
            "s3:PutObject",
            "s3:PutObjectAcl",
            "s3:PutObjectAclVersion"
          ],
          "Resource": "arn:aws:s3:::mybucket/*",
          "Condition": {}
        }
      ]
    }
    ```

## Playbooks

### provision
Provision a server with Jenkins:

    ansible-playbook site.yml

### backup.yml
Backup Jenkins to S3:

    ansible-playbook playbooks/backup.yml

### restore.yml
Restore Jenkins from S3:

    ansible-playbook playbooks/restore.yml

