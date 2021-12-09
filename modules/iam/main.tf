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


resource "aws_iam_policy" "policy2" {
  name        = "another-sample-policy"
  description = "Another sample policy"

  policy = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]

}
EOT
}
