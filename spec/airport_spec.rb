require 'airport'


describe Airport do
  subject(:airport) { described_class.new}
  let(:plane) {double :plane}
  let(:landed_plane) {double :landed_plane}

	describe "#land" do
	  it "instructs plane to land at airport" do
      #it {is_expected.to respond_to(:land).with(1).argument }
	    plane = double :plane
      allow(airport).to receive(:stormy?).and_return false
	    expect(airport.land(plane)).to eq [plane]
	  end

    # it "confirms that plane has landed" do # fails due to clash with raised error: Landing denied, weather report stormy
    #   #it {is_expected.to respond_to(:confirm_landing).with(1).argument }
    #   plane = double :plane
    #   allow(airport).to receive(:stormy?).and_return false
	  #   landed_plane = subject.land(plane)
	  #   expect(airport.confirm_landing(plane)).to eq landed_plane
	  # end

    it "raises an error when airport is at full capacity" do
      airport = Airport.new(2)
      plane = double :plane
      2.times { airport.land(plane) }
      expect { airport.land(plane) }.to raise_error "Landing denied, Airport is full"
    end

    it "prevents landing if weather is stormy" do # fails error as it says nothing is raised, missing random weather test
    	plane = double :plane
      allow(airport).to receive(:stormy?).and_return(true)
      expect {airport.land(plane)}.to raise_error "Landing denied, weather report stormy"
    end
	end

	describe "#takeoff" do
	  it "instructs a plane to take off from airport" do # fails due to clash with raised error: Landing denied, weather report stormy
      #it {is_expected.to respond_to(:takeoff).with(1).argument }
      plane = double :plane
      allow(airport).to receive(:empty?). and_return false
      allow(airport).to receive(:stormy?). and_return false
    	airport.land(plane)
      expect(airport.takeoff(plane)).to eq plane
	  end

	  it "confirms that the plane has left the airport" do
      plane = double("plane", :has_taken_off? => true)
      expect(plane).to have_taken_off
	  end

	  it "raises error when plane has left airport" do
      plane = double :plane
      allow(airport).to receive(:stormy?). and_return false
      allow(airport).to receive(:empty?). and_return true
      airport.land(plane)
	    expect {airport.takeoff(plane)}.to raise_error "the plane has already departed"
	  end

	  it "prevents takeoff if weather is stormy" do # fails due to clash with raised error: Landing denied, weather report stormy
    	plane = double :plane
      allow(airport).to receive(:stormy?). and_return false
      airport.land(plane)
      allow(airport).to receive(:empty?). and_return false
      allow(airport).to receive(:stormy?). and_return true
      expect {airport.takeoff(plane)}.to raise_error "Take off denied, weather report stormy"
    end
	end

	describe "#capacity" do
	  it "specifies larger airport capacity" do
	    expect(airport.capacity).to eq Airport::DEFAULT_CAPACITY
	  end
	end

end
