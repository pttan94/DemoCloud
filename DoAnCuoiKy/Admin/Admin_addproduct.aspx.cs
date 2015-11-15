using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DoAnCuoiKy.Admin
{
    public partial class Admin_addproduct : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string productAction = Request.QueryString["ProductAction"];
            if (productAction == "add")
            {
                LabelAddStatus.Text = "Sản phẩm đã được thêm.";
            }
        }
        protected void AddProductButton_Click(object sender, EventArgs e)
        {
            List<string> image_name = new List<string>();
            String path = Server.MapPath("~/style/image/");
            image_name = get_list_file_upload();
            for (int i = 0; i < image_name.Count; i++)
            {
                try
                {
                    if (ProductImage1.FileName == image_name[i].ToString())
                    {
                        ProductImage1.PostedFile.SaveAs(path + ProductImage1.FileName);
                    }
                    if (ProductImage2.FileName == image_name[i].ToString())
                    {
                        ProductImage2.PostedFile.SaveAs(path + ProductImage2.FileName);
                    }
                    if (ProductImage3.FileName == image_name[i].ToString())
                    {
                        ProductImage3.PostedFile.SaveAs(path + ProductImage3.FileName);
                    }
                    if (ProductImage4.FileName == image_name[i].ToString())
                    {
                        ProductImage4.PostedFile.SaveAs(path + ProductImage4.FileName);
                    }
                }
                catch (Exception ex)
                {
                    LabelAddStatus.Text = ex.Message;
                }
            }
            List<string> cat_id = new List<string>();
            foreach (ListItem item in addProductInCategory.Items)
            {
                if (item.Selected)
                {
                    cat_id.Add(item.Value);
                }
            }
            bool addSuccess;
            BUS products = new BUS();

            addSuccess = products.AddProduct(AddProductName.Text, AddProductDescription.Text, AddProductDetail.Text,
                AddProductPrice.Text, AddProductReview.Text, 1, AddProductGift.Text,
                AddProductsale.Text, AddProductVendor.Text, AddProductOnsale.Checked, AddProductOldPrice.Text,
                image_name[0].ToString(), image_name[1].ToString(), image_name[2].ToString(), image_name[3].ToString(), Show.Checked, cat_id);

            if (addSuccess)
            {
                // Reload the page.
                string pageUrl = Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.Count() - Request.Url.Query.Count());
                Response.Redirect(pageUrl + "?ProductAction=add");
            }
            else
            {
                LabelAddStatus.Text = "Không thể thêm sản phẩm vào cơ sở dữ liệu.";
            }
        }

        public List<string> get_list_file_upload()
        {
            List<string> image_name = new List<string>();
            String[] allowedExtensions = { ".png", ".jpeg", ".jpg" };
            if (ProductImage1.HasFile)
            {
                String fileExtension = System.IO.Path.GetExtension(ProductImage1.FileName).ToLower();

                for (int i = 0; i < allowedExtensions.Length; i++)
                {
                    if (fileExtension == allowedExtensions[i])
                    {
                        image_name.Add(ProductImage1.FileName);
                        break;
                    }
                }
            }
            else image_name.Add("");
            if (ProductImage2.HasFile)
            {
                String fileExtension = System.IO.Path.GetExtension(ProductImage2.FileName).ToLower();

                for (int i = 0; i < allowedExtensions.Length; i++)
                {
                    if (fileExtension == allowedExtensions[i])
                    {
                        image_name.Add(ProductImage2.FileName);
                        break;
                    }
                }
            }
            else image_name.Add("");
            if (ProductImage3.HasFile)
            {
                String fileExtension = System.IO.Path.GetExtension(ProductImage3.FileName).ToLower();

                for (int i = 0; i < allowedExtensions.Length; i++)
                {
                    if (fileExtension == allowedExtensions[i])
                    {
                        image_name.Add(ProductImage3.FileName);
                        break;
                    }
                }
            }
            else image_name.Add("");
            if (ProductImage4.HasFile)
            {
                String fileExtension = System.IO.Path.GetExtension(ProductImage4.FileName).ToLower();

                for (int i = 0; i < allowedExtensions.Length; i++)
                {
                    if (fileExtension == allowedExtensions[i])
                    {
                        image_name.Add(ProductImage4.FileName);
                        break;
                    }
                }
            }
            else image_name.Add("");
            return image_name;
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