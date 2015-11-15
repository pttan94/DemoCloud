using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DoAnCuoiKy
{
    public partial class _Default : Page
    {

        eWorldEntities db;
        string CateID;

        protected void Page_Load(object sender, EventArgs e)
        {
            Featured_Product.DataSource = GetProduct_Index("Nổi bật");
            Featured_Product.DataBind();
            feat_pro_index_cat.NavigateUrl = "/Category?CategoryID=" + getURL("Nổi bật");

            Sale_Product.DataSource = GetProduct_Index("Giảm giá");
            Sale_Product.DataBind();
            sale_pro_index_cat.NavigateUrl = "/Category?CategoryID=" + getURL("Giảm giá");

            Mobile_index.DataSource = GetProduct_Index("Điện thoại");
            Mobile_index.DataBind();
            mobile_pro_index_cat.NavigateUrl = "/Category?CategoryID=" + getURL("Điện thoại");

            Tablet_index.DataSource = GetProduct_Index("Máy tính bảng");
            Tablet_index.DataBind();
            tablet_pro_index_cat.NavigateUrl = "/Category?CategoryID=" + getURL("Máy tính bảng");

            PK_index.DataSource = GetProduct_Index("Phụ kiện");
            PK_index.DataBind();
            pk_pro_index_cat.NavigateUrl = "/Category?CategoryID=" + getURL("Phụ kiện");

            Slide_index.DataSource = getImage_slide();
            Slide_index.DataBind();
            

            image_banner.DataSource = getImage_banner();
            image_banner.DataBind();

            
        }

        public List<Product> GetProduct_Index(string keyword)
        {
            using (db = new eWorldEntities())
            {
                var tmp = from p in db.Products
                             from c in db.Categories
                             from pc in db.ProductInCategories
                             where p.ProductID == pc.ProductID && pc.CategoryID == c.CategoryID
                             && c.KeyWord.Contains(keyword) && p.Show == true
                             select p;
                int num = 4;
                tmp.Take<Product>(num);
                var result = tmp.ToList<Product>();
                return result;
            }
        }

        public List<ImageSlide> getImage_slide()
        {
            using (db = new eWorldEntities())
            {
                var tmp = from i in db.ImageSlides
                          select i;
                var result = tmp.ToList<ImageSlide>();
                return result;
            }
        }

        public int getnumImage_slide()
        {
            using (db = new eWorldEntities())
            {
                var tmp = from i in db.ImageSlides
                          select i;

                return tmp.ToList<ImageSlide>().Count;
            }
        }
        public List<ImageBanner> getImage_banner()
        {
            using (db = new eWorldEntities())
            {
                var tmp = from i in db.ImageBanners
                          select i;
                var result = tmp.ToList<ImageBanner>();
                return result;
            }
        }

        public string getURL(string keyword)
        {
            using (db = new eWorldEntities())
            {
                var tmp = from c in db.Categories
                          where c.KeyWord.Contains(keyword)
                          select c.CategoryID;
                var result = tmp.ToList();
                if (result.Count != 0)
                    CateID = result[0].ToString();
                else CateID = null;
                return CateID;
            }
        }

    }
}