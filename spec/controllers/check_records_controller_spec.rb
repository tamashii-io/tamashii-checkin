# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CheckRecordsController, type: :controller do
  let(:event) { create(:event) }
  let(:user) { create(:user) }
  it '#index' do
    sign_in user
    event.staffs << user
    get :index, params: { event_id: event[:id] }
    expect(response).to have_http_status(200)
    expect(response).to render_template(:index)
  end
end
