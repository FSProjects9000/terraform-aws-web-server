resource "aws_ssm_patch_baseline" "production" {
  name             = "patch-baseline"
  operating_system = "UBUNTU"

  approval_rule {
    approve_after_days = 3
    compliance_level   = "HIGH"

    patch_filter {
      key    = "PRODUCT"
      values = ["Ubuntu25.04"]
    }
  }
}


resource "aws_ssm_maintenance_window" "production" {
  name     = "maintenance-window-application"
  schedule = "cron(0 4 * * ? *)"
  duration = 3
  cutoff   = 1
}

resource "aws_ssm_maintenance_window_target" "webserver" {
  window_id     = aws_ssm_maintenance_window.production.id
  name          = "maintenance-window-target"
  description   = "This is a maintenance window target"
  resource_type = "INSTANCE"

  targets {
    key    = "InstanceIds"
    values = [aws_instance.webserver.id]
  }
}

resource "aws_ssm_maintenance_window_task" "patching" {
  max_concurrency  = 2
  max_errors       = 1
  priority         = 1
  task_arn         = "AWS-RunPatchBaseline"
  task_type        = "RUN_COMMAND"
  window_id        = aws_ssm_maintenance_window.production.id
  service_role_arn = aws_iam_role.ssm_maintenance_window.arn


  targets {
    key    = "WindowTargetIds"
    values = [aws_ssm_maintenance_window_target.webserver.id]
  }

  task_invocation_parameters {
    run_command_parameters {
      parameter {
        name   = "Operation"
        values = ["Install"]
      }
    }
  }

}

