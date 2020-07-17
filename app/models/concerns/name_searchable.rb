module NameSearchable
  extend ActiveSupport::Concern

  included do
    acts_as_taggable_on :search_terms
    before_save :setup_search_terms, if: :will_save_change_to_name?
  end

  class_methods do
    def search(terms)
      existed_tag_ids = ActsAsTaggableOn::Tag.where(name: terms.split(',').map(&:downcase)).pluck(:id)
      taggings = ActsAsTaggableOn::Tagging.where(taggable_type: name, tag_id: existed_tag_ids).group(:taggable_id).order('count(tag_id) desc').count(:tag_id)
      where(id: taggings.keys).sort_by {|r| taggings.keys.index(r.id)}
    end
  end

  private

  def setup_search_terms
    self.search_term_list = ActsAsTaggableOn::TagList.new
    name.gsub(/[^\w\s]/, ' ').split(' ').each do |term|
      self.search_term_list.add(term) if term.size > 1
    end
  end
end
