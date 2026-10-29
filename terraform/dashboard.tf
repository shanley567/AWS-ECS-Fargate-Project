#################################################
# Create monitoring dashboard
#
# Creates a CloudWatch dashboard for ECS CPU utilization
#################################################

resource "aws_cloudwatch_dashboard" "ecs" {
  dashboard_name = "devops-ecs-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            [
              "AWS/ECS",
              "CPUUtilization",
              "ClusterName",
              aws_ecs_cluster.main.name,
              "ServiceName",
              aws_ecs_service.app.name
            ]
          ]
          period = 300
          stat   = "Average"
          region = var.aws_region
          title  = "ECS CPU"
        }
      }
    ]
  })
}