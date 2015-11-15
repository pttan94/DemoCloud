using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DoAnCuoiKy.Account
{
    public partial class OrderHistoryDetail : System.Web.UI.Page
    {
        int order_id;
        eWorldEntities db;
        protected void Page_Load(object sender, EventArgs e)
        {
            order_id = Convert.ToInt32( Session["order_id"].ToString());
        }
        public List<OrderDetail> GetOrderDetail()
        {
            db = new eWorldEntities();
            return db.OrderDetails.Where(z => z.OrderID == order_id).ToList();
        }
    }
}