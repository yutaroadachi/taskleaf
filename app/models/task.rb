class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validate  :validate_name_not_including_comma

  belongs_to :user

  scope :recent, -> { order(created_at: :desc) }

  def self.ransackable_attributes(auth_object = nil)
    %w[name created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  CSV_ATTRIBUTES = ["name", "description", "created_at", "updated_at"]

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << CSV_ATTRIBUTES
      Task.all.each do |task|
        csv << CSV_ATTRIBUTES.map { |attr| task.send(attr) }
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      task = new
      task.attributes = row.to_hash.slice(*CSV_ATTRIBUTES)
      task.save!
    end
  end

  private

  def validate_name_not_including_comma
    errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
  end
end
