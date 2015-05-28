require 'spine/routing'

module Spine
  module Routing
    # TODO:
    # * variables constraints

    describe Route do
      subject { Route.new('test', '/testing', handler, :get) }

      let(:handler) { double }

      it 'has name' do
        expect(subject.name).to eql('test')
      end

      it 'has pattern' do
        expect(subject.pattern).to eql('/testing')
      end

      it 'has app' do
        expect(subject.app).to be
      end

      it 'has verb' do
        expect(subject.verb).to eql(:get)
      end

      describe 'when matching route' do
        it 'matches route' do
          expect(subject.match(:get, '/testing')).to be
        end

        it 'do not match route' do
          expect(subject.match(:get, '/testing1')).not_to be
        end

        it 'do not match route with different verb' do
          expect(subject.match(:post, '/testing')).not_to be
        end
      end

      describe 'when extracting path variables' do
        subject { Route.new('test', '/testing/:id', handler, :get) }

        it 'parses variable value' do
          expect(subject.match(:get, '/testing/1').parameters)
            .to eql('id' => '1', 'format' => nil)
        end
      end

      describe 'when extracting wildcard variables' do
        subject { Route.new('test', '/*', handler, :get) }

        it 'parses values' do
          expect(subject.match(:get, '/testing/1').parameters)
            .to eql('paths' => 'testing/1', 'format' => nil)
        end

        describe 'and path variables' do
          subject { Route.new('test', '/:action/*/:id', handler, :get) }

          it 'parses values' do
            expect(subject.match(:get, '/testing/this/is/some/random/stuff/1').parameters)
              .to eql('paths' => 'this/is/some/random/stuff', 'action' => 'testing', 'id' => '1', 'format' => nil)
          end
        end

        describe 'and path variables and wildcard is named' do
          subject { Route.new('test', '/:action/*stuff/:id', handler, :get) }

          it 'parses variables' do
            expect(subject.match(:get, '/testing/this/is/some/random/stuff/1').parameters)
              .to eql('stuff' => 'this/is/some/random/stuff', 'action' => 'testing', 'id' => '1', 'format' => nil)
          end
        end

        describe 'and path variables and wildcard at the end' do
          subject { Route.new('test', '/:action/*stuff', handler, :get) }

          it 'parses variables' do
            expect(subject.match(:get, '/testing/this/is/some/random/stuff').parameters)
              .to eql('stuff' => 'this/is/some/random/stuff', 'action' => 'testing', 'format' => nil)
          end
        end
      end
    end
  end
end
