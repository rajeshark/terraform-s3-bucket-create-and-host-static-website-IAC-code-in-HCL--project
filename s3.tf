terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.11.0"
    }
    random = {
        source="hashicorp/random"
        version="3.7.2"
    }
  }
}

provider "aws" {
    region = "eu-north-1"
}
resource "random_id" "rand_id" {
    byte_length= 8
  
}

resource "aws_s3_bucket" "demo_bucket" {
    bucket="raj-${random_id.rand_id.hex}"
    region="eu-north-1"
    
}
resource "aws_s3_bucket_public_access_block" "public_access" {
    bucket = aws_s3_bucket.demo_bucket.id
    
    block_public_acls = false
    block_public_policy = false
    ignore_public_acls = false
    restrict_public_buckets = false
  
}
resource "aws_s3_bucket_policy" "newpolicy" {
    bucket=aws_s3_bucket.demo_bucket.id
    policy = jsonencode(
        {
    Version= "2012-10-17",
    Statement= [
        {
            Sid= "PublicReadGetObject",
            Effect= "Allow",
            Principal= "*",
            Action="s3:GetObject"
            
            Resource= "arn:aws:s3:::${aws_s3_bucket.demo_bucket.id}/*"
            
        }
    ]
}
        
    )
    
  
}

resource "aws_s3_bucket_website_configuration" "static" {
    bucket=aws_s3_bucket.demo_bucket.id

    index_document {
        suffix="index.html"
    }
  
}
resource "aws_s3_object" "file1" {
    bucket= aws_s3_bucket.demo_bucket.bucket
    source="./index.html"
    key="index.html"
    content_type = "text/html"


  
}
resource "aws_s3_object" "file2" {
    bucket=aws_s3_bucket.demo_bucket.bucket
    source="./styles.css"
    key="styles.css"
    content_type = "text/css"
  
}
output "name" {
  value=aws_s3_bucket_website_configuration.static.website_endpoint
}
