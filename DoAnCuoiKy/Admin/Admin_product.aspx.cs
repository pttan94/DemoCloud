using DoAnCuoiKy.Logic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DoAnCuoiKy.Admin
{
    public partial class Admin_product : System.Web.UI.Page
    {
        eWorldEntities db;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ProductList.DataSource = GetProduct();
                ProductList.DataBind();
            }
        }


        //protected void RemoveProductButton_Click(object sender, EventArgs e)
        //{
        //    using (var _db = new eWorldEntities())
        //    {
        //        int productId = Convert.ToInt16(DropDownRemoveProduct.SelectedValue);
        //        var myItem = (from c in _db.Products where c.ProductID == productId select c).FirstOrDefault();
        //        if (myItem != null)
        //        {
        //            _db.Products.Remove(myItem);
        //            _db.SaveChanges();

        //            // Reload the page.
        //            string pageUrl = Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.Count() - Request.Url.Query.Count());
        //            Response.Redirect(pageUrl + "?ProductAction=remove");
        //        }
        //        else
        //        {
        //            LabelRemoveStatus.Text = "Unable to locate product.";
        //        }
        //    }
        //}

        protected void add_product_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin_addproduct");
        }
        public List<Product> GetProduct()
        {
            using (db = new eWorldEntities())
            {
                var result = db.Products.ToList();
                return result;
            }
        }

        protected void ProDetail_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;

            string id = gvr.Cells[0].Text;
            Session["edit_pro_id"] = id;
            Response.Redirect("Admin_editproduct");
        }
        /*
        protected void ProDel_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;

            string id = gvr.Cells[0].Text;
            deleteProduct(id);

            ProductList.DataSource = GetProduct();
            ProductList.DataBind();
        }

        private void deleteProduct(string id)
        {
            db = new eWorldEntities();

            var pro = (from p in db.Products where p.ProductID.ToString() == id select p).FirstOrDefault();

            if (pro != null)
            {
                var cat_pro = from pc in db.ProductInCategories where pc.ProductID.ToString() == id select pc;
                if (cat_pro != null)
                {
                    var tmp = cat_pro.ToList();
                    int count = tmp.Count;

                    for (int i = 0; i < count; i++)
                        db.ProductInCategories.Remove(tmp[i]);
                }

                var order = from pc in db.OrderDetails where pc.ProductID.ToString() == id select pc;
                if (order != null)
                {
                    var tmp = order.ToList();
                    int count = tmp.Count;

                    for (int i = 0; i < count; i++)
                        db.OrderDetails.Remove(tmp[i]);
                }

                db.Products.Remove(pro);
                db.SaveChanges();

            }
            else
            {
            }
        }
         * */
    }
}