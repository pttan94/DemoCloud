using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DoAnCuoiKy.Admin
{
    public partial class Admin_editproduct : System.Web.UI.Page
    {
        int pro_id;
        eWorldEntities db;
        Product p;
        List<string> image_name = new List<string>();
        protected void Page_Load(object sender, EventArgs e)
        {
            string productAction = Request.QueryString["ProductAction"];
            if (productAction == "edit")
            {
                LabelAddStatus.Text = "Sản phẩm đã được sửa thành công.";
            }
            if (!IsPostBack)
            {
                pro_id = Convert.ToInt32(Session["edit_pro_id"].ToString());
                db = new eWorldEntities();
                p = db.Products.Where(z => z.ProductID == pro_id).FirstOrDefault();
                bind_data(p);
            }
            
        }

        protected void EditProductButton_Click(object sender, EventArgs e)
        {
            String path = Server.MapPath("~/style/image/");
            List<string> tmp = new List<string>();
            for (int i = 0; i < image_name.Count; i++)
                tmp.Add(image_name[i].ToString());
            get_list_file_upload();

            try
            {
                if (tmp[0].ToString() != image_name[0].ToString())
                {
                    ProductImage1.PostedFile.SaveAs(path + ProductImage1.FileName);
                }
                if (tmp[1].ToString() != image_name[1].ToString())
                {
                    ProductImage2.PostedFile.SaveAs(path + ProductImage2.FileName);
                }
                if (tmp[2].ToString() != image_name[2].ToString())
                {
                    ProductImage3.PostedFile.SaveAs(path + ProductImage3.FileName);
                }
                if (tmp[3].ToString() != image_name[3].ToString())
                {
                    ProductImage4.PostedFile.SaveAs(path + ProductImage4.FileName);
                }
            }
            catch (Exception ex)
            {
                LabelAddStatus.Text = ex.Message;
            }


            List<string> cat_id = new List<string>();
            foreach (ListItem item in addProductInCategory.Items)
            {
                if (item.Selected)
                {
                    cat_id.Add(item.Value);
                }
            }

            BUS products = new BUS();

            products.editProduct(p, AddProductName.Text, AddProductDescription.Text, AddProductDetail.Text,
            AddProductPrice.Text, AddProductReview.Text, 1, AddProductGift.Text,
            AddProductsale.Text, AddProductVendor.Text, AddProductOnsale.Checked, AddProductOldPrice.Text,
            image_name[0].ToString(), image_name[1].ToString(), image_name[2].ToString(), image_name[3].ToString(), Show.Checked, cat_id);
            db.SaveChanges();

            string pageUrl = Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.Count() - Request.Url.Query.Count());
            Response.Redirect(pageUrl + "?ProductAction=edit");

        }

        public void bind_data(Product p)
        {
            AddProductName.Text = p.ProductName;
            AddProductDescription.Text = p.Description;
            AddProductDetail.Text = p.Detail;
            AddProductPrice.Text = p.Price.ToString();
            AddProductReview.Text = p.Review;
            AddProductStock.SelectedIndex = (Int32)(p.StockID - 1);
            AddProductGift.Text = p.Gift;
            AddProductsale.Text = p.Sale;
            AddProductVendor.Text = p.Vendor;
            if (p.onSale == true)
                AddProductOnsale.Checked = true;
            AddProductOldPrice.Text = p.oldPrice.ToString();
            if (p.Show == true)
                Show.Checked = true;

            var tmp4 = db.ProductInCategories.Where(z => z.ProductID == p.ProductID).ToList();
            foreach (ProductInCategory pc in tmp4)
            {
                foreach (ListItem lt in addProductInCategory.Items)
                {
                    if (pc.CategoryID.ToString() == lt.Value)
                    {
                        lt.Selected = true;
                        break;
                    }
                }
            }
            image_name.Add(p.ImagePath1);
            image_name.Add(p.ImagePath2);
            image_name.Add(p.ImagePath3);
            image_name.Add(p.ImagePath4);
            
            if (p.ImagePath1 != "")
                ImgPrv1.ImageUrl = "/style/image/" + p.ImagePath1;
            if (p.ImagePath2 != "")
                ImgPrv2.ImageUrl = "/style/image/" + p.ImagePath2;
            if (p.ImagePath3 != "")
                ImgPrv3.ImageUrl = "/style/image/" + p.ImagePath3;
            if (p.ImagePath4 != "")
                ImgPrv4.ImageUrl = "/style/image/" + p.ImagePath4;
        }
        public void get_list_file_upload()
        {
            String[] allowedExtensions = { ".png", ".jpeg", ".jpg" };
            if (ProductImage1.HasFile)
            {
                String fileExtension = System.IO.Path.GetExtension(ProductImage1.FileName).ToLower();

                for (int i = 0; i < allowedExtensions.Length; i++)
                {
                    if (fileExtension == allowedExtensions[i])
                    {
                        image_name[0] = ProductImage1.FileName;
                        break;
                    }
                }
            }

            if (ProductImage2.HasFile)
            {
                String fileExtension = System.IO.Path.GetExtension(ProductImage2.FileName).ToLower();

                for (int i = 0; i < allowedExtensions.Length; i++)
                {
                    if (fileExtension == allowedExtensions[i])
                    {
                        image_name[1] = ProductImage2.FileName;
                        break;
                    }
                }
            }
            if (ProductImage3.HasFile)
            {
                String fileExtension = System.IO.Path.GetExtension(ProductImage3.FileName).ToLower();

                for (int i = 0; i < allowedExtensions.Length; i++)
                {
                    if (fileExtension == allowedExtensions[i])
                    {
                        image_name[2] = ProductImage3.FileName;
                        break;
                    }
                }
            }
            if (ProductImage4.HasFile)
            {
                String fileExtension = System.IO.Path.GetExtension(ProductImage4.FileName).ToLower();

                for (int i = 0; i < allowedExtensions.Length; i++)
                {
                    if (fileExtension == allowedExtensions[i])
                    {
                        image_name[3] = ProductImage4.FileName;
                        break;
                    }
                }
            }
        }

        public IQueryable GetCategories()
        {
            var _db = new eWorldEntities();
            IQueryable query = _db.Categories;
            return query;
        }

        public IQueryable GetStock()
        {
            var _db = new eWorldEntities();
            IQueryable query = _db.ProductStocks;
            return query;
        }

        public IQueryable GetProducts()
        {
            var _db = new eWorldEntities();
            IQueryable query = _db.Products;
            return query;
        }

    }
}