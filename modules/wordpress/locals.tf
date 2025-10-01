locals {
  default_user_data = <<-EOF
  #!/bin/bash
  set -euo pipefail
  if command -v systemctl >/dev/null 2>&1; then
    systemctl enable apache2 || true
    systemctl restart apache2 || true
  fi
EOF

  user_data = var.custom_user_data != "" ? var.custom_user_data : local.default_user_data
}