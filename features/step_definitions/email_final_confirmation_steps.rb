Given(/^I am an organiser of an event$/) do
  user = User.create!(email:"nico@test.com", password:"12345678", password_confirmation:"12345678")
  user2 = User.create!(email:"robin@test.com", password:"12345678", password_confirmation:"12345678")
  user3 = User.create!(email:"apo@test.com", password:"12345678", password_confirmation:"12345678")
  @event = Event.new(title:"Stag Party", deadline: DateTime.now + 2, organiser_id: user.id)
  @event.users << [user2, user3]
  @event.save!
end

When(/^all the debts have been paid$/) do
  @event.debts.each do |debt|
    debt.update(paid: true)
  end
end

Then(/^I want to receive an email with the content "(.*?)"$/) do |arg1|
  ConfirmationMailer.celebration(@event).deliver!
  open_email('nico@test.com')
  expect(current_email).to have_content(arg1)
  open_email('robin@test.com')
  expect(current_email).to eq nil
end
