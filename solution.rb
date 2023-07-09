# Please copy/paste all three classes into this file to submit your solution!
class Author
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def articles
    Article.all.select { |article| article.author == self }
  end

  def magazines
    articles.map { |article| article.magazine }.uniq
  end

  def add_article(magazine, title)
    Article.new(self, magazine, title)
  end

  def topic_areas
    magazines.map { |magazine| magazine.category }.uniq
  end
end

class Magazine
  attr_accessor :name, :category

  @@all = []

  def initialize(name, category)
    @name = name
    @category = category
    @@all << self
  end

  def self.all
    @@all
  end

  def self.find_by_name(name)
    @@all.find { |magazine| magazine.name == name }
  end

  def article_titles
    Article.all.select { |article| article.magazine == self }.map { |article| article.title }
  end

  def contributors #used each here instead of map
    Article.all.select { |article| article.magazine == self }.each { |article| article.author }.uniq
  end
end

class Article
  attr_reader :author, :magazine, :title

  @@all = []

  def initialize(author, magazine, title)
    @author = author
    @magazine = magazine
    @title = title
    @@all << self
  end

  def self.all
    @@all
  end
end


## testing the methods
author1 = Author.new("Reagan Munene")
author2 = Author.new("Rachael Makena")

magazine1 = Magazine.new("Standard", "News")
magazine2 = Magazine.new("Nairobian", "Gossip")

author1.add_article(magazine1, "Hiked fuel  prices")
author1.add_article(magazine2, "Natalie Tewa gets married hehe")
author2.add_article(magazine2, "Sonko doesn't know how to dress!")

puts author1.name
puts magazine2.category

puts author1.articles.inspect
puts magazine2.contributors.inspect
puts magazine1.article_titles.inspect
