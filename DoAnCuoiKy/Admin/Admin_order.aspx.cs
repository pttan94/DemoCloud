using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DoAnCuoiKy.Admin
{
    public partial class Admin_order : System.Web.UI.Page
    {
        eWorldEntities db;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public List<string> status_order()
        {
            return new List<string> { "Đã thanh toán", "Chưa thanh toán" };
        }
        public List<Order> GetOrder()
        {
            using (db = new eWorldEntities())
            {
                var result = db.Orders.ToList();
                return result;
            }
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            db = new eWorldEntities();
            var tmp = db.Orders.ToList();
            for (int i = 0; i < OrderList.Rows.Count; i++)
            {
                DropDownList status = new DropDownList();
                status = (DropDownList)OrderList.Rows[i].FindControl("order_status");
                if (tmp[i].paid == true)
                {
                    //OrderList.Rows[i].Cells[4].Text = "DDax";
                    status.SelectedIndex = 0;
                }
                else
                {
                    //OrderList.Rows[i].Cells[4].Text = "Chuaw";
                    status.SelectedIndex = 1;
                }
            }
        }
        protected void orderDetail_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;

            string id = gvr.Cells[0].Text;
            Session["order_id"] = id;
            Response.Redirect("/OrderHistoryDetail");
        }

        protected void order_status_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList btn = (DropDownList)sender;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;

            string id = gvr.Cells[0].Text;
            db = new eWorldEntities();
            var tmp = (from o in db.Orders where o.OrderID.ToString() == id select o).FirstOrDefault();
            if (btn.SelectedIndex == 0)
                tmp.paid = true;
            else tmp.paid = false;
            db.SaveChanges();
        }
    }
}