require 'rails_helper'

RSpec.describe Cart, type: :model do
  context "add contents to cart" do
    it "can have contents" do
      cart = Cart.new({"1" => 1})

      expect(cart.contents).to eql({"1" => 1})
    end

    it "can add tasks to cart" do
      cart = Cart.new({"1" => 1})

      cart.add_task(2)
      cart.add_task(3)

      expect(cart.contents).to eql({"1" => 1, "2" => 1, "3" => 1})
    end

    it "can return total number of all added tasks" do
      cart = Cart.new({"1" => 1})

      cart.add_task(2)
      cart.add_task(3)

      expect(cart.total).to eql(3)
    end

    it "can total hours of all tasks" do
      city = create(:city_with_tasks)
      cart = Cart.new({})
      city.tasks.each do |task|
        cart.add_task(task.id)
      end
      expect(cart.total_hours).to eql(6)
    end

    it "can remove a task from the cart" do
      city = create(:city_with_tasks)
      cart = Cart.new({})
      city.tasks.each do |task|
        cart.add_task(task.id)
      end
      expect(cart.total_hours).to eql(6)
      cart.remove_task(city.tasks.first.id)
      expect(cart.total_hours).to eql(5)
    end
  end
end
