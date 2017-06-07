# frozen_string_literal: true
require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:event_a) { create(:event, name: 'name', start_at: '2015-04-11 09:27:00', end_at: '2015-04-13 09:27:00') }
  let(:user) { create(:user) }

  before(:each) do
    @event_params = { name: 'update', start_at: '2015-04-14 09:27:00', end_at: '2017-04-14 09:27:00' }
    sign_in user
    event_a.user_id = user.id
    event_a.save
    event_a.staffs << user
  end

  it '#index' do
    get :index
    expect(response).to render_template(:index)
  end

  it '#show' do
    get :show, params: { id: event_a[:id] }
    expect(response).to render_template(:show)
  end

  it '#edit' do
    get :edit, params: { id: event_a[:id] }
    expect(response).to render_template(:edit)
  end

  it '#new' do
    get :new
    expect(response).to render_template(:new)
  end

  describe '#create' do
    it 'creates record' do
      expect { post :create, params: { event: @event_params } }.to change { Event.count }.by(1)
    end

    it 'redirect on success' do
      post :create, params: { event: @event_params }
      expect(response).to redirect_to(events_path)
    end

    it 'render :new on fail' do
      allow_any_instance_of(Event).to receive(:save).and_return(false)
      post :create, params: { event: @event_params }
      expect(response).to render_template(:new)
    end
  end

  describe '#update' do
    it 'changes record' do
      post :update, params: { id: event_a[:id], event: @event_params }
      expect(Event.find(event_a[:id])[:name]).to eq('update')
    end

    it 'redirect on success' do
      post :update, params: { id: event_a[:id], event: @event_params }
      expect(response).to redirect_to(events_path)
    end

    it 'render :edit on fail' do
      allow_any_instance_of(Event).to receive(:save).and_return(false)
      post :update, params: { id: event_a[:id], event: @event_params }
      expect(response).to render_template(:edit)
    end
  end
  # TODO: pundit spec
  describe '#destroy' do
    xit 'destroy record' do
      expect { delete :destroy, params: { id: event_a[:id], event: event_a } }.to change { Event.count }.by(-1)
    end

    xit 'redirect_to index after destroy' do
      delete :destroy, params: { id: event_a[:id] }
      expect(response).to redirect_to(events_path)
    end
  end

  shared_examples 'http_status test' do
    it '#index' do
      get :index
      expect(response).to have_http_status(200)
    end

    it '#show' do
      get :show, params: { id: event_a[:id] }
      expect(response).to have_http_status(200)
    end

    it '#edit' do
      get :edit, params: { id: event_a[:id] }
      expect(response).to have_http_status(200)
    end

    it '#new' do
      get :new
      expect(response).to have_http_status(200)
    end

    describe '#create' do
      it 'redirect on success' do
        post :create, params: { event: @event_params }
        expect(response).not_to have_http_status(200)
        expect(response).to have_http_status(302)
      end

      it 'render :new on fail' do
        allow_any_instance_of(Event).to receive(:save).and_return(false)
        post :create, params: { event: @event_params }
        expect(response).not_to have_http_status(302)
      end
    end

    describe '#update' do
      it 'redirect on success' do
        post :update, params: { id: event_a[:id], event: @event_params }
        expect(response).not_to have_http_status(200)
        expect(response).to have_http_status(302)
      end

      it 'render :edit on fail' do
        allow_any_instance_of(Event).to receive(:save).and_return(false)
        post :update, params: { id: event_a[:id], event: @event_params }
        expect(response).not_to have_http_status(302)
      end
    end

    # TODO: pundit spec
    xit 'redirect_to index after destroy' do
      delete :destroy, params: { id: event_a[:id] }
      expect(response).to have_http_status(302)
    end
  end

  it_behaves_like 'http_status test' do
  end
end
