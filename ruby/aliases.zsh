# alias r='rbenv local 1.8.7-p358'
alias r='rspec'

alias sc='script/console'
alias sg='script/generate'
alias sd='script/destroy'

alias migrate='rake db:migrate db:test:clone'

alias b='bundle'
alias bi='b install --path vendor'
alias bil='bi --local'
alias bu='b update'
alias be='b exec'
alias binit="bi && b package && echo 'vendor/ruby' >> .gitignore"

alias dep='bundle exec cap deploy'

alias uni='unicorn -c config/unicorn.rb -p 3000'

alias ks='kill `cat tmp/pids/server.pid`'

alias rails='be rails'
alias rake='be rake'

alias puma='be puma -C config/puma.rb'

alias httpd='ruby -run -e httpd'

alias rru='rerun -i "*.haml" -i "*.coffee" -i "*.sass" -- bundle exec rackup -p 5000'
