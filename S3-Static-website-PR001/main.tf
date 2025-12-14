terraform {
  required_providers {
   aws={
    source="hashicorp/aws"
    version = "5.54.1"
   }
  }
}
provider "aws" {
    region = "ap-south-1"
}
resource "aws_s3_bucket" "static-website001" {
  bucket = "static-website-s3-pr001"
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.static-website001.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "static-website001" {
  bucket = aws_s3_bucket.static-website001.id
    policy = jsonencode(
        {
    Version= "2012-10-17",		 	 	 
    Statement= [
        {
            Sid= "PublicReadGetObject",
            Effect= "Allow",
            Principal= "*",
            Action= "s3:GetObject"  
            Resource= "arn:aws:s3:::${aws_s3_bucket.static-website001.id}/*"    
        }
    ]
}
    )
}
resource "aws_s3_bucket_website_configuration" "static-website001" {
  bucket = aws_s3_bucket.static-website001.id

  index_document {
    suffix = "index.html"
  }

}
resource "aws_s3_object" "index_html" {
  source = "./index.html" 
  bucket = aws_s3_bucket.static-website001.bucket
  key = "index.html"
  content_type = "text/html"
}
resource "aws_s3_object" "styles_css" {
  source = "./styles.css" 
  bucket = aws_s3_bucket.static-website001.bucket
  key = "styles.css"
  content_type = "text/html"
}

output "name" {
  value = aws_s3_bucket_website_configuration.static-website001.website_endpoint
}
