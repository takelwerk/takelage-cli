Given 'a remote scope named {string} should not exist' do |scope|
  expect(@remote_scopes).not_to include scope
end

Then 'there is a remote scope named {string}' do |scope|
  expect(@remote_scopes).to include scope
end
