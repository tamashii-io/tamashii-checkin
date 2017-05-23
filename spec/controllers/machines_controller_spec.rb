# frozen_string_literal: true
require 'rails_helper'

RSpec.describe MachinesController, type: :controller do
  let(:machine_a) { create(:machine, name: 'name', serial: '1') }

  before(:each) do
    @machine_params = { name: 'update' }
    @user = User.create(email: Faker::Internet.free_email, password: 'password')
    sign_in @user
  end

  it '#index' do
    allow(Tamashii::Machine).to receive(:activities).and_return({})
    get :index
    expect(response).to render_template(:index)
  end

  it '#edit' do
    get :edit, params: { id: machine_a[:id] }
    expect(response).to render_template(:edit)
  end

  it '#new' do
    get :new
    expect(response).to render_template(:new)
  end

  describe '#create' do
    it 'creates record' do
      expect { post :create, params: { machine: @machine_params } }.to change { Machine.count }.by(1)
    end

    it 'redirect on success' do
      post :create, params: { machine: @machine_params }
      expect(response).to redirect_to(machines_path)
    end

    it 'render :new on fail' do
      allow_any_instance_of(Machine).to receive(:save).and_return(false)
      post :create, params: { machine: @machine_params }
      expect(response).to render_template(:new)
    end
  end

  describe '#update' do
    it 'changes record' do
      post :update, params: { id: machine_a[:id], machine: @machine_params }
      expect(Machine.find(machine_a[:id])[:name]).to eq('update')
    end

    it 'redirect on success' do
      post :update, params: { id: machine_a[:id], machine: @machine_params }
      expect(response).to redirect_to(machines_path)
    end

    it 'render :edit on fail' do
      allow_any_instance_of(Machine).to receive(:save).and_return(false)
      post :update, params: { id: machine_a[:id], machine: @machine_params }
      expect(response).to render_template(:edit)
    end
  end

  describe '#destroy' do
    it 'destroy record' do
      machine_a
      expect { delete :destroy, params: { id: machine_a[:id], machine: machine_a } }.to change { Machine.count }.by(-1)
    end

    it 'redirect_to index after destroy' do
      delete :destroy, params: { id: machine_a[:id] }
      expect(response).to redirect_to(machines_path)
    end
  end

  shared_examples 'http_status test' do
    it '#index' do
      get :index
      expect(response).to have_http_status(200)
    end

    it '#edit' do
      get :edit, params: { id: machine_a[:id] }
      expect(response).to have_http_status(200)
    end

    it '#new' do
      get :new
      expect(response).to have_http_status(200)
    end

    describe '#create' do
      it 'redirect on success' do
        post :create, params: { machine: @machine_params }
        expect(response).not_to have_http_status(200)
        expect(response).to have_http_status(302)
      end

      it 'render :new on fail' do
        allow_any_instance_of(Machine).to receive(:save).and_return(false)
        post :create, params: { machine: @machine_params }
        expect(response).not_to have_http_status(302)
      end
    end

    describe '#update' do
      it 'redirect on success' do
        post :update, params: { id: machine_a[:id], machine: @machine_params }
        expect(response).not_to have_http_status(200)
        expect(response).to have_http_status(302)
      end

      it 'render :edit on fail' do
        allow_any_instance_of(Machine).to receive(:save).and_return(false)
        post :update, params: { id: machine_a[:id], machine: @machine_params }
        expect(response).not_to have_http_status(302)
      end
    end

    it 'redirect_to index after destroy' do
      delete :destroy, params: { id: machine_a[:id] }
      expect(response).to have_http_status(302)
    end
  end

  it_behaves_like 'http_status test' do
  end
end
