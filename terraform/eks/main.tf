data "aws_subnet_ids" "private" {
  vpc_id = var.vpc_id
}

resource "aws_eks_cluster" "nebula" {
  name     = var.cluster_name
  role_arn = aws_iam_role.nebula_cluster_role.arn

  vpc_config {
    subnet_ids = data.aws_subnet_ids.private.ids
  }

  enabled_cluster_log_types = ["api", "audit", "scheduler"]

  depends_on = [
    "aws_iam_role_policy_attachment.AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.AmazonEKSServicePolicy",
    "aws_cloudwatch_log_group.nebula",
  ]
}

resource "aws_eks_fargate_profile" "nebula" {
  cluster_name           = aws_eks_cluster.nebula.name
  fargate_profile_name   = var.cluster_name
  pod_execution_role_arn = aws_iam_role.nebula_pod_role.arn
  subnet_ids             = data.aws_subnet_ids.private.ids

  selector {
    namespace = "default"
  }
}
