require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test 'product attributes must not be empty' do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?
  end
  test 'product price must be positive' do
    product = Product.new(title: 'my book',
                          description: 'this my first book',
                          image_url: 'ruby.jpg')
    product.price = -1
    assert product.invalid?
    assert_equal ['must be greater than or equal to 0.01'],
                 product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ['must be greater than or equal to 0.01'],
                 product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(title: 'my book title',
                description: 'yyyy',
                price: 1,
                image_url: image_url)

  end

  test 'image url' do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    ok.each { |image_url|
      assert new_product(image_url).valid?,
             "#{image_url} must be valid"
    }
    bad.each { |image_url|
      assert new_product(image_url).invalid?,
             "#{image_url} must be invalid"
    }
  end

  test 'product is not valid without a unique title - i18n' do
    product = Product.new(title: products(:ruby).title,
                          description: 'yyyy',
                          price: 1,
                          image_url: 'ruby.jpg')
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')],
                 product.errors[:title]
  end
end
