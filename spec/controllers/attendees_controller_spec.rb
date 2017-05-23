# frozen_string_literal: true
require 'rails_helper'

RSpec.describe AttendeesController, type: :controller do
  let(:event_a) { create(:event, name: 'name', start_at: '2015-04-11 09:27:00', end_at: '2015-04-13 09:27:00') }
  let(:attendee_a) { create(:attendee, event_id: event_a.id) }

  before(:each) do
    @attendee_params = { serial: '001', code: 'A01', name: 'Bob', email: 'a@a', phone: '0919905295', card_serial: 'aa' }
    @user = User.create(email: Faker::Internet.free_email, password: 'password')
    sign_in @user
    event_a.staffs << @user
  end

  it '#index' do
    get :index, params: { event_id: event_a[:id] }
    expect(response).to render_template(:index)
  end

  it '#edit' do
    get :edit, params: { event_id: event_a[:id], id: attendee_a[:id] }
    expect(response).to render_template(:edit)
  end

  it '#new' do
    get :new, params: { event_id: event_a[:id] }
    expect(response).to render_template(:new)
  end

  describe '#create' do
    it 'creates record' do
      expect { post :create, params: { event_id: event_a[:id], attendee: @attendee_params } }.to change { Attendee.all.size }.by(1)
    end

    it 'redirect on success' do
      post :create, params: { event_id: event_a[:id], attendee: @attendee_params }
      expect(response).to redirect_to(event_attendees_path)
    end

    it 'render :new on fail' do
      allow_any_instance_of(Attendee).to receive(:save).and_return(false)
      post :create, params: { event_id: event_a[:id], attendee: @attendee_params }
      expect(response).to render_template(:new)
    end
  end

  describe '#update' do
    it 'changes record' do
      post :update, params: { event_id: event_a[:id], id: attendee_a[:id], attendee: @attendee_params }
      expect(Attendee.find(attendee_a[:id])[:code]).to eq('A01')
    end

    it 'redirect on success' do
      post :update, params: { event_id: event_a[:id], id: attendee_a[:id], attendee: @attendee_params }
      expect(response).to redirect_to(event_attendees_path)
    end

    it 'render :edit on fail' do
      allow_any_instance_of(Attendee).to receive(:save).and_return(false)
      post :update, params: { event_id: event_a[:id], id: attendee_a[:id], attendee: @attendee_params }
      expect(response).to render_template(:edit)
    end
  end

  describe '#destroy' do
    it 'destroy record' do
      attendee_a
      expect { delete :destroy, params: { event_id: event_a[:id], id: attendee_a[:id], attendee: attendee_a } }.to change { Attendee.count }.by(-1)
    end

    it 'redirect_to index after destroy' do
      delete :destroy, params: { event_id: event_a[:id], id: attendee_a[:id], attendee: attendee_a }
      expect(response).to redirect_to(event_attendees_path)
    end
  end

  shared_examples 'http_status test' do
    it '#index' do
      get :index, params: { event_id: event_a[:id] }
      expect(response).to have_http_status(200)
    end

    it '#edit' do
      get :edit, params: { event_id: event_a[:id], id: attendee_a[:id] }
      expect(response).to have_http_status(200)
    end

    it '#new' do
      get :new, params: { event_id: event_a[:id] }
      expect(response).to have_http_status(200)
    end

    describe '#create' do
      it 'redirect on success' do
        post :create, params: { event_id: event_a[:id], attendee: @attendee_params }
        expect(response).not_to have_http_status(200)
        expect(response).to have_http_status(302)
      end

      it 'render :new on fail' do
        allow_any_instance_of(Attendee).to receive(:save).and_return(false)
        post :create, params: { event_id: event_a[:id], attendee: @attendee_params }
        expect(response).not_to have_http_status(302)
      end
    end

    describe '#update' do
      it 'redirect on success' do
        post :update, params: { event_id: event_a[:id], id: attendee_a[:id], attendee: @attendee_params }
        expect(response).not_to have_http_status(200)
        expect(response).to have_http_status(302)
      end

      it 'render :edit on fail' do
        allow_any_instance_of(Attendee).to receive(:save).and_return(false)
        post :update, params: { event_id: event_a[:id], id: attendee_a[:id], attendee: @attendee_params }
        expect(response).not_to have_http_status(302)
      end
    end

    it 'redirect_to index after destroy' do
      delete :destroy, params: { event_id: event_a[:id], id: attendee_a[:id] }
      expect(response).to have_http_status(302)
    end
  end

  it_behaves_like 'http_status test' do
  end
end
