require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.
  
  describe "index" do
    it "responds with success when there are many drivers saved" do
      # Arrange
      Driver.create name: "Meatball Jones", vin: 41225, active: true, car_make: "Honda", car_model: "Accord"
      Driver.create name: "Number One Benitez", vin: 53246, active: false, car_make: "Toyota", car_model: "Tacoma"
      Driver.create name: "Fred Boutros", vin: 32960, active: true, car_make: "Volkswagen", car_model: "Eurovan"
      # Act
      get drivers_path
      # Assert
      must_respond_with :success
    end
    
    it "responds with success when there are no drivers saved" do
      # Arrange
      # Ensure that there are zero drivers saved
      
      @fred = Driver.create name: "Fred Boutros", vin: 32960, active: true, car_make: "Volkswagen", car_model: "Eurovan"
      delete driver_path(@fred.id)
      # Act
      get drivers_path
      # Assert
      must_respond_with :success
    end
  end
  
  describe "show" do
    it "responds with success when showing an existing valid driver" do
      # Arrange
      @mb = Driver.create name: "Meatball Jones", vin: 41225, active: true, car_make: "Honda", car_model: "Accord"
      # Ensure that there is a driver saved
      if Driver.count != 1
        puts 'No driver saved'
      end
      # Act
      get driver_path(@mb.id)
      # Assert
      must_respond_with :success
    end
    
    it "responds with 404 with an invalid driver id" do
      # Arrange
      
      # Ensure that there is an id that points to no driver
      
      # Act
      get driver_path(99999)
      # Assert
      must_respond_with 404
    end
  end
  
  describe "new" do
    it "responds with success" do
      get new_driver_path
      must_respond_with :success
    end
  end
  
  describe "create" do
    it "can create a new driver with valid information accurately, and redirect" do
      # Arrange
      # Set up the form data
      driver_hash = {
        driver: {
          name: "Number One Benitez",
          vin: "53246",
          active: false,
          car_make: "Toyota",
          car_model: "Tacoma"
        }
      }
      # Act-Assert
      expect {
        post drivers_path, params: driver_hash
      }.must_change "Driver.count", 1
      # Ensure that there is a change of 1 in Driver.count
      # Assert
      number_one = Driver.find_by(name: driver_hash[:driver][:name])
      expect(number_one.vin).must_equal driver_hash[:driver][:vin]
      expect(number_one.active).must_equal driver_hash[:driver][:active]
      expect(number_one.car_make).must_equal driver_hash[:driver][:car_make]
      expect(number_one.car_model).must_equal driver_hash[:driver][:car_model]
      must_respond_with :redirect
      must_redirect_to driver_path(number_one.id)
      # Find the newly created Driver, and check that all its attributes match what was given in the form data
      # Check that the controller redirected the user
    end
    
    it "does not create a driver if the form data violates Driver validations" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Note: I deleted that it should redirect because if the validation kicks in, it just stays on the page and waits for valid input
      # Arrange
      driver_hash = {
        driver: {
          vin: "53246",
          active: false,
          car_make: "Toyota",
          car_model: "Tacoma"
        }
      }
      # Set up the form data so that it violates Driver validations
      expect {
        post drivers_path, params: driver_hash
      }.wont_change Driver.count
      
      
    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      # Arrange
      #
      # # Ensure there is an existing driver saved
      #
      get driver_path(5)
      must_respond_with :success
      # Act
      expect {
        patch driver_path(mb.id), params: @driver_hash_with_new_data
      }.wont_change "Driver.count"
      must_respond_with :success
      # Assert
      
    end
    
    it "responds with redirect when getting the edit page for a non-existing driver" do
      
      get driver_path(9999), params: @driver_hash_with_new_data
      must_respond_with :redirect
    end
  end
  
  describe "update" do
    it "can update an existing driver with valid information accurately, and redirect" do
      # Arrange
      mb = Driver.create name: "Meatball Jones", vin: 41225, active: true, car_make: "Honda", car_model: "Accord"
      # driver_hash_with_new_data = {
      
      # Ensure there is an existing driver saved
      # if Driver.count != 1
      #   puts "driver not saved"
      # end
      # Assign the existing driver's id to a local variable
      # Set up the form data
      expect {patch driver_path(mb.id), params: @driver_hash_with_new_data}.wont_change Driver.count
      expect(mb.name).must_equal @driver_hash_with_new_data[:driver][:name]
      expect(@mb.vin).must_equal @driver_hash_with_new_data[:driver][:vin]
      expect(mb.active).must_equal @driver_hash_with_new_data[:driver][:active]
      expect(mb.car_make).must_equal @driver_hash_with_new_data[:driver][:car_make]
      expect(mb.car_model).must_equal @driver_hash_with_new_data[:driver][:car_model]
      must_respond_with :redirect
    end
  end
  
  it "does not update any driver if given an invalid id, and responds with a 404" do
    # Arrange
    # Ensure there is an invalid id that points to no driver
    # Set up the form data
    # #bad_book = Book.new (valid data)
    # bad_book.title = ""
    # save expect false/failure
    # bad_book.title = "valid"
    # bad_book.desc "aaaa"
    # save expect false/failure
    #switch valid to invalid. test c
    # Act-Assert
    # Ensure that there is no change in Driver.count
    
    # Assert
    # Check that the controller gave back a 404
    
  end
  
  it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
    # Note: This will not pass until ActiveRecord Validations lesson
    # Arrange
    # Ensure there is an existing driver saved
    # Assign the existing driver's id to a local variable
    # Set up the form data so that it violates Driver validations
    
    # Act-Assert
    # Ensure that there is no change in Driver.count
    
    # Assert
    # Check that the controller redirects
    
  end
  
  
  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      # Arrange
      # Ensure there is an existing driver saved
      
      # Act-Assert
      # Ensure that there is a change of -1 in Driver.count
      
      # Assert
      # Check that the controller redirects
      
    end
    
    it "does not change the db when the driver does not exist, then responds with " do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      
      # Act-Assert
      # Ensure that there is no change in Driver.count
      
      # Assert
      # Check that the controller responds or redirects with whatever your group decides
      
    end
  end
end
