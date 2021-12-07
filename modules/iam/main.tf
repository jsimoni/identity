resource "aws_iam_policy" "policy" {
  name        = "sample-policy"
  description = "My sample policy"

  policy = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:ListAllMyBuckets"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.bucket.arn}"
    }
  ]

}
EOT
}
