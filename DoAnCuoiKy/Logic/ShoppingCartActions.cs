using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DoAnCuoiKy.Logic
{
    public class ShoppingCartActions : IDisposable
    {
        public string ShoppingCartId { get; set; }

        eWorldEntities db = new eWorldEntities();

        public const string CartSessionKey = "CartId";

        public void AddToCart(int id)
        {

            
                // Retrieve the product from the database.           
                ShoppingCartId = GetCartId();

                var cartItem = db.Carts.SingleOrDefault(
                    c => c.CartID == ShoppingCartId
                    && c.ProductID == id);
                if (cartItem == null)
                {
                    cartItem = new Cart
                    {
                        ItemID = Guid.NewGuid().ToString(),
                        ProductID = id,
                        CartID = ShoppingCartId,
                        Product = db.Products.SingleOrDefault(
                         p => p.ProductID == id),
                        Quantity = 1,
                        DateCreated = DateTime.Now
                    };

                    db.Carts.Add(cartItem);
                }
                else
                {
                    cartItem.Quantity++;
                }
                db.SaveChanges();
            
        }

        public void Dispose()
        {
            if (db != null)
            {
                db.Dispose();
                db = null;
            }
        }

        public string GetCartId()
        {
            if (HttpContext.Current.Session[CartSessionKey] == null)
            {
                if (!string.IsNullOrWhiteSpace(HttpContext.Current.User.Identity.Name))
                {
                    HttpContext.Current.Session[CartSessionKey] = HttpContext.Current.User.Identity.Name;
                }
                else
                {
                    // Generate a new random GUID using System.Guid class.     
                    Guid tempCartId = Guid.NewGuid();
                    HttpContext.Current.Session[CartSessionKey] = tempCartId.ToString();
                }
            }
            return HttpContext.Current.Session[CartSessionKey].ToString();
        }

        public List<Cart> GetCartItems()
        { 
            ShoppingCartId = GetCartId();
            db = new eWorldEntities();

           // var tmp = from c in db.Carts
           //           where c.CartID == ShoppingCartId
           //           select c;
           // var result = tmp.ToList();
           // return result;

            return db.Carts.Where(
          c => c.CartID == ShoppingCartId).ToList();
           
        }

        public decimal GetTotal()
        {
            using (db = new eWorldEntities())
            {
                ShoppingCartId = GetCartId();
                decimal? total = decimal.Zero;
                total = (decimal?)(from cartItems in db.Carts
                                   where cartItems.CartID == ShoppingCartId
                                   select (int?)cartItems.Quantity *
                                   cartItems.Product.Price).Sum();
                return total ?? decimal.Zero;
            }
        }
        public ShoppingCartActions GetCart()
        {
            using (var cart = new ShoppingCartActions())
            {
                cart.ShoppingCartId = cart.GetCartId();
                return cart;
            }
        }

        public void UpdateShoppingCartDatabase(String cartId, ShoppingCartUpdates[] CartItemUpdates)
        {
            
                try
                {
                    int CartItemCount = CartItemUpdates.Count();
                    List<Cart> myCart = GetCartItems();
                    foreach (var cartItem in myCart)
                    {
                        for (int i = 0; i < CartItemCount; i++)
                        {
                            if (cartItem.Product.ProductID == CartItemUpdates[i].ProductId)
                            {
                                if (CartItemUpdates[i].PurchaseQuantity < 1 || CartItemUpdates[i].RemoveItem == true)
                                {
                                    RemoveItem(cartId, cartItem.ProductID);
                                }
                                else
                                {
                                    UpdateItem(cartId, cartItem.ProductID, CartItemUpdates[i].PurchaseQuantity);
                                }
                            }
                        }
                    }
                }
                catch (Exception exp)
                {
                    throw new Exception("ERROR: Unable to Update Cart Database - " + exp.Message.ToString(), exp);
                }
            
        }

        public void RemoveItem(string removeCartID, int removeProductID)
        {
            using (var _db = new eWorldEntities())
            {
                try
                {
                    var myItem = (from c in _db.Carts where c.CartID == removeCartID && c.Product.ProductID == removeProductID select c).FirstOrDefault();
                    if (myItem != null)
                    {
                        _db.Carts.Remove(myItem);
                        _db.SaveChanges();
                    }
                }
                catch (Exception exp)
                {
                    throw new Exception("ERROR: Unable to Remove Cart Item - " + exp.Message.ToString(), exp);
                }
            }
        }

        public void UpdateItem(string updateCartID, int updateProductID, int quantity)
        {
            using (var _db = new eWorldEntities())
            {
                try
                {
                    var myItem = (from c in _db.Carts where c.CartID == updateCartID && c.Product.ProductID == updateProductID select c).FirstOrDefault();
                    if (myItem != null)
                    {
                        myItem.Quantity = quantity;
                        _db.SaveChanges();
                    }
                }
                catch (Exception exp)
                {
                    throw new Exception("ERROR: Unable to Update Cart Item - " + exp.Message.ToString(), exp);
                }
            }
        }

        public void EmptyCart()
        {
            ShoppingCartId = GetCartId();
            var cartItems = db.Carts.Where(
                c => c.CartID == ShoppingCartId);
            foreach (var cartItem in cartItems)
            {
                db.Carts.Remove(cartItem);
            }
            // Save changes.             
            db.SaveChanges();
        }

        public int GetCount()
        {
            ShoppingCartId = GetCartId();

            // Get the count of each item in the cart and sum them up          
            int? count = (from cartItems in db.Carts
                          where cartItems.CartID == ShoppingCartId
                          select (int?)cartItems.Quantity).Sum();
            // Return 0 if all entries are null         
            return count ?? 0;
        }

        public struct ShoppingCartUpdates
        {
            public int ProductId;
            public int PurchaseQuantity;
            public bool RemoveItem;
        }
    }
}