guard 'rspec', :version => 2 do
  watch(%r{^spec/.+_spec\.rb})
  watch('spec/spec_helper.rb')         { "spec" }
  watch('application.rb')              { "spec" }
  watch(%r{^app/middlewares/(.+)\.rb}) { |m| ["spec/app/controllers", "spec/app/middlewares/#{m[1]}_spec.rb"] }
  watch(%r{^app/controllers/(.+)\.rb}) { |m| "spec/app/controllers/#{m[1]}_spec.rb" }
  watch(%r{^app/models/(.+)\.rb})      { |m| "spec/app/models/#{m[1]}_spec.rb" }
end