resource "aws_waf_rule" "crud-lb-waf" {
  name        = "crud-lb-waf"
  metric_name = "crudwaf"
}
resource "aws_wafv2_web_acl" "waf_crud" {
  name        = "crud-lb-waf"
  description = "WAF ACL for CRUD Application"
  scope       = "REGIONAL"
  default_action {
    block {}
  }
  rule {
    name     = "AWS-AWSManagedRulesLinuxRuleSet"
    priority = 0
    override_action {
      count {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesLinuxRuleSet"
        vendor_name = "AWS"
      }
   }
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "CRUDApp-Linux"
      sampled_requests_enabled   = false
    }
  }
  rule {
    name     = "AWS-AWSManagedRulesSQLiRuleSet"
    priority = 1
    override_action {
      count {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "CRUD_SQLI"
      sampled_requests_enabled   = false
    }
  }
  tags = {
    Name = "ALB-WAF"
  }
  visibility_config {
    metric_name                = "CRUD"
    sampled_requests_enabled   = false
    cloudwatch_metrics_enabled = false
  }
}

resource "aws_wafv2_web_acl_association" "web_acl_association_crud_lb" {
  resource_arn = aws_lb.crud-lb.arn
  web_acl_arn  = aws_wafv2_web_acl.waf_crud.arn
}

