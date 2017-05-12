# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CheckPointsController, type: :controller do
  let(:event_a) { create(:event, name: 'name', start_at: '2015-04-11 09:27:00', end_at: '2030-04-13 09:27:00') }
  let(:machine_a) { create(:machine, name: 'name', serial: '1') }
  let(:check_point_a) { create(:check_point, event_id: event_a.id) }
  before(:each) do
    @check_point_params = { name: 'A', machine_id: machine_a.id, type: 'registrar' }
    @user = User.create(email: Faker::Internet.free_email, password: 'password')
    sign_in @user
    event_a.staffs << @user
  end

  it '#index' do
    get :index, params: { event_id: event_a[:id] }
    expect(response).to have_http_status(200)
    expect(response).to render_template(:index)
  end

  it '#edit' do
    get :edit, params: { event_id: event_a[:id], id: check_point_a[:id] }
    expect(response).to have_http_status(200)
    expect(response).to render_template(:edit)
  end

  it '#new' do
    get :new, params: { event_id: event_a[:id] }
    expect(response).to have_http_status(200)
    expect(response).to render_template(:new)
  end

  describe '#create' do
    it 'creates record' do
      # allow_any_instance_of(CheckPoint).to receive(:save).and_return(true)
      expect { post :create, params: { event_id: event_a[:id], check_point: @check_point_params } }.to change { CheckPoint.count }.by(1)
    end

    it 'redirect on success' do
      # allow_any_instance_of(CheckPoint).to receive(:save).and_return(true)
      post :create, params: { event_id: event_a[:id], check_point: @check_point_params }
      expect(response).not_to have_http_status(200)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(event_check_points_path)
    end

    it 'render :new on fail' do
      allow_any_instance_of(CheckPoint).to receive(:save).and_return(false)
      post :create, params: { event_id: event_a[:id], check_point: @check_point_params }
      expect(response).not_to have_http_status(302)
      expect(response).to render_template(:new)
    end
  end

  describe '#update' do
    it 'changes record' do
      post :update, params: { event_id: event_a[:id], id: check_point_a[:id], check_point: @check_point_params }
      expect(CheckPoint.find(check_point_a[:id])[:name]).to eq('A')
    end

    it 'redirect on success' do
      post :update, params: { event_id: event_a[:id], id: check_point_a[:id], check_point: @check_point_params }
      expect(response).not_to have_http_status(200)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(event_check_points_path)
    end

    it 'render :edit on fail' do
      allow_any_instance_of(CheckPoint).to receive(:save).and_return(false)
      post :update, params: { event_id: event_a[:id], id: check_point_a[:id], check_point: @check_point_params }
      expect(response).not_to have_http_status(302)
      expect(response).to render_template(:edit)
    end
  end

  describe '#destroy' do
    it 'destroy record' do
      check_point_a
      expect { delete :destroy, params: { event_id: event_a[:id], id: check_point_a[:id], check_point: check_point_a } }.to change { CheckPoint.count }.by(-1)
    end

    it 'redirect_to index after destroy' do
      delete :destroy, params: { event_id: event_a[:id], id: check_point_a[:id], check_point: check_point_a }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(event_check_points_path)
    end
  end
end
