resource "aws_ecr_repository" "main" {
  name                 = var.name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = var.tags
}


resource "aws_ecr_lifecycle_policy" "count" {
  repository = aws_ecr_repository.main.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 10,
            "description": "Keep last 20 tagged images",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["v"],
                "countType": "imageCountMoreThan",
                "countNumber": 20
            },
            "action": {
                "type": "expire"
            }
        },
                {
            "rulePriority": 20,
            "description": "Expire untagged images older than 30 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 30
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
