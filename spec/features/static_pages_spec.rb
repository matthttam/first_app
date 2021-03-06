require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_content('Sample App') }
    it { should have_title(full_title('')) }
    it { should_not have_title('| Home') }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
        visit root_path
      end
      it "should pluralize micropost count" do
        expect(page).to have_selector( 'span', :text=> "0 microposts")
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        visit root_path
        expect(page).to_not have_selector( 'span', :text=> "1 microposts")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        visit root_path
        expect(page).to have_selector( 'span', :text=> "2 microposts")
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end

      describe "pagination" do
        before do
          31.times {FactoryGirl.create(:micropost, user: user) }
          visit user_path(user)
        end

        it {should have_selector('div.pagination') }


        it "should list each micropost" do
          Micropost.paginate(page: 1).each do |micropost|
            expect(page).to have_selector('li', text: micropost.content)
          end
        end
      end

    end
  end

  describe "Help page" do
    before { visit help_path }

    it { should have_content('Help') }
    it { should have_title(full_title('Help')) }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_content('About') }
    it { should have_title(full_title('About Us')) }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_content('Contact') }
    it { should have_title(full_title('Contact')) }
  end
end