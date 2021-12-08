resource "aws_iam_policy" "policy" {
  name        = "my-sample-policy"
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
    }
  ]

}
EOT
}
