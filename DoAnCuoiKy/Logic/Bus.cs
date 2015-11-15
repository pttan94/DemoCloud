using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DoAnCuoiKy
{
    public class BUS
    {
        eWorldEntities db = null;
        public BUS()
        {
            if (db == null)
            {
                db = new eWorldEntities();
            }
        }
        public Product GetProductDetail(int ProductID)
        {
            return db.Products.SingleOrDefault(z => z.ProductID == ProductID);
        }

        public List<Product> GetProductDetail_ToList(int ProductID)
        {
            return db.Products.Where(z => z.ProductID == ProductID).ToList();
        }

        public List<Product> GetProductDetail_Rows(string name)
        {
            return db.Products.Where(z => z.ProductName.Contains(name)).ToList();

            // var tmp = from p in db.Products
            //           where p.ProductName.Contains(name)
            //           select p;
            // var result = tmp.ToList<Product>();

            // return result;
        }

        public List<Product> GetProduct_Right(string keyword)
        {

            var tmp = from c in db.Categories
                      from p in db.Products
                      from pc in db.ProductInCategories
                      where c.CategoryID == pc.CategoryID && pc.ProductID == p.ProductID
                      && c.KeyWord.Contains(keyword) && p.Show == true
                      select p;
            tmp.Take(3);
            var result = tmp.ToList<Product>();
            return result;
        }

        public bool AddProduct(string ProductName, string ProductDesc, string ProductDetail,
            string ProductPrice, string ProductReview, int Stock,
            string Gift, string Sale, string vendor, Boolean onsale, string oldprice,
            string ProductImagePath1, string ProductImagePath2, string ProductImagePath3,
            string ProductImagePath4, Boolean show, List<string> cat_id)
        {
            var myProduct = new Product();
            myProduct.ProductName = ProductName;
            myProduct.Description = ProductDesc;
            myProduct.Detail = ProductDetail;
            myProduct.Price = Double.Parse(ProductPrice);
            myProduct.Review = ProductReview;
            myProduct.StockID = Stock;
            myProduct.Gift = Gift;
            myProduct.Sale = Sale;
            myProduct.Vendor = vendor;
            myProduct.onSale = onsale;
            if (oldprice != "")
                myProduct.oldPrice = Double.Parse(oldprice);
            myProduct.ImagePath1 = ProductImagePath1;
            myProduct.ImagePath2 = ProductImagePath2;
            myProduct.ImagePath3 = ProductImagePath3;
            myProduct.ImagePath4 = ProductImagePath4;
            myProduct.Show = show;

            using (eWorldEntities db = new eWorldEntities())
            {
                // Add product to DB.
                db.Products.Add(myProduct);

                foreach (string id in cat_id)
                {
                    var cat = new ProductInCategory();
                    cat.CategoryID = Convert.ToInt32(id);
                    myProduct.ProductID = myProduct.ProductID;

                    db.ProductInCategories.Add(cat);
                }
                db.SaveChanges();
            }
            // Success.
            return true;
        }
        public void editProduct(Product myProduct, string ProductName, string ProductDesc, string ProductDetail,
            string ProductPrice, string ProductReview, int Stock,
            string Gift, string Sale, string vendor, Boolean onsale, string oldprice,
            string ProductImagePath1, string ProductImagePath2, string ProductImagePath3,
            string ProductImagePath4, Boolean show, List<string> cat_id)
        {

            myProduct.ProductName = ProductName;
            myProduct.Description = ProductDesc;
            myProduct.Detail = ProductDetail;
            myProduct.Price = Double.Parse(ProductPrice);
            myProduct.Review = ProductReview;
            myProduct.StockID = Stock;
            myProduct.Gift = Gift;
            myProduct.Sale = Sale;
            myProduct.Vendor = vendor;
            myProduct.onSale = onsale;
            if (oldprice != "")
                myProduct.oldPrice = Double.Parse(oldprice);
            myProduct.ImagePath1 = ProductImagePath1;
            myProduct.ImagePath2 = ProductImagePath2;
            myProduct.ImagePath3 = ProductImagePath3;
            myProduct.ImagePath4 = ProductImagePath4;
            myProduct.Show = show;
        }


    }
}