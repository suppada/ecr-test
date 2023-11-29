resource "aws_ecr_repository" "repo" {
  name                 = var.name
  force_delete         = var.force_delete
  image_tag_mutability = var.image_tag_mutability
  encryption_configuration {
    encryption_type = var.encryption_type
    kms_key         = var.kms_key
  }
  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
  timeouts {
    delete = var.timeouts_delete
  }
  tags = var.tags
}

resource "aws_ecr_repository_policy" "ecrpolicy" {
  repository = aws_ecr_repository.repo.name
  policy     = <<EOF
  {
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "ECR Policy",
            "Effect": "Allow",
            "Principal": {
              "Service": "ecr.amazonaws.com"
              },
            "Action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability",
                "ecr:PutImage",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload",
                "ecr:DescribeRepositories",
                "ecr:GetRepositoryPolicy",
                "ecr:ListImages",
                "ecr:DeleteRepository",
                "ecr:BatchDeleteImage",
                "ecr:SetRepositoryPolicy",
                "ecr:DeleteRepositoryPolicy"
            ]
        }
    ]
}
EOF
}

#Ecr Policy
resource "aws_ecr_repository_policy" "policy" {
  count      = var.policy == null ? 0 : 1
  repository = aws_ecr_repository.repo.name
  policy     = resource.aws_ecr_repository_policy.ecrpolicy
}

# Lifecycle policy
resource "aws_ecr_lifecycle_policy" "lifecycle_policy" {
  count      = var.lifecycle_policy == null ? 0 : 1
  repository = aws_ecr_repository.repo.name
  policy     = var.lifecycle_policy
}