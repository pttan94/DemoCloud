using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DoAnCuoiKy
{
    public partial class Checkout_success : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
     
        protected void back_to_cart_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default");
        }
    }
}