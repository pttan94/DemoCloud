using DoAnCuoiKy.Logic;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DoAnCuoiKy
{
    public partial class Checkout : System.Web.UI.Page
    {
        eWorldEntities db;
        ShoppingCartActions usersShoppingCart;
        protected void Page_Load(object sender, EventArgs e)
        {
            using (usersShoppingCart = new ShoppingCartActions())
            {
                decimal cartTotal = 0;
                cartTotal = usersShoppingCart.GetTotal();
                lblTotal.Text = String.Format(CultureInfo.GetCultureInfo("vi-VN"), "{0:c0}", cartTotal);
            }
        }

        public List<Cart> GetShoppingCartItems()
        {
            ShoppingCartActions actions = new ShoppingCartActions();
            return actions.GetCartItems();
        }

        protected void submit_Click(object sender, EventArgs e)
        {
            db = new eWorldEntities();

            using (usersShoppingCart = new ShoppingCartActions())
            {
                List<Cart> c = usersShoppingCart.GetCartItems();
                Order order = new Order();
                order.OrderDate = c[0].DateCreated;
                order.Email = HttpContext.Current.User.Identity.Name;
                order.Total = Convert.ToDouble(usersShoppingCart.GetTotal());
                order.paid = false;

                db.Orders.Add(order);
                db.SaveChanges();

                OrderDetail orderdetail;
                int num = c.Count;
                for (int i = 0; i < num; i++)
                {
                    orderdetail = new OrderDetail();

                    orderdetail.OrderID = order.OrderID;
                    orderdetail.ProductID = c[i].ProductID;
                    orderdetail.Quantity = c[i].Quantity;
                    orderdetail.UnitPrice = c[i].Product.Price;

                    db.OrderDetails.Add(orderdetail);
                    db.SaveChanges();
                }

                string ShoppingCartId = usersShoppingCart.GetCartId();
                var cartItems = db.Carts.Where(
                    ci => ci.CartID == ShoppingCartId);
                foreach (var cartItem in cartItems)
                {
                    db.Carts.Remove(cartItem);
                }
                // Save changes.             
                db.SaveChanges();

                Response.Redirect("Checkout_success");


            }
        }

        protected void cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ShoppingCart");
        }
    }
}