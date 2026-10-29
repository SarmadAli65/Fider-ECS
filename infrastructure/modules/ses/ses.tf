resource "aws_iam_user" "fider_ses_user" {
    name = "fider-ses-user"
    force_destroy = true
}

resource "aws_iam_access_key" "fider_ses_user" {
    user = aws_iam_user.fider_ses_user.name
}


resource "aws_iam_user_policy" "fider_ses_user_policy" {
    user = aws_iam_user.fider_ses_user.name

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = [
                    "ses:SendEmail",
                    "ses:SendRawEmail"
                ]
                Effect = "Allow"
                Resource = aws_ses_email_identity.verified_email.arn
            }
        ]
    })
    
}

resource "aws_ses_email_identity" "verified_email" {
    email = var.verified_email
}