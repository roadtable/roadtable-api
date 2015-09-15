require 'rails_helper'

RSpec.describe Session, type: :model do
  it 'does not save without api key' do
    Session.destroy_all
    session = Session.create
    expect(session).to be_invalid
    expect(session).to validate_presence_of(:api_key)
  end
end
