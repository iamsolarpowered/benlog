class Ben

  def self.bio
    "Web developer, concerned citizen, member of Tapioca Design Collective."
  end

  def self.html_bio
    bio.gsub(', ', ',<br />').gsub(/(Tapioca Design Collective)/, '<a href="http://t.apio.ca">\1</a>')
  end

  def self.keywords
    'ruby,ruby on rails,sinatra,rack,tdd,bdd,rspec,cucumber,api,datamapper,google maps,jquery,ajax,css3,html5,web developer,application developer,coder,toronto,detroit,iamsolarpowered'
  end

end

