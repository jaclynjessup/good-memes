require "rails_helper"

feature "user visits meme category page" do
  scenario "user visits category page" do
    evil_kermit = FactoryGirl.create(:category, image_url: "kermit.com")
    coffee_kermit = FactoryGirl.create(:category, name: "Coffee Kermit", image_url: "kermit.com")

    visit category_path(evil_kermit)

    expect(page).to have_content "Evil Kermit"
    expect(page).to have_xpath("//img[contains(@src,'kermit.com')]")
  end
   scenario "user sees individual memes" do
    bob = FactoryGirl.create(:user)
    evil_kermit = FactoryGirl.create(:category, image_url: "kermit.com")
    evil_kermit1 = FactoryGirl.create(:meme, name: "Evil Kermit 1", img_url: "kermit.com/1", category: evil_kermit, user: bob)

    sign_in bob

    visit category_path(evil_kermit)

    expect(page).to have_xpath("//img[contains(@src,'kermit.com/1')]")

  end
end
