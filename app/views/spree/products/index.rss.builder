@products = Spree::Product.available.where("count_on_hand>0").includes(:variants, :option_values)
xml.instruct! :xml, :version=>"1.0"
xml.rss(:version=>"2.0", "xmlns:g" => "http://base.google.com/ns/1.0"){
  xml.channel{
    xml.title("#{Spree::Config[:site_name]}")
    xml.link("http://#{Spree::Config[:site_url]}")
    xml.description("Find out about new products first! You'll always be in the know when new products become available")
    xml.language('en-us')
    @products.each do |product|
      product.variants.each do |variant|
        xml.item do
            xml.title(product.name)
            xml.description((product.images.count > 0 ? link_to(image_tag(product.images.first.attachment.url(:product)), product_url(product)) : '') + simple_format(product.description))
            xml.author(Spree::Config[:site_url])
            xml.pubDate((product.available_on || product.created_at).strftime("%a, %d %b %Y %H:%M:%S %z"))
            xml.link(product_url(product))
            xml.guid(product.id)
            xml.sku(product.sku)
    #       xml.vendor_sku(product.vendor_sku)
            xml.weight(product.weight)
            xml.tag!('g:brand', 'ShoeLove')
            xml.tag!('g:gender', 'female')
            xml.tag!('g:size', variant.options_text.match(/[.\d]+/)[0].to_f)
            xml.tag!('g:color', product.property("Color")||"Black")
            xml.tag!('g:google_product_category', 'Apparel & Accessories > Shoes')
            xml.tag!('g:product_type', 'Apparel & Accessories > Shoes')
            xml.tag!('g:age_group', 'Adult')
            if product.images.count > 0
              xml.tag!('g:image_link', product.images.first.attachment.url(:large))
            end

            xml.tag!('g:price', product.price)
            xml.tag!('g:condition', 'new')
            xml.tag!('g:id', product.id)
            xml.tag!('g:availability', product.count_on_hand > 0 ? 'in stock' : 'out of stock')
        end
      end
    end
  }
}
