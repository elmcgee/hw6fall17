
describe Movie do
  describe 'searching Tmdb by keyword' do
    context 'with valid key' do
      it 'should call Tmdb with title keywords' do
        expect( Tmdb::Movie).to receive(:find).with('Inception')
        Movie.find_in_tmdb('Inception')
      end
    end
    context 'with invalid key' do
      it 'should raise InvalidKeyError if key is missing or invalid' do
        allow(Tmdb::Movie).to receive(:find).and_raise(Tmdb::InvalidApiKeyError)
        expect {Movie.find_in_tmdb('Inception') }.to raise_error(Movie::InvalidKeyError)
      end
    end
  end

  describe 'searching Tmdb by keyword for create_from_tmdb' do
    context 'with valid API key' do
      it 'should call tmdb with details keywords' do
        expect(Tmdb::Movie).to receive(:find).with('Pokemon')
        Movie.create_from_tmdb('Pokemon')
      end
    end
    context 'with invalid API key' do
      it 'should raise API InvalidKeyError if key is missing or invalid' do
        allow(Tmdb::Movie).to receive(:find).and_raise(Tmdb::IvalidApiKeyError)
        expect{Movie.create_from_tmdb('Pokemon')}.to raise_error(Movie::InvalidKeyError)
      end
    end
  end
end
  
