class Plant < ApplicationRecord
  belongs_to :user
  has_many :plants_action
  has_many :actions, through: :plants_action
  accepts_nested_attributes_for :actions, :allow_destroy => true

  validates :name, uniqueness: true, presence: true
  validates_inclusion_of :in_the_garden?, in: [true, false]
  validates_inclusion_of :edible?, in: [true, false]
  validates_inclusion_of :annual?, in: [true, false]

  def self.show_all_ingarden(user) 
    where(user_id: user.id, in_the_garden: true )
  end

  def self.show_all_edible(user) 
    where(user_id: user.id, edible: true )
  end

  def self.show_all_annual(user)
    where(user_id: user.id, annual: true )
  end

  def actions_attributes=(action_attributes)
    action_attributes.values.each do |action_attribute|
      if action_attribute[:action_name].present?
        action = Action.find_or_create_by(id: action_attribute[:action_name])
        self.actions << action
      end
    end
  end

end
