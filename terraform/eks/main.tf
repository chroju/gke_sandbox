data "aws_subnet_ids" "private" {
  vpc_id = "vpc-8cb763e9"
  filter {
    name   = "tag:Type"
    values = ["private"]
  }
}

resource "aws_eks_cluster" "nebula" {
  name     = "nebula"
  role_arn = aws_iam_role.nebula_cluster_role.arn

  vpc_config {
    subnet_ids = data.aws_subnet_ids.private.ids
  }

  depends_on = [
    "aws_iam_role_policy_attachment.AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.AmazonEKSServicePolicy",
  ]
}

resource "aws_eks_fargate_profile" "nebula" {
  cluster_name           = aws_eks_cluster.nebula.name
  fargate_profile_name   = "nebula"
  pod_execution_role_arn = aws_iam_role.nebula_pod_role.arn
  subnet_ids             = data.aws_subnet_ids.private.ids

  selector {
    namespace = "default"
  }
}
