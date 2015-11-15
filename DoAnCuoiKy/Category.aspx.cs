using DoAnCuoiKy.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DoAnCuoiKy
{
      
    public partial class Category1 : System.Web.UI.Page
    {
        eWorldEntities db;
        Boolean orderbyasc = true;
        double min_price = 0;
        List<double> priceList = new List<double> { 0, 2000000, 4000000, 6000000, 8000000, 10000000 };
        string vendor;
        string cateName;
        BUS bus = new BUS();
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Title = get_cateName();
            if (!IsPostBack)
            {
                
                string CategoryID = Request.QueryString["CategoryID"];
                Link_cate.Text = cateName;
                Link_cate.NavigateUrl = "/Category?CategoryID=" + CategoryID;

                search_vendor.DataSource = GetVendor_Category(CategoryID);
                search_vendor.DataBind();
                search_vendor.Items.Insert(0, new ListItem("--Tất cả--", "0"));
                search_vendor.AutoPostBack = true;
                search_vendor.SelectedIndex = 0;

                bind_data();
                right_pro_feat.DataSource = bus.GetProduct_Right("Nổi bật");
                right_pro_feat.DataBind();

                right_pro_new.DataSource = bus.GetProduct_Right("Mới về");
                right_pro_new.DataBind();

            }
        }

        public void bind_data()
        {
            string CategoryID = Request.QueryString["CategoryID"];

            Category.DataSource = GetProduct(CategoryID);
            Category.DataBind();

            
        }

        public List<Product> GetProduct(string CategoryID)
        {
            using (db = new eWorldEntities())
            {
               
                var tmp = from c in db.Categories
                          from p in db.Products
                          from pc in db.ProductInCategories
                          where c.CategoryID == pc.CategoryID && pc.ProductID == p.ProductID
                          && c.CategoryID.ToString().Contains(CategoryID) && p.Show == true
                          select p;
                var result = tmp.ToList<Product>();

                //Price
                int index = search_price.SelectedIndex;
                min_price = priceList[index];
                result = result.Where(p => p.Price >= min_price).ToList();

                //Vendor
                if (search_vendor.SelectedIndex != 0)
                {
                    vendor = search_vendor.SelectedItem.Text;
                    result = result.Where(p => p.Vendor.ToString() == vendor).ToList();
                }

                //Orderby
                orderbyasc = PriceOrders.SelectedIndex == 0 ? true : false;
                if (orderbyasc)
                    result = result.OrderBy(p => p.Price).ToList();
                else result = result.OrderByDescending(p => p.Price).ToList();

                return result;
                
            }
        }

        public List<string> GetVendor_Category(string CategoryID)
        {
            using (db = new eWorldEntities())
            {
                var tmp = from c in db.Categories
                          from p in db.Products
                          from pc in db.ProductInCategories
                          where c.CategoryID == pc.CategoryID && pc.ProductID == p.ProductID
                          && c.CategoryID.ToString() == CategoryID
                          select p;
                
                var result = tmp.Select(p => p.Vendor).ToList();
                result.Distinct();
                return result.Distinct().ToList();
            }

        }
        protected void Category_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            ProductListPagerCombo.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            bind_data();
        }
        protected void PriceOrders_SelectedIndexChanged(object sender, EventArgs e)
        {
            bind_data();
        }
        protected void PriceSearch_SelectedIndexChanged(object sender, EventArgs e)
        {
            bind_data();
        }
        protected void VendorSearch_SelectedIndexChanged(object sender, EventArgs e)
        {
            bind_data();
        }
        protected string get_cateName()
        {
            using (db = new eWorldEntities())
            {
                string CategoryID = Request.QueryString["CategoryID"];
                var tmp = from c in db.Categories
                          where c.CategoryID.ToString() == CategoryID
                          select c;
                var result = tmp.ToList();
                cateName = result[0].Name.ToString();
                return cateName;
            }
        }
    }
}