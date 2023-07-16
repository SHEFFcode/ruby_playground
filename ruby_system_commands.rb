# There are 2 ways to issue ruby system commands: backticks (``) and system() method
# Backticks will run a system command and return its output
# By system commands we mean things like `date` which will print date in the terminal
# But also things like `ls` or `grep`
# p `ls` # "array_playground.rb\ncallable_runnable_objects.rb\ncomparable_playground.rb\ncontrol_flow.rb\ndate_time_playground.rb\nenumerable_playground.rb\nenumerator_playground.rb\nerror_handling.rb\nfile_io_playground.rb\nfile_playground.txt\nfile_write_playgournd.txt\nhash_playground.rb\nlambda_playground.rb\nmembers.txt\nmethod_objects_playground.rb\nmissing_methods.rb\nnumerical_objects.rb\nobject_individualization.rb\nobjects_methods.rb\nprivate_playground.rb\nranges.rb\nregex_playground.rb\nrock_paper_scizzors.rb\nrps_server.rb\nruby_system_commands.rb\nself_playground.rb\nset_playground.rb\nstring_playground.rb\nstrings_and_symbols.rb\nthread_locals.rb\nthreaded_chat_server.rb\nthreaded_date_server.rb\nthreads_playground.rb\n"
`date` # Sun Jul 16 11:09:36 CDT 2023
p system("date") # true
# These are usually good at capturing output of running other scripts from within ruby
# But there is another way to call other programs from ruby via open and popen3

require 'open3'
stdin, stdout, stderr = Open3.popen3('cat')
stdin.puts('hi!')
p stdout.gets # "hi!\n"

