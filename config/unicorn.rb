root = "/var/www/todpop/web/current"
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn_error.log"
stdout_path "#{root}/log/unicorn_access.log"

listen "/tmp/unicorn.sock"
worker_processes 2
timeout 30
