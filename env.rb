dep 'app env vars set', :env, :username do
  requires [
    'env var set'.with(username, 'RACK_ENV', env),
    'env var set'.with(username, 'RAILS_ENV', env),
  ]
end

dep 'env var set', :username, :key, :value do
  met? {
    sudo("cat ~/.bashrc | grep \"#{key}=#{value}\" | wc -l", :as => username).to_i >= 1 && 
      sudo("cat ~/.profile | grep \"#{key}=#{value}\" | wc -l", :as => username).to_i >= 1
  }
  meet {
    sudo("echo -e \"export #{key}=#{value}\" >> ~/.profile", :as => username)
    sudo("echo -e \"export #{key}=#{value}\" >> ~/.bashrc", :as => username)
  }
end
