class CartsController < ApplicationController
   
   include Authenticable # Include authentication module
    before_action :authenticate_user! #, only: [:index]

    def get_user_cart
      token = request.headers['Authorization']&.split(' ')&.last
      @token = JsonWebToken.decode(token)
      @user = User.find_by(id: @token.id)
      if @user.present?
        # render json: UserSerializer.new(@user, meta: {
        #   token: encode(@user.id), message: "User fetched successfully"
        # }).serializable_hash[:data][:attributes], status: :ok
        cart = @user.find_or_create_cart #.includes(cart_items: :product)
        if cart
            render json: cart.as_json(
                include: {
                cart_items: { include: :product }
                }
            ), status: :ok
        else
            render json: { error: "Cart not found" }, status: :not_found
        end
      else
            render json: { error: 'This user not found' }, status: :unauthorized
      end
    end

  # Get or Create a Cart
  def show
    user = User.find(params[:id])  # Explicit user lookup
  cart = user.find_or_create_cart
  render json: { cart_items_count: cart.cart_items.count }
    # cart = find_or_create_cart
    # render json: cart, include: :cart_items
  end

  # Add an item to the Cart
  def add_item
    cart = current_user.find_or_create_cart
    product = Product.find(params[:product_id])

    cart_item = cart.cart_items.find_or_initialize_by(product: product)
    cart_item.quantity += params[:quantity].to_i
    cart_item.price = product.price
    cart.total_price += cart_item.price
    cart.save!
    # puts 'cart details'
    # puts cart_item
    # puts cart
    cart_item.save!

    render json: { message: 'Product added to cart', cart: cart, include: :cart_items}
  end

  # Remove an item from the Cart
  def remove_item
    cart_item = current_user.cart.cart_items.find(params[:id])
    cart_item.destroy
    # render json: cart, include: :cart_items
    render json: { message: "Item removed" }
  end

  # update Cart Item
  def update_cart_item
    cart = current_user.cart
    cart_item = cart.cart_items.find_by(id: params[:cart_item_id])

    if cart_item
      if params[:quantity].to_i > 0
        cart_item.update(quantity: params[:quantity])
        render json: { message: "Cart updated", cart_item: cart_item }, status: :ok
      else
        cart_item.destroy
        render json: { message: "Item removed from cart" }, status: :ok
      end
    else
      render json: { error: "Cart item not found" }, status: :not_found
    end
  end

  # Destroy Cart (Clear all items)
  def clear_cart
    current_user.cart.cart_items.destroy_all
    render json: { message: "Cart cleared" }
  end

  private

  # Find the cart or create one
  
end
