task :default => [:export_serve, :compile_sass]

task :export_serve do
  `serve export _app .`
end

task :compile_sass do
  `sass stylesheets/application.scss stylesheets/application.css`
  `rm stylesheets/application.scss`
end