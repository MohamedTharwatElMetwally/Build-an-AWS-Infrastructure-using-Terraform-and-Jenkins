
resource "aws_ses_email_identity" "my_email" {
  email = var.my_email
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda-ses-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "lambda_policy" {
  name   = "lambda-policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["s3:*", "s3-object-lambda:*"],
        Resource = "*"
      },
      {
      Effect   = "Allow",
      Action   = ["ses:*"],
      Resource = "*"
      }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "send_email.py"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "send_email" {
  filename      = data.archive_file.lambda.output_path
  function_name = "send_email"
  role          = aws_iam_role.lambda_role.arn
  handler       = "send_email.lambda_handler"  # filename.handlername
  runtime       = "python3.8"
}

resource "aws_lambda_permission" "s3_trigger_permission" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.send_email.arn
  principal     = "s3.amazonaws.com"
  source_arn    = var.statefile_bucket_arn
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = var.statefile_bucket

  lambda_function {
    lambda_function_arn = aws_lambda_function.send_email.arn
    events              = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*"]
  }
}



