using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DoAnCuoiKy
{
    public partial class Product1 : System.Web.UI.Page
    {
        BUS blc = new BUS();
        string title = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            int ProductId = Convert.ToInt32(Request.QueryString["ProductID"]);
            ProductDetail.DataSource = blc.GetProductDetail_ToList(ProductId);
            ProductDetail.DataBind();
            title = blc.GetProductDetail(ProductId).ProductName;
            Page.Title = title;

            right_pro_feat.DataSource = blc.GetProduct_Right("Nổi bật");
            right_pro_feat.DataBind();

            right_pro_new.DataSource = blc.GetProduct_Right("Mới về");
            right_pro_new.DataBind();

            
        }
       
    }
}