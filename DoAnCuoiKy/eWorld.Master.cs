using System;
using System.Collections.Generic;
using System.Security.Claims;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.ModelBinding;
using System.Web.Routing;
using DoAnCuoiKy.Logic;

namespace DoAnCuoiKy
{
    public partial class SiteMaster : MasterPage
    {
        private const string AntiXsrfTokenKey = "__AntiXsrfToken";
        private const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
        private string _antiXsrfTokenValue;
        eWorldEntities db;


        protected void Page_Init(object sender, EventArgs e)
        {
            // The code below helps to protect against XSRF attacks
            var requestCookie = Request.Cookies[AntiXsrfTokenKey];
            Guid requestCookieGuidValue;
            if (requestCookie != null && Guid.TryParse(requestCookie.Value, out requestCookieGuidValue))
            {
                // Use the Anti-XSRF token from the cookie
                _antiXsrfTokenValue = requestCookie.Value;
                Page.ViewStateUserKey = _antiXsrfTokenValue;
            }
            else
            {
                // Generate a new Anti-XSRF token and save to the cookie
                _antiXsrfTokenValue = Guid.NewGuid().ToString("N");
                Page.ViewStateUserKey = _antiXsrfTokenValue;

                var responseCookie = new HttpCookie(AntiXsrfTokenKey)
                {
                    HttpOnly = true,
                    Value = _antiXsrfTokenValue
                };
                if (FormsAuthentication.RequireSSL && Request.IsSecureConnection)
                {
                    responseCookie.Secure = true;
                }
                Response.Cookies.Set(responseCookie);
            }

            Page.PreLoad += master_Page_PreLoad;
        }

        protected void master_Page_PreLoad(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set Anti-XSRF token
                ViewState[AntiXsrfTokenKey] = Page.ViewStateUserKey;
                ViewState[AntiXsrfUserNameKey] = Context.User.Identity.Name ?? String.Empty;
            }
            else
            {
                // Validate the Anti-XSRF token
                if ((string)ViewState[AntiXsrfTokenKey] != _antiXsrfTokenValue
                    || (string)ViewState[AntiXsrfUserNameKey] != (Context.User.Identity.Name ?? String.Empty))
                {
                    throw new InvalidOperationException("Validation of Anti-XSRF token failed.");
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.IsInRole("canEdit"))
            {
                admin_link.Visible = true;
            }

            CategoryMenu.DataSource = GetCategories();
            CategoryMenu.DataBind();

            footer_db.DataSource = GetShopInfo();
            footer_db.DataBind();
        }

        protected void Unnamed_LoggingOut(object sender, LoginCancelEventArgs e)
        {


            using (ShoppingCartActions usersShoppingCart = new ShoppingCartActions())
            {
                usersShoppingCart.EmptyCart();
                
               
                Context.GetOwinContext().Authentication.SignOut();
            }
        }

        public List<Category> GetCategories()
        {
            using (db = new eWorldEntities())
            {
                var tmp = from cm in db.CategoryMenus
                          from c in db.Categories
                          where cm.CategoryID == c.CategoryID
                          select c;
                var result = tmp.ToList<Category>();
                return result;
            }
        }

        protected void icon_search_Click(object sender, ImageClickEventArgs e)
        {
            Session["search_string"] = search_query.Text;
            if (!String.IsNullOrEmpty(Session["search_string"].ToString()))
            {
                Response.Redirect("Search.aspx");

            }
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            using (ShoppingCartActions usersShoppingCart = new ShoppingCartActions())
            {
                string cartStr = string.Format("Giỏ hàng ({0})", usersShoppingCart.GetCount());
                cartCount.InnerText = cartStr;
            }
        }

        public List<ShopInfo> GetShopInfo()
        {
            using (db = new eWorldEntities())
            {
                var tmp = from i in db.ShopInfoes
                          select i;
                var result = tmp.ToList<ShopInfo>();
                return result;
            }
        }



    }

}