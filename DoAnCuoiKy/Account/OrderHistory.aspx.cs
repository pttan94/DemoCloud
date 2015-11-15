using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DoAnCuoiKy.Account
{
    public partial class OrderHistory : System.Web.UI.Page
    {
        eWorldEntities db;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public List<Order> GetOrder()
        {
            string email = HttpContext.Current.User.Identity.Name;
            using (db = new eWorldEntities())
            {
                var result = db.Orders.Where(z => z.Email == email).ToList();
                if(result.Count == 0)
                {
                    Title_EmptyOrder.Visible = true;
                }
                return result;
            }
        }

        protected void orderDetail_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;

            string id = gvr.Cells[0].Text;
            Session["order_id"] = id;
            Response.Redirect("OrderHistoryDetail");
        }
       
    }
}