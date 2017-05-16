# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CheckRecordsController, type: :controller do
  let(:event) { create(:event) }
  subject { create(:user) }
  it '#index' do
    sign_in subject
    event.staffs << subject
    get :index, params: { expect: [:show], event_id: event[:id] }
    expect(response).to have_http_status(200)
    expect(response).to render_template(:index)
  end
end
