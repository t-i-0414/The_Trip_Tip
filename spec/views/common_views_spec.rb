RSpec.describe 'Common Views', type: :request do
  describe 'Should render right templates' do
    it 'Layouts' do
      get root_path
      expect(response).to render_template("layouts/application")
      expect(response).to render_template("layouts/background")
      expect(response).to render_template("layouts/footer")
      expect(response).to render_template("layouts/header")
      expect(response).to render_template("layouts/jquery")
      expect(response).to render_template("layouts/loading")
      expect(response).to render_template("layouts/meta_tags")
      expect(response).to render_template("layouts/shims")
    end

    it 'Static Pages' do
      get root_path
      expect(response).not_to render_template("static_pages/background")
      get about_path
      expect(response).to render_template("static_pages/background")
      get terms_of_use_path
      expect(response).to render_template("static_pages/background")
      get privacy_path
      expect(response).to render_template("static_pages/background")
    end
  end
end
