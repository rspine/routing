require 'spine/routing'

module Spine
  module Routing
    describe Router do
      let(:handler) { double }

      it 'has routes' do
        expect(subject.routes).to be
      end

      it 'adds route by get verb' do
        subject.get('/', to: handler)
        expect(subject.routes.size).to eql(1)
        expect(subject.routes.first.verb).to eql(:get)
      end

      it 'adds route by post verb' do
        subject.post('/', to: handler)
        expect(subject.routes.size).to eql(1)
        expect(subject.routes.first.verb).to eql(:post)
      end

      it 'adds route by put verb' do
        subject.put('/', to: handler)
        expect(subject.routes.size).to eql(1)
        expect(subject.routes.first.verb).to eql(:put)
      end

      it 'adds route by patch verb' do
        subject.patch('/', to: handler)
        expect(subject.routes.size).to eql(1)
        expect(subject.routes.first.verb).to eql(:patch)
      end

      it 'adds route by delete verb' do
        subject.delete('/', to: handler)
        expect(subject.routes.size).to eql(1)
        expect(subject.routes.first.verb).to eql(:delete)
      end

      it 'adds route in scope' do
        handler = double
        subject.scope('level-1') do
          get('test', to: handler)
        end
        expect(subject.routes.size).to eql(1)
        expect(subject.routes.first.pattern).to eql('/level-1/test')
      end

      it 'adds route in multiple scopes' do
        handler = double
        subject.scope('level-1') do
          scope('level-2') do
            get('test', to: handler)
          end
        end
        expect(subject.routes.size).to eql(1)
        expect(subject.routes.first.pattern).to eql('/level-1/level-2/test')
      end

      it 'parses variable from scope' do
        handler = double
        subject.scope('level-1/:level_id') do
          get('test', to: handler)
        end
        expect(subject.recognise(:get, '/level-1/1/test').parameters)
          .to eql('level_id' => '1', 'format' => nil)
      end

      it 'parses variable scope' do
        handler = double
        subject.scope(':level_id') do
          get('test', to: handler)
        end
        expect(subject.recognise(:get, '/1/test').parameters)
          .to eql('level_id' => '1', 'format' => nil)
      end
    end
  end
end
