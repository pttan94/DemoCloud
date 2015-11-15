using DoAnCuoiKy.Logic;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DoAnCuoiKy
{
    public partial class ShoppingCart : System.Web.UI.Page
    {
        ShoppingCartActions usersShoppingCart;
        eWorldEntities db;
        protected void Page_Load(object sender, EventArgs e)
        {
            using (usersShoppingCart = new ShoppingCartActions())
            {
                decimal cartTotal = 0;
                cartTotal = usersShoppingCart.GetTotal();
                if (cartTotal > 0)
                {
                    // Display Total.
                    lblTotal.Text = String.Format(CultureInfo.GetCultureInfo("vi-VN"), "{0:c0}", cartTotal);
                    Title_EmptyCart.Visible = false;
                }
                else
                {
                    LabelTotalText.Text = "";
                    lblTotal.Text = "";
                    Title_EmptyCart.Visible = true;
                    Checkout_btn.Visible = false;
                    Update_btn.Visible = false;
                }
            }
        }
        public List<Cart> GetShoppingCartItems()
        {
            ShoppingCartActions actions = new ShoppingCartActions();
            return actions.GetCartItems();
        }

        public ShoppingCartActions.ShoppingCartUpdates[] getcartUpdate()
        {
            ShoppingCartActions.ShoppingCartUpdates[] cartUpdates = new ShoppingCartActions.ShoppingCartUpdates[CartList.Rows.Count];
            for (int i = 0; i < CartList.Rows.Count; i++)
            {
                IOrderedDictionary rowValues = new OrderedDictionary();
                rowValues = GetValues(CartList.Rows[i]);
                cartUpdates[i].ProductId = Convert.ToInt32(rowValues["ProductID"]);

                CheckBox cbRemove = new CheckBox();
                cbRemove = (CheckBox)CartList.Rows[i].FindControl("Remove");
                cartUpdates[i].RemoveItem = cbRemove.Checked;

                TextBox quantityTextBox = new TextBox();
                quantityTextBox = (TextBox)CartList.Rows[i].FindControl("PurchaseQuantity");
                cartUpdates[i].PurchaseQuantity = Convert.ToInt16(quantityTextBox.Text.ToString());
            }
            return cartUpdates;
        }

        public List<Cart> UpdateCartItems()
        {
            using (ShoppingCartActions usersShoppingCart = new ShoppingCartActions())
            {
                String cartId = usersShoppingCart.GetCartId();


                usersShoppingCart.UpdateShoppingCartDatabase(cartId, getcartUpdate());
                CartList.DataBind();
                lblTotal.Text = String.Format(CultureInfo.GetCultureInfo("vi-VN"), "{0:c0}", usersShoppingCart.GetTotal());
                List<Cart> result = usersShoppingCart.GetCartItems();
                if (result.Count == 0)
                {
                    LabelTotalText.Text = "";
                    lblTotal.Text = "";
                    Title_EmptyCart.Visible = true;
                    Checkout_btn.Visible = false;
                    Update_btn.Visible = false;
                }
                return result;
            }
        }

        public static IOrderedDictionary GetValues(GridViewRow row)
        {
            IOrderedDictionary values = new OrderedDictionary();
            foreach (DataControlFieldCell cell in row.Cells)
            {
                if (cell.Visible)
                {
                    // Extract values from the cell.
                    cell.ContainingField.ExtractValuesFromCell(values, cell, row.RowState, true);
                }
            }
            return values;
        }



        protected void Update_btn_Click(object sender, EventArgs e)
        {
            UpdateCartItems();
        }

        protected void Checkout_btn_Click(object sender, EventArgs e)
        {
           

            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                UpdateCartItems();
                Response.Redirect("/Checkout");
                /*
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

                    CartList.DataSource = null;
                    CartList.DataBind();
                

                    //usersShoppingCart.EmptyCart();

                    

                }*/
                //status_checkout.InnerText = "Đặt hàng thành công. Xem lại thông tin lại trang quản lý.";
                
            }
            else
            {
                Response.Redirect("/Account/Login");
            }


        }
    }
}