terraform (HCL) code for automatically creating S3 bucket and hosting static website
steps in code: 
1)create S3 bucket requirement uinque name for bucket or use random (here i used random Which give unique name ),give public access to bucket ,write bucket policy and enable static website hosting
2)upload or put object index.html and styles.css
3) write output to get once S3 bucket created a output endpoint or url 
4)install aws acl and through (aws configure ) give iam user account access key detail
5)install terraform run command terraform init,terraform plan,terraform validate,terraform apply
6)once terraform apply command run successfuly you will get url or endpoint of bucket as output
7)finanly paste this url or endpoint in chrome(internet any browzers)  you will see your static website hosted
