Given 'a remote scope named {string} should not exist' do |scope|
  expect(@remote_scopes).not_to include scope
end

Then 'the remote scope {string} should exist' do |scope|
  expect(@remote_scopes).to include scope
end
