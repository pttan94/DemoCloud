using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DoAnCuoiKy.Admin
{
    public partial class Admin_category : System.Web.UI.Page
    {
        eWorldEntities db;
        Category cat;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                data_blind();
            }
        }

        public void data_blind()
        {
            list_cat.DataSource = GetCategories();
            list_cat.DataBind();
        }
        public List<Category> GetCategories()
        {
            using (db = new eWorldEntities())
            {
                var tmp = from c in db.Categories
                          select c;
                var result = tmp.ToList<Category>();
                return result;
            }
        }

        protected void add_cat_Click(object sender, EventArgs e)
        {
            

            cat = new Category();
            cat.Name = add_name_cat.Text;
            cat.KeyWord = add_name_cat.Text;

            using (db = new eWorldEntities())
            {
                db.Categories.Add(cat);
                db.SaveChanges();
            }


            add_cat_status.Text = "Thêm nhóm sản phẩm thành công.";
            delate_cat_status.Visible = false;
            update_cat_status.Visible = false;
            add_cat_status.Visible = true;

            add_name_cat.Text = "";
            data_blind();
        }

        protected void update_cat_Click(object sender, EventArgs e)
        {
           

            int catID = Convert.ToInt16(list_cat.SelectedValue);
            using (db = new eWorldEntities())
            {
                var cat = (from c in db.Categories where c.CategoryID == catID select c).FirstOrDefault();
                if (cat != null)
                {
                    cat.Name = new_name_cat.Text;

                    db.SaveChanges();

                    update_cat_status.Text = "Sửa nhóm sản phẩm thành công.";
                    delate_cat_status.Visible = false;
                    update_cat_status.Visible = true;
                    add_cat_status.Visible = false;
                    data_blind();
                }
                else
                {
                    delate_cat_status.Text = "Có lỗi xảy ra, vui lòng thử lại.";
                    update_cat_status.Visible = true;
                    delate_cat_status.Visible = false;
                    add_cat_status.Visible = false;
                    
                }
            }
            new_name_cat.Text = "";
        }

        protected void del_cat_Click(object sender, EventArgs e)
        {
            

            int catID = Convert.ToInt16(list_cat.SelectedValue);
            using (db = new eWorldEntities())
            {
                var cat = (from c in db.Categories where c.CategoryID == catID select c).FirstOrDefault();
                if (cat != null)
                {
                    var cat_pro = from pc in db.ProductInCategories where pc.CategoryID == catID select pc;
                    if (cat_pro != null)
                    {
                        var tmp = cat_pro.ToList();
                        int count = tmp.Count;

                        for (int i = 0; i < count; i++)
                            db.ProductInCategories.Remove(tmp[i]);
                    }
                    var cat_menu = from cm in db.CategoryMenus where cm.CategoryID == catID select cm;
                    if (cat_pro != null)
                    {
                        var tmp = cat_menu.ToList();
                        int count = tmp.Count;

                        for (int i = 0; i < count; i++)
                            db.CategoryMenus.Remove(tmp[i]);
                    }
                    db.Categories.Remove(cat);
                    db.SaveChanges();

                    delate_cat_status.Text = "Xóa nhóm sản phẩm thành công.";
                    delate_cat_status.Visible = true;
                    update_cat_status.Visible = false;
                    add_cat_status.Visible = false;
                    data_blind();
                }
                else
                {
                    delate_cat_status.Text = "Có lỗi xảy ra, vui lòng thử lại.";
                    update_cat_status.Visible = false;
                    delate_cat_status.Visible = true;
                    add_cat_status.Visible = false;

                }
            }
            new_name_cat.Text = "";
        }

       
      
    }
}