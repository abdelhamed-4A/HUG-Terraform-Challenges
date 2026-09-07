data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name != "" ? var.key_name : null

  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y nginx
              systemctl start nginx
              systemctl enable nginx

              cat <<HTML > /usr/share/nginx/html/index.html
              <!DOCTYPE html>
              <html>
              <head>
                <meta charset="utf-8">
                <title>${var.project_name} - Week 3</title>
                <style>
                  body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; text-align: center; margin-top: 8%; background-color: #0f172a; color: #f8fafc; }
                  .card { background: #1e293b; display: inline-block; padding: 2.5rem 3.5rem; border-radius: 12px; box-shadow: 0 8px 16px rgba(0,0,0,0.4); border: 1px solid #334155; }
                  h1 { color: #38bdf8; margin-bottom: 0.25rem; font-size: 1.8rem; }
                  h2 { color: #94a3b8; font-weight: 400; font-size: 1.2rem; }
                  .badge { display: inline-block; background: #0284c7; color: white; padding: 0.35rem 0.85rem; border-radius: 9999px; font-size: 0.85rem; margin-top: 1rem; font-weight: 600; }
                  .details { margin-top: 1.5rem; text-align: left; background: #0f172a; padding: 1rem; border-radius: 8px; font-family: monospace; font-size: 0.85rem; color: #e2e8f0; line-height: 1.8; }
                </style>
              </head>
              <body>
                <div class="card">
                  <h1>HUG 30 Days Terraform Challenge</h1>
                  <h2>Week 3 — Two-Tier Application Architecture</h2>
                  <div class="badge">${var.full_name}</div>
                  <div class="details">
                    <div><strong>Tier 1:</strong> Public Compute (EC2 + Nginx)</div>
                    <div><strong>Tier 2:</strong> Private Database (Amazon RDS PostgreSQL)</div>
                    <div><strong>RDS Endpoint:</strong> ${var.db_endpoint}</div>
                  </div>
                </div>
              </body>
              </html>
              HTML
              EOF

  tags = merge(var.tags, { Name = "${var.project_name}-${var.environment}-web-instance" })
}
