class CartController < ApplicationController
    def add
      #get the ID of the product
      id = params[:id]

      #if the cart exists use it
      #otherwise create a new one
      if session[:cart] then 
        cart = session[:cart]
      else
        session[:cart] = {}
        cart = session[:cart]
      end

      #if the product has already been added, increase the quantity
      #otherwise set the quantity to 1
      if cart[id]  
        cart[id] = cart[id] + 1
      else
        cart[id] = 1
      end
      
      #redirect to the cart page to show current status
      redirect_to cart_path
    end
        
    def clearCart
      #set the session variable to nil if not empty
      #redirect to page in both cases
      if session[:cart]
      	session[:cart] = nil
      	redirect_to cart_path
      	flash[:notice] = "Your cart has been cleared!"
      else
      	redirect_to cart_path
      	flash[:notice] = "There is nothing to empty!"
      end
    end
        
    def index 
      #if the cart already exists, pass it to the page for display
      #otherwise pass an empty value
      if session[:cart] then
        @cart = session[:cart]
      else
        @cart = {}
      end
    end

    def increase
      id = params[:id]
      cart = session[:cart]
      cart[id] += 1
      redirect_to cart_path
    end

    def reduce
      id = params[:id]
      cart = session[:cart]
      if cart[id] > 0
        cart[id] -= 1
      end
      redirect_to cart_path
    end

    def remove
      id = params[:id]
      cart = session[:cart]
      if cart[id] 
        cart[id] = nil
      end
      redirect_to cart_path
    end

    def checkout      
      session[:cart] = nil
      redirect_to root_path
      flash[:notice] = "Your items are on the way!"
    end

    def showCheckout
      redirect_to checkoutSuccess
    end
end
