class Shop < ActiveRecord::Base
  include ShopifyApp::SessionStorage

  def api_version
    ShopifyApp.configuration.api_version
  end

  def activate_shopify_session
    session = ShopifyAPI::Session.new(
      domain: shopify_domain,
      token: shopify_token,
      api_version: api_version
    )
    ShopifyAPI::Base.activate_session(session)
  end

  def pull_metafields_from(shop, scope="all")
    SyncMetafields.call(
      pull_metafields_into_shop: self,
      pull_metafields_from_shop: shop,
      scope: scope
    )
  end
end
