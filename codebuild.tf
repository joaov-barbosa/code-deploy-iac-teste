resource "aws_codedeploy_app" "app" {
  name             = "codedeploy-app"
  compute_platform = "Server"
}

resource "aws_codedeploy_deployment_group" "app_group" {
  app_name              = aws_codedeploy_app.app.name
  deployment_group_name = "codedeploy-deploy-group"
  service_role_arn      = aws_iam_role.codedeploy_role.arn

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  blue_green_deployment_config {
    terminate_blue_instances_on_deployment_success {
      action = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }

    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
      wait_time_in_minutes = 0
    }
  }

  autoscaling_groups = [aws_autoscaling_group.app_asg.name]

  load_balancer_info {
    target_group_pair_info {
      target_group {
        name = aws_lb_target_group.tg_blue.name
      }

      target_group{
        name = aws_lb_target_group.tg_green.name
      }

      prod_traffic_route {
        listener_arns = [aws_lb_listener.http.arn]
      }
    }
  }
}
