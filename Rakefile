require 'fileutils'

STAGES = %w[line_coverage branch_coverage path_coverage condition_coverage].freeze

def stage_test_file(stage)
  File.join(stage, 'application_fund_review_test.rb')
end

def ruby_command_for(stage)
  ['ruby', stage_test_file(stage)].join(' ')
end

def write_coverage_index
  FileUtils.rm_r('docs') if Dir.exist?('coverage')
  FileUtils.mkdir_p('docs')

  links = STAGES.map do |stage|
    "<li><a href=\"#{stage}/index.html\">#{stage}</a></li>"
  end.join("\n")

  File.write(
    File.join('docs', 'index.html'),
    <<~HTML
      <!DOCTYPE html>
      <html lang="en">
      <head>
        <meta charset="UTF-8">
        <title>Coverage Reports</title>
      </head>
      <body>
        <h1>Coverage Reports</h1>
        <ul>
          #{links}
        </ul>
      </body>
      </html>
    HTML
  )
end

namespace :coverage do
  desc 'Generate the top-level coverage index'
  task :index do
    write_coverage_index
  end
end

STAGES.each do |stage|
  desc "Run #{stage} stage tests"
  task stage.to_sym do
    sh ruby_command_for(stage)
  end
end

task line: :line_coverage
task branch: :branch_coverage
task condition: :condition_coverage
task path: :path_coverage

desc 'Run all coverage stages and rebuild the coverage index'
task all: ['coverage:index', *STAGES]

task default: :all
