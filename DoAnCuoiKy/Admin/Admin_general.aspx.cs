using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DoAnCuoiKy.Admin
{
    public partial class Admin_general : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            MenuCategory.DataSource = GetCategories();
            MenuCategory.DataBind();
            if (!IsPostBack)
                bind_data();
        }

        public List<Category> GetCategories()
        {
            var db = new eWorldEntities();
            return db.Categories.ToList();

        }

        protected void save_cateMenu_Click(object sender, EventArgs e)
        {
            eWorldEntities db = new eWorldEntities();
            var t = db.CategoryMenus;
            db.CategoryMenus.RemoveRange(t);
            db.SaveChanges();
            foreach (ListItem item in MenuCategory.Items)
            {
                if (item.Selected)
                {
                    var tmp = db.Categories.Where(z => z.CategoryID.ToString() == item.Value).FirstOrDefault();
                    CategoryMenu cm = new CategoryMenu();
                    cm.CategoryID = tmp.CategoryID;
                    db.CategoryMenus.Add(cm);
                }
            }
            db.SaveChanges();

            MenuCategory.DataSource = GetCategories();
            MenuCategory.DataBind();
        }

        protected void save_info_Click(object sender, EventArgs e)
        {
            eWorldEntities db = new eWorldEntities();
            var tmp = db.ShopInfoes;
            db.ShopInfoes.RemoveRange(tmp);
            ShopInfo s = new ShopInfo();
            s.InfoContact = "";
            s.Warranty = "";
            s.Showroom = "";

            db.ShopInfoes.Add(s);
            db.SaveChanges();
        }
        public void bind_data()
        {
            eWorldEntities db = new eWorldEntities();
            var tmp = db.ShopInfoes.FirstOrDefault();
            //info_contact.Text = tmp.InfoContact;
            //warranty.Text = tmp.Warranty;
            //showroom.Text = tmp.Showroom;

            var tmp2 = db.ImageBanners.ToList();
            foreach (ImageBanner im in tmp2)
            {
                listofuploadedfiles.Text += String.Format("<br />{0}", im.Path);
            }

            var tmp3 = db.ImageSlides.ToList();
            foreach (ImageSlide im in tmp3)
            {
                list_upload_slide.Text += String.Format("<br />{0}", im.Path);
            }

            var tmp4 = db.CategoryMenus.ToList();
            foreach (CategoryMenu cm in tmp4)
            {
                foreach (ListItem lt in MenuCategory.Items)
                {
                    if (cm.CategoryID.ToString() == lt.Value)
                    {
                        lt.Selected = true;
                        break;
                    }
                }
            }


        }
        protected void submit_banner_Click(object sender, EventArgs e)
        {
            eWorldEntities db = new eWorldEntities();
            var tmp = db.ImageBanners;
            db.ImageBanners.RemoveRange(tmp);
            if (banner.HasFiles)
            {
                foreach (HttpPostedFile uploadedFile in banner.PostedFiles)
                {
                    uploadedFile.SaveAs(MapPath("~/style/image/banner/") + uploadedFile.FileName);
                    listofuploadedfiles.Text += String.Format("<br />{0}", uploadedFile.FileName);
                    ImageBanner im = new ImageBanner();
                    im.Path = uploadedFile.FileName;
                    db.ImageBanners.Add(im);
                }
            }
        }

        protected void submit_slide_Click(object sender, EventArgs e)
        {
            eWorldEntities db = new eWorldEntities();
            var tmp = db.ImageSlides;
            db.ImageSlides.RemoveRange(tmp);

            if (slide.HasFiles)
            {
                foreach (HttpPostedFile uploadedFile in slide.PostedFiles)
                {
                    uploadedFile.SaveAs(MapPath("~/style/image/slide/") + uploadedFile.FileName);
                    listofuploadedfiles.Text += String.Format("<br />{0}", uploadedFile.FileName);
                    ImageSlide im = new ImageSlide();
                    im.Path = uploadedFile.FileName;
                    db.ImageSlides.Add(im);
                }
            }
        }
    }
}