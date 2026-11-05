#################################################
# CloudWatch Dashboard
#
# Provides a service-centric operational view
# of the ECS platform.
#
# Focuses on:
# - Availability
# - Performance
# - Capacity
# - Scaling
# - Traffic
#################################################

resource "aws_cloudwatch_dashboard" "ecs" {

  dashboard_name = "devops-ecs-dashboard"

  dashboard_body = jsonencode({

    widgets = [

      #################################################
      # CPU Utilisation
      #################################################

      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          title  = "ECS CPU Utilisation"
          region = var.aws_region
          stat   = "Average"
          period = 300

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
        }
      },

      #################################################
      # Memory Utilisation
      #################################################

      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6

        properties = {
          title  = "ECS Memory Utilisation"
          region = var.aws_region
          stat   = "Average"
          period = 300

          metrics = [
            [
              "AWS/ECS",
              "MemoryUtilization",
              "ClusterName",
              aws_ecs_cluster.main.name,
              "ServiceName",
              aws_ecs_service.app.name
            ]
          ]
        }
      },

      #################################################
      # Running Tasks
      #################################################

      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6

        properties = {
          title  = "Running Tasks"
          region = var.aws_region
          stat   = "Average"
          period = 300

          metrics = [
            [
              "ECS/ContainerInsights",
              "RunningTaskCount",
              "ClusterName",
              aws_ecs_cluster.main.name,
              "ServiceName",
              aws_ecs_service.app.name
            ]
          ]
        }
      },

      #################################################
      # Pending Tasks
      #################################################

      {
        type   = "metric"
        x      = 12
        y      = 6
        width  = 12
        height = 6

        properties = {
          title  = "Pending Tasks"
          region = var.aws_region
          stat   = "Average"
          period = 300

          metrics = [
            [
              "ECS/ContainerInsights",
              "PendingTaskCount",
              "ClusterName",
              aws_ecs_cluster.main.name,
              "ServiceName",
              aws_ecs_service.app.name
            ]
          ]
        }
      },

      #################################################
      # Request Count
      #################################################

      {
        type   = "metric"
        x      = 0
        y      = 12
        width  = 12
        height = 6

        properties = {
          title  = "ALB Request Count"
          region = var.aws_region
          stat   = "Sum"
          period = 300

          metrics = [
            [
              "AWS/ApplicationELB",
              "RequestCount",
              "LoadBalancer",
              aws_lb.app.arn_suffix
            ]
          ]
        }
      },

      #################################################
      # Healthy Targets
      #################################################

      {
        type   = "metric"
        x      = 12
        y      = 12
        width  = 12
        height = 6

        properties = {
          title  = "Healthy Targets"
          region = var.aws_region
          stat   = "Average"
          period = 300

          metrics = [
            [
              "AWS/ApplicationELB",
              "HealthyHostCount",
              "TargetGroup",
              aws_lb_target_group.app.arn_suffix,
              "LoadBalancer",
              aws_lb.app.arn_suffix
            ]
          ]
        }
      },

      #################################################
      # HTTP 5XX Errors
      #################################################

      {
        type   = "metric"
        x      = 0
        y      = 18
        width  = 12
        height = 6

        properties = {
          title  = "HTTP 5XX Errors"
          region = var.aws_region
          stat   = "Sum"
          period = 300

          metrics = [
            [
              "AWS/ApplicationELB",
              "HTTPCode_Target_5XX_Count",
              "TargetGroup",
              aws_lb_target_group.app.arn_suffix,
              "LoadBalancer",
              aws_lb.app.arn_suffix
            ]
          ]
        }
      },

      #################################################
      # HTTP 4XX Errors
      #################################################

      {
        type   = "metric"
        x      = 12
        y      = 18
        width  = 12
        height = 6

        properties = {
          title  = "HTTP 4XX Errors"
          region = var.aws_region
          stat   = "Sum"
          period = 300

          metrics = [
            [
              "AWS/ApplicationELB",
              "HTTPCode_Target_4XX_Count",
              "TargetGroup",
              aws_lb_target_group.app.arn_suffix,
              "LoadBalancer",
              aws_lb.app.arn_suffix
            ]
          ]
        }
      },

      #################################################
      # Target Response Time
      #################################################

      {
        type   = "metric"
        x      = 0
        y      = 24
        width  = 12
        height = 6

        properties = {
          title  = "Target Response Time"
          region = var.aws_region
          stat   = "Average"
          period = 300

          metrics = [
            [
              "AWS/ApplicationELB",
              "TargetResponseTime",
              "TargetGroup",
              aws_lb_target_group.app.arn_suffix,
              "LoadBalancer",
              aws_lb.app.arn_suffix
            ]
          ]
        }
      },

      #################################################
      # Desired vs Running Tasks
      #################################################

      {
        type   = "metric"
        x      = 12
        y      = 24
        width  = 12
        height = 6

        properties = {
          title  = "Desired vs Running Tasks"
          region = var.aws_region
          stat   = "Average"
          period = 300

          metrics = [

            [
              "ECS/ContainerInsights",
              "DesiredTaskCount",
              "ClusterName",
              aws_ecs_cluster.main.name,
              "ServiceName",
              aws_ecs_service.app.name,
              {
                label = "Desired"
              }
            ],

            [
              ".",
              "RunningTaskCount",
              ".",
              ".",
              ".",
              ".",
              {
                label = "Running"
              }
            ]
          ]
        }
      }
    ]
  })
}