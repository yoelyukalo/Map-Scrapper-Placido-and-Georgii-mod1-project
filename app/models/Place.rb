class Place < ActiveRecord::Base
    has_many :place_tag_joiners
    has_many :tags, through: :place_tag_joiners
    has_many :pages
    has_many :matches, through: :pages
    has_many :keywords, through: :matches
    
    def relevance
        self.tags.reduce(0) {|memo, tag| tag.relevance ? memo + tag.relevance : memo}
    end

    def is_internal_link?(link)
        exceptions = ["facebook.com"]

    end


    def self.get_10_most_relevant
        Place.all.sort { |a,b|
            b.relevance <=> a.relevance
        }.first(10)
    end

    def tag_titles #returns all tag names associated with place
        self.tags.map {|tag| tag.title}
    end
end