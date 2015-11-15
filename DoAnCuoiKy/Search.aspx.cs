using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DoAnCuoiKy
{
    public partial class Search : System.Web.UI.Page
    {
        eWorldEntities db;
        Boolean orderbyasc = true;
        double min_price = 0;
        List<double> priceList = new List<double> { 0, 2000000, 4000000, 6000000, 8000000, 10000000 };
        string vendor;
        string search_string;
        BUS bus = new BUS();
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Title = "Tìm kiếm";
            search_string = Session["search_string"].ToString();
            title_search.Text = "<h1>Kết quả tìm kiếm cho: " + search_string + "</h1>";

            if (!IsPostBack)
            {
                search_vendor.DataSource = GetVendor_Category();
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
           
            
            Category.DataSource = GetProduct(search_string);
            Category.DataBind();
        }

        public List<Product> GetProduct(string search_string)
        {
            using (db = new eWorldEntities())
            {

                var tmp = from p in db.Products
                          where( p.ProductName.ToString().ToLower().Contains(search_string.ToLower())
                          || p.Vendor.ToString().ToLower().Contains(search_string.ToLower()) )
                          && p.Show == true
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

        public List<Product> GetProduct_Right(string CategoryName)
        {
            using (db = new eWorldEntities())
            {
                var tmp = from c in db.Categories
                          from p in db.Products
                          from pc in db.ProductInCategories
                          where c.CategoryID == pc.CategoryID && pc.ProductID == p.ProductID && c.Name.Contains(CategoryName)
                          select p;
                tmp.Take(3);
                var result = tmp.ToList<Product>();
                return result;
            }
        }
        public List<string> GetVendor_Category()
        {
            using (db = new eWorldEntities())
            {
                var tmp = from p in db.Products
                          select p.Vendor;

                var result = tmp.ToList();
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
        
    }
}