require 'rails_helper'

shared_examples "User model" do

  describe 'validations' do
    it { should validate_presence_of(:mobile)}
    it { should have_secure_password }
    it { should have_many(:linking_user_requests) }
    it { should have_many(:ads) }
    it { should have_many(:orders) }
    it { should have_many(:stories) }
  end

  describe 'callbacks' do 
    it { is_expected.to callback(:set_confirmation_token).after(:create) }
    it { is_expected.to callback(:insert_nullify_token_job).after(:create) }
  end

  describe 'mobile number validations' do
    it "should accept phone number" do 
      user = build :user
      expect(user).to be_valid
    end

    it "should reject phone number without country code" do 
      user = build :user , mobile: "543212345"
      expect(user).to be_invalid
    end

    it "should reject phone number that unmatch the accepted format" do 
      user = build :user , mobile: "+966432112345"
      expect(user).to be_invalid
    end
  end


  context ', testing public methods:' do 
    describe '#confirmed?' do 
      it 't: will return true if user has a confirmed_at date' do 
        user = create :user, confirmed_at: DateTime.now
        expect(user.confirmed?).to be true
      end 

      it 't: will return false if user has no confirmed_at date' do 
        user = create :user, confirmed_at: nil
        expect(user.confirmed?).to be false
      end 
    end

    describe '#confirm!' do
      it 't: will set confirmed_at of user with no confired_at' do 
        user = create :user, confirmed_at: nil
        user.confirm!
        expect(user.confirmed_at).to be_present
      end

      it 't: will not change confirmed_at of user if it has one already' do 
        current = DateTime.now
        user = create :user, confirmed_at: current
        user.confirm!
        expect(user.confirmed_at.to_i).to eq(current.to_i)
      end

      it 't: will set the confirmed_at date of the user to current date' do 
        before_confirmation = DateTime.now
        user = create :user, confirmed_at: nil
        user.confirm!
        after_confirmation = DateTime.now
        expect(user.confirmed_at).to be_between(before_confirmation, after_confirmation).inclusive
      end

      it 't: user.confirmed? will be true after calling confirm!' do 
        user = create :user, confirmed_at: nil
        expect(user.confirmed?).to be false
        user.confirm!
        expect(user.confirmed?).to be true
      end

      it 't: will nullify the token after confirmation' do 
        user = create :user, confirmed_at: nil
        expect(user.confirmation_token).not_to be_nil
        user.confirm!
        expect(user.reload.confirmation_token).to be_nil
      end
    end

    describe '#set_confirmation_token' do 
      it 't: will set random code after creation' do
        user = create :user, confirmation_token: nil
        expect(user.confirmation_token).to be_present   
      end

      it 't: the confirmation token will be of length CONFIRMATION_TOKEN_LENGTH' do 
        user = create :user
        expect(user.confirmation_token.length).to eq(User::CONFIRMATION_TOKEN_LENGTH)
      end
    end 

    describe '#generate_random_number' do 
      it 't: it will generate random number in the length required' do 
        user = build :user
        array_length =  rand(2..10) 
        ## create array of length array_length, with random numbers less than 20
        random_numbers = Array.new(array_length) { rand(2..20)}
        random_numbers.each do |x|
          rand_number = user.generate_random_number(x)
          expect(rand_number.digits.size).to eq(x)
        end
      end 

      it 't: it will generate random number in the length 6 by default' do 
        user = build :user
        rand_number = user.generate_random_number
        expect(rand_number.digits.size).to eq(6)
      end 
    end

    describe '#create_uniq_random_number' do 
      it 't: will check against all already created users and give back a new one' do
        array_length =  rand(2..10) 
        users = create_list(:user, array_length)
        expect(users.map(&:confirmation_token).uniq.size).to eq(array_length)
      end 
    end

    describe '#nullify_confirmation_token!' do
      it 't: will set user confirmation_token to null' do
        user = create :user
        expect(user.confirmation_token).not_to be_nil
        user.nullify_confirmation_token!
        expect(user.confirmation_token).to be_nil
      end
    end

    describe '#nullify_reset_password_otp!' do
      it 't: will set user reset_password_otp to null' do
        user = create :user
        user.set_reset_password_otp
        expect(user.reload.reset_password_otp).not_to be_nil
        NullifyResetPasswordOtpJob.perform_now(user.id)
        expect(user.reload.reset_password_otp).to be_nil
      end
    end


    describe '#insert_nullify_token_job' do 
      it 'will insert NullifyConfirmationTokenJob to nullify the token after NULLIFY_TOKEN_WAITING_TIME minuts' do 
        user = create :user
        expect {
          user.insert_nullify_token_job
        }.to have_enqueued_job.with(user.id)

        # need to search how to test the execution time 
      end

      describe '#insert_nullify_reset_password_otp_job' do 
        it 'will insert NullifyResetPasswordOtpJob to nullify the otp after NULLIFY_TOKEN_WAITING_TIME minuts' do 
          user = create :user
          user.set_reset_password_otp
          expect {
            user.insert_nullify_reset_otp_job
          }.to have_enqueued_job.with(user.id)
          end
        end
    end
  end
end
  
