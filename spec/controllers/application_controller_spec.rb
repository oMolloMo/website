# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ApplicationController do
  describe '#after_sign_in_path_for' do
    context 'user is an admin' do
      it 'sends the user to admin_events_path' do
        admin = build_stubbed :user, :admin
        allow(controller).to receive(:current_user).and_return admin
        expect(controller.after_sign_in_path_for(admin)).to eq admin_events_path
      end
    end

    context 'user is not an admin' do
      it 'sends the user to the events path' do
        user = build_stubbed :user
        allow(controller).to receive(:current_user).and_return user
        expect(controller.after_sign_in_path_for(user)).to eq events_en_path
      end

      context 'locale is in french' do
        it 'sends the user to the french events page' do
          I18n.locale = :fr
          user = build_stubbed :user
          allow(controller).to receive(:current_user).and_return user
          expect(controller.after_sign_in_path_for(user)).to eq events_fr_path
        end
      end
    end
  end
end
