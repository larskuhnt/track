guard 'rspec', :version => 2 do
  watch(%r{^spec/.+_spec\.rb})
  watch(%r{^lib/track/(.+)\.rb}) { |m| "spec/lib/track/#{m[1]}_spec.rb" }
  watch('lib/track.rb')          { "spec" }
  watch('spec/spec_helper.rb')   { "spec" }
end
