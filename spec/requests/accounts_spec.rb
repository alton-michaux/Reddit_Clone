# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Accounts', type: :request do
  subject { FactoryBot.create(:account) }

  describe 'if account not signed in' do
    it 'renders the sign in view' do
      subject
      get new_account_session_path
      expect(response).to render_template(:new)
    end
    it 'renders the sign up view' do
      account_attributes = FactoryBot.attributes_for(:account)
      get new_account_registration_path, params: { account: account_attributes }
      expect(response).to render_template(:new)
    end
  end

  context 'if account signed in' do
    describe 'get root_path' do
      it 'renders the homepage view' do
        sign_in subject
        get root_path
        expect(response).to render_template('layouts/application')
        sign_out subject
      end
      it 'redirects to the new_account_session path if the account is invalid' do
        sign_in subject
        get account_session_path(id: 5000)
        expect(response).to redirect_to root_path
        sign_out subject
      end
    end
    describe 'get edit_path' do
      it 'renders the edit view' do
        sign_in subject
        get edit_account_registration_path
        expect(response).to render_template('devise/registrations/edit')
        sign_out subject
      end
    end
  end
end
