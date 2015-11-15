<%@ Page Language="C#" MasterPageFile="~/eWorld.Master" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="DoAnCuoiKy.Product1" %>

<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Product" ContentPlaceHolderID="MainContent" runat="server">

    <div id="Content">
        <div class="Content pdr col-md-12">

            <asp:FormView ID="ProductDetail" runat="server" ItemType="DoAnCuoiKy.Product" RenderOuterTable="false">
                <ItemTemplate>
                    <div class="Content col-md-10 clearfix">
                        <div class="breadcrumb">
                            <a href="/Default.aspx">Trang chủ</a> &gt; <a href="Product.aspx?ProductID=<%#Item.ProductID %>"><%#: Item.ProductName %></a>
                        </div>
                        <div class="space"></div>
                        <div class="clearfix">
                            <div id="slider2" class="hidden-sm hidden-xs ">
                                <div class="mask2 clearfix">
                                    <ul class="images2">
                                        <li>
                                            <img class="img img-responsive mg0i" src='./style/image/<%#: Item.ImagePath1 %>' alt='' /></li>
                                        <li>
                                            <img class="img img-responsive mg0i" src='./style/image/<%#: Item.ImagePath2 %>' alt='' /></li>
                                        <li>
                                            <img class="img img-responsive mg0i" src='./style/image/<%#: Item.ImagePath3 %>' alt='' /></li>
                                        <li>
                                            <img class="img img-responsive mg0i" src='./style/image/<%#: Item.ImagePath4 %>' alt='' /></li>
                                    </ul>
                                </div>

                                <ul class="triggers hidden">
                                    <li>0</li>
                                    <li>1</li>
                                    <li>2</li>
                                    <li>3</li>
                                </ul>
                                <img class="control2 prev2" src="./style/image/prev-2.png" />
                                <img class="control2 next2" src="./style/image/next-2.png" />
                                <script type="text/javascript">
                                    $(document).ready(function () {
                                        var triggers = $('ul.triggers li');
                                        var images = $('ul.images2 li');
                                        var lastElem = triggers.length - 1;
                                        var target;

                                        triggers.first().addClass('active');
                                        images.hide().first().show();

                                        function sliderResponse(target) {
                                            images.fadeOut(300).eq(target).fadeIn(300);
                                            triggers.removeClass('active').eq(target).addClass('active');
                                        }

                                        $('.next2').click(function () {
                                            target = $('ul.triggers li.active').index();
                                            target === lastElem ? target = 0 : target = target + 1;
                                            sliderResponse(target);
                                            resetTiming();
                                        });
                                        $('.prev2').click(function () {
                                            target = $('ul.triggers li.active').index();
                                            lastElem = triggers.length - 1;
                                            target === 0 ? target = lastElem : target = target - 1;
                                            sliderResponse(target);
                                            resetTiming();
                                        });

                                        function sliderTiming() {
                                            target = $('ul.triggers li.active').index();
                                            target === lastElem ? target = 0 : target = target + 1;
                                            sliderResponse(target);
                                        }

                                        var timingRun = setInterval(function () { sliderTiming(); }, 5000);
                                        function resetTiming() {
                                            clearInterval(timingRun);
                                            timingRun = setInterval(function () { sliderTiming(); }, 5000);
                                        }
                                    });
                                </script>
                            </div>
                            <div style="padding-left: 20px; float: left; width: 350px;">
                                <h3><b><%# Item.ProductName %></b></h3>
                                <div class="">

                                    <span class="price"><%# String.Format(CultureInfo.GetCultureInfo("vi-VN"),"{0:c0}", Item.Price) %></span>

                                    <span class='<%# Item.onSale== false? "hidden" : "line_th"%>'><%# String.Format(CultureInfo.GetCultureInfo("vi-VN"),"{0:c0}", Item.oldPrice) %></span>

                                    <span style="padding-left: 30px;">
                                        <%# Item.ProductStock.Stock %></span>
                                    
                                    <div style="padding-top: 20px;" class="clearfix">
                                        <div class='st_facebook_hcount' style="float: left;"></div>
                                        <div class='st_googleplus_hcount' style="float: left;"></div>
                                        <div class='st_twitter_hcount' style="float: left;"></div>
                                    </div>
                                    <div class="clearfix"></div>
                                    <div class="box">
                                        <h4>Quà tặng: </h4>
                                        <%# Item.Gift %>
                                    </div>
                                    <div class="box">
                                        <h4>Ưu đãi</h4>
                                        <%# Item.Sale %>
                                    </div>
                                    <div class="space"></div>

                                    <a href="/AddToCart.aspx?productID=<%#:Item.ProductID %>"
                                        visible='<%# Int32.Parse(Eval("StockID").ToString()) != 2 ? Convert.ToBoolean(Eval("Show").ToString()):false %>' class="btn_dathang" id="btn_dathang">Đặt hàng</a>

                                </div>
                            </div>
                        </div>

                        <div class="space clearfix"></div>

                        <div class="product-detail clearfix">
                            <div class="space"></div>

                            <h3><b>Thông số kĩ thuật</b></h3>
                            <div class="content-thongso">
                                <%# Item.Detail %>
                            </div>
                            <div class="space"></div>

                            <h3><b>Đánh giá chi tiết</b></h3>
                            <div class="danh-gia">
                                <%# Item.Review %>
                            </div>
                        </div>
                        <div class="space"></div>
                        <h3><b>Bình luận</b></h3>

                        <div class="container-fluid">
                            <div id="fb-root"></div>
                            <div class="fb-comments" data-numposts="10" width="100%" data-colorscheme="light"></div>
                            <!-- script comment fb -->
                            <script type="text/javascript">
                                $(document).ready(function () {
                                    var url = document.url;
                                    $(".fb-comments").attr("data-href", url);
                                });
                            </script>
                            <script type="text/javascript">
                                (function (d, s, id) {
                                    var js, fjs = d.getElementsByTagName(s)[0];
                                    if (d.getElementById(id)) return;
                                    js = d.createElement(s); js.id = id;
                                    js.src = "//connect.facebook.net/vi_VN/sdk.js#xfbml=1&appId=263266547210244&version=v2.0";
                                    fjs.parentNode.insertBefore(js, fjs);
                                }(document, 'script', 'facebook-jssdk'));
                            </script>


                        </div>

                    </div>

                </ItemTemplate>
            </asp:FormView>
            <div class="Left col-md-2 clearfix">
                <div class="CategoryList">
                    <h2>Sản phẩm nổi bật</h2>
                    <div>
                        <ul class="category-list">

                            <asp:Repeater ID="right_pro_feat" runat="server" ItemType="DoAnCuoiKy.Product">
                                <ItemTemplate>
                                    <li>
                                        <div class="ProductImage QuickView">
                                            <a href="Product.aspx?ProductID=<%#Item.ProductID %>">
                                                <img src="/style/image/<%#Item.ImagePath1%>" /></a>
                                        </div>
                                        <div class="ProductInfo_2">
                                            <div class="ProductDetails_2">
                                                <strong><a href="Product.aspx?ProductID=<%#Item.ProductID %>"><%#Item.ProductName%></a></strong>
                                                <span class="SalePrice"><%# String.Format(CultureInfo.GetCultureInfo("vi-VN"),"{0:c0}", Item.Price) %></span>
                                                <span class='<%# Item.onSale== false? "hidden" : "line_th"%>'><%# String.Format(CultureInfo.GetCultureInfo("vi-VN"),"{0:c0}", Item.oldPrice) %></span>

                                            </div>
                                        </div>
                                    </li>
                                </ItemTemplate>
                            </asp:Repeater>

                        </ul>
                    </div>
                </div>
                <div class="CategoryList">
                    <h2>Sản phẩm giảm giá</h2>
                    <div>
                        <ul class="category-list">

                            <asp:Repeater ID="right_pro_new" runat="server" ItemType="DoAnCuoiKy.Product">
                                <ItemTemplate>
                                    <li>
                                        <div class="ProductImage QuickView">
                                            <a href="Product.aspx?ProductID=<%#Item.ProductID %>">
                                                <img src="/style/image/<%#Item.ImagePath1%>" /></a>
                                        </div>
                                        <div class="ProductInfo_2">
                                            <div class="ProductDetails_2">
                                                <strong><a href="Product.aspx?ProductID=<%#Item.ProductID %>"><%#Item.ProductName%></a></strong>
                                                <span class="SalePrice"><%# String.Format(CultureInfo.GetCultureInfo("vi-VN"),"{0:c0}", Item.Price) %></span>
                                                <span class='<%# Item.onSale== false? "hidden" : "line_th"%>'><%# String.Format(CultureInfo.GetCultureInfo("vi-VN"),"{0:c0}", Item.oldPrice) %></span>

                                            </div>
                                        </div>
                                    </li>
                                </ItemTemplate>

                            </asp:Repeater>

                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>

</asp:Content>
