# -*- encoding : utf-8 -*-
root = "/var/www/todpop/web/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn_error.log"
stdout_path "#{root}/log/unicorn_access.log"

listen "/tmp/unicorn.sock"
worker_processes 5
timeout 30
