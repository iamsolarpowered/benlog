xml.instruct! :xml, :version => '1.0'
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "iamsolarpowered :: Ben Shymkiw"
    xml.description Ben.bio
    xml.link "http://ben.tapiocacollective.com/"

    @updates.each do |update|
      xml.item do
        xml.title truncate("#{update.via}: #{strip_tags update.content.first}", :length => 140)
        xml.link update.url
        xml.description update.content
        xml.pubDate update.published_at.rfc822()
        xml.guid update.url
      end
    end
  end
end

