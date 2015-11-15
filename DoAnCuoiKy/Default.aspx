<%@ Page Title="Trang chủ" Language="C#" MasterPageFile="~/eWorld.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DoAnCuoiKy._Default" EnableEventValidation="false" %>

<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div id="Content">
        <div class="Content pdr col-md-12">
            <!--slide-->
            <div id="slider" class="hidden-sm hidden-xs">
                <div class="mask">
                    <ul class="images">
                        <asp:ListView ID="Slide_index" runat="server"
                            ItemType="DoAnCuoiKy.ImageSlide">
                            <ItemTemplate>
                                <li>
                                    <img class="img img-responsive mg0i" src='/style/image/slide/<%#Item.Path%>' alt='' /></li>
                            </ItemTemplate>

                        </asp:ListView>
                    </ul>
                </div>

                <ul id="count_slide" class="triggers hidden">
                    <li>0</li>
                    <li>1</li>
                    <li>2</li>
                    <li>3</li>
                    <li>4</li>
                    <li>5</li>
                    <li>6</li>
                </ul>

                <script></script>
                <img class="control prev" src="/style/image/prev-2.png" />
                <img class="control next" src="/style/image/next-2.png" />
                <script type="text/javascript">
                    $(document).ready(function () {
                        var triggers = $('ul.triggers li');
                        var images = $('ul.images li');
                        var lastElem = triggers.length - 1;
                        var target;

                        triggers.first().addClass('active');
                        images.hide().first().show();

                        function sliderResponse(target) {
                            images.fadeOut(300).eq(target).fadeIn(300);
                            triggers.removeClass('active').eq(target).addClass('active');
                        }

                        $('.next').click(function () {
                            target = $('ul.triggers li.active').index();
                            target === lastElem ? target = 0 : target = target + 1;
                            sliderResponse(target);
                            resetTiming();
                        });
                        $('.prev').click(function () {
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
            <!-- end slide -->

            <div class="Content col-lg-10 col-md-10 col-xs-12 col-sm-12 clearfix">

                <div class="Products clearfix">
                    <h2>Sản phẩm nổi bật</h2>
                    <div>
                        <div class="ProductList clearfix">

                            <asp:ListView ID="Featured_Product" runat="server"
                                ItemType="DoAnCuoiKy.Product">

                                <EmptyDataTemplate>
                                    <div>Không có sản phẩm trong nhóm.</div>
                                </EmptyDataTemplate>

                                <ItemTemplate>
                                    <div runat="server">
                                        <div class="col-lg-3 col-md-3 col-xs-12 col-sm-3 ProductItem mgr">
                                            <div class="ProductImage QuickView">
                                                <a href="Product.aspx?ProductID=<%#Item.ProductID %>">
                                                    <img src="/style/image/<%#:Item.ImagePath1%>" /></a>
                                            </div>
                                            <div class="ProductInfo">
                                                <div class="ProductDetails">
                                                    <strong><a href="Product.aspx?ProductID=<%#Item.ProductID %>"><%#:Item.ProductName%></a></strong><br />
                                                    <span class="SalePrice"><%# String.Format(CultureInfo.GetCultureInfo("vi-VN"),"{0:c0}", Item.Price) %></span>
                                                    <span class='<%# Item.onSale== false? "hidden" : "line_th"%>'><%# String.Format(CultureInfo.GetCultureInfo("vi-VN"),"{0:c0}", Item.oldPrice) %></span>

                                                    <p class="description"><%#:Item.Description%></p>
                                                </div>
                                                <div class="ProductActionAdd">
                                                    <a href="/AddToCart.aspx?productID=<%#:Item.ProductID %>" class="" title="Thêm vào giỏ hàng">Thêm vào giỏ hàng</a>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </ItemTemplate>

                            </asp:ListView>

                        </div>
                    </div>
                    <div style="float: right;">
                        <asp:HyperLink ID="feat_pro_index_cat" runat="server">Xem tất cả &gt;</asp:HyperLink>
                    </div>
                    <div class="clearfix"></div>
                </div>

                <div class="space"></div>


                <div class="Products clearfix">
                    <h2>Sản phẩm khuyến mãi</h2>
                    <div>
                        <div class="ProductList clearfix">
                            <asp:ListView ID="Sale_Product" runat="server"
                                ItemType="DoAnCuoiKy.Product">

                                <EmptyDataTemplate>
                                    <div>Không có sản phẩm trong nhóm.</div>
                                </EmptyDataTemplate>

                                <ItemTemplate>
                                    <div runat="server">
                                        <div class="col-lg-3 col-md-3 col-xs-12 col-sm-3 ProductItem mgr">
                                            <div class="ProductImage QuickView">
                                                <a href="Product.aspx?ProductID=<%#Item.ProductID %>">
                                                    <img src="/style/image/<%#:Item.ImagePath1%>" /></a>
                                            </div>
                                            <div class="ProductInfo">
                                                <div class="ProductDetails">
                                                    <strong><a href="Product.aspx?ProductID=<%#Item.ProductID %>"><%#:Item.ProductName%></a></strong>
                                                    <br />
                                                    <span class="SalePrice"><%# String.Format(CultureInfo.GetCultureInfo("vi-VN"),"{0:c0}", Item.Price) %></span>
                                                    <span class='<%# Item.onSale== false? "hidden" : "line_th"%>'><%# String.Format(CultureInfo.GetCultureInfo("vi-VN"),"{0:c0}", Item.oldPrice) %></span>

                                                    <p class="description"><%#:Item.Description%></p>
                                                </div>
                                                <div class="ProductActionAdd">
                                                    <a href="/AddToCart.aspx?productID=<%#:Item.ProductID %>" class="" title="Thêm vào giỏ hàng">Thêm vào giỏ hàng</a>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </ItemTemplate>

                            </asp:ListView>
                        </div>
                    </div>
                    <div style="float: right;">
                        <asp:HyperLink ID="sale_pro_index_cat" runat="server">Xem tất cả &gt;</asp:HyperLink>
                    </div>
                    <div class="clearfix"></div>
                </div>

                <div class="space"></div>

                <div class="Products clearfix">
                    <h2>Điện thoại</h2>
                    <div>
                        <div class="ProductList clearfix">
                            <asp:ListView ID="Mobile_index" runat="server"
                                ItemType="DoAnCuoiKy.Product">

                                <EmptyDataTemplate>
                                    <div>Không có sản phẩm trong nhóm.</div>
                                </EmptyDataTemplate>

                                <ItemTemplate>
                                    <div runat="server">
                                        <div class="col-lg-3 col-md-3 col-xs-12 col-sm-3 ProductItem mgr">
                                            <div class="ProductImage QuickView">
                                                <a href="Product.aspx?ProductID=<%#Item.ProductID %>">
                                                    <img src="/style/image/<%#:Item.ImagePath1%>" /></a>
                                            </div>
                                            <div class="ProductInfo">
                                                <div class="ProductDetails">
                                                    <strong><a href="Product.aspx?ProductID=<%#Item.ProductID %>"><%#:Item.ProductName%></a></strong>
                                                    <br />
                                                    <span class="SalePrice"><%# String.Format(CultureInfo.GetCultureInfo("vi-VN"),"{0:c0}", Item.Price) %></span>
                                                    <span class='<%# Item.onSale== false? "hidden" : "line_th"%>'><%# String.Format(CultureInfo.GetCultureInfo("vi-VN"),"{0:c0}", Item.oldPrice) %></span>

                                                    <p class="description"><%#:Item.Description%></p>
                                                </div>
                                                <div class="ProductActionAdd">
                                                    <a href="/AddToCart.aspx?productID=<%#:Item.ProductID %>" class="" title="Thêm vào giỏ hàng">Thêm vào giỏ hàng</a>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </ItemTemplate>

                            </asp:ListView>
                        </div>
                    </div>
                    <div style="float: right;">
                        <asp:HyperLink ID="mobile_pro_index_cat" runat="server">Xem tất cả &gt;</asp:HyperLink>
                    </div>
                    <div class="clearfix"></div>
                </div>

                <div class="space"></div>

                <div class="Products clearfix">
                    <h2>Máy tính bảng</h2>
                    <div>
                        <div class="ProductList clearfix">
                            <asp:ListView ID="Tablet_index" runat="server"
                                ItemType="DoAnCuoiKy.Product">

                                <EmptyDataTemplate>
                                    <div>Không có sản phẩm trong nhóm.</div>
                                </EmptyDataTemplate>

                                <ItemTemplate>
                                    <div runat="server">
                                        <div class="col-lg-3 col-md-3 col-xs-12 col-sm-3 ProductItem mgr">
                                            <div class="ProductImage QuickView">
                                                <a href="Product.aspx?ProductID=<%#Item.ProductID %>">
                                                    <img src="/style/image/<%#:Item.ImagePath1%>" /></a>
                                            </div>
                                            <div class="ProductInfo">
                                                <div class="ProductDetails">
                                                    <strong><a href="Product.aspx?ProductID=<%#Item.ProductID %>"><%#:Item.ProductName%></a></strong>
                                                    <br />
                                                    <span class="SalePrice"><%# String.Format(CultureInfo.GetCultureInfo("vi-VN"),"{0:c0}", Item.Price) %></span>
                                                    <span class='<%# Item.onSale== false? "hidden" : "line_th"%>'><%# String.Format(CultureInfo.GetCultureInfo("vi-VN"),"{0:c0}", Item.oldPrice) %></span>

                                                    <p class="description"><%#:Item.Description%></p>
                                                </div>
                                                <div class="ProductActionAdd">
                                                    <a href="/AddToCart.aspx?productID=<%#:Item.ProductID %>" class="" title="Thêm vào giỏ hàng">Thêm vào giỏ hàng</a>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </ItemTemplate>

                            </asp:ListView>
                        </div>
                    </div>
                    <div style="float: right;">
                        <asp:HyperLink ID="tablet_pro_index_cat" runat="server">Xem tất cả &gt;</asp:HyperLink>
                    </div>
                    <div class="clearfix"></div>
                </div>

                <div class="space"></div>

                <div class="Products clearfix">
                    <h2>Phụ kiện</h2>
                    <div>
                        <div class="ProductList clearfix">
                            <asp:ListView ID="PK_index" runat="server"
                                ItemType="DoAnCuoiKy.Product">

                                <EmptyDataTemplate>
                                    <div>Không có sản phẩm trong nhóm.</div>
                                </EmptyDataTemplate>

                                <ItemTemplate>
                                    <div runat="server">
                                        <div class="col-lg-3 col-md-3 col-xs-12 col-sm-3 ProductItem mgr">
                                            <div class="ProductImage QuickView">
                                                <a href="Product.aspx?ProductID=<%#Item.ProductID %>">
                                                    <img src="/style/image/<%#:Item.ImagePath1%>" /></a>
                                            </div>
                                            <div class="ProductInfo">
                                                <div class="ProductDetails">
                                                    <strong><a href="Product.aspx?ProductID=<%#Item.ProductID %>"><%#:Item.ProductName%></a></strong>
                                                    <br />
                                                    <span class="SalePrice"><%# String.Format(CultureInfo.GetCultureInfo("vi-VN"),"{0:c0}", Item.Price) %></span>
                                                    <span class='<%# Item.onSale== false? "hidden" : "line_th"%>'><%# String.Format(CultureInfo.GetCultureInfo("vi-VN"),"{0:c0}", Item.oldPrice) %></span>

                                                    <p class="description"><%#:Item.Description%></p>
                                                </div>
                                                <div class="ProductActionAdd">
                                                    <a href="/AddToCart.aspx?productID=<%#:Item.ProductID %>" class="" title="Thêm vào giỏ hàng">Thêm vào giỏ hàng</a>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </ItemTemplate>

                            </asp:ListView>
                        </div>
                    </div>
                    <div style="float: right;">
                        <asp:HyperLink ID="pk_pro_index_cat" runat="server">Xem tất cả &gt;</asp:HyperLink>
                    </div>
                    <div class="clearfix"></div>
                </div>

            </div>
            <div class="Left col-md-2 clearfix">
                <!--
                <div class="News">
                    <h2>Tin tức</h2>
                    <div>
                        <ul class="news_content">
                            <li>
                                <a href="./mo-hop-smartwatch3-phien-ban-vo-kim-loai.html">
                                    <img class="img img-responsive mgt" src="./style/image/news_1.jpg" /></a>
                                <a href="./mo-hop-smartwatch3-phien-ban-vo-kim-loai.html">Mở hộp Smartwatch 3 phiên bản vỏ kim loại</a>
                            </li>
                            <li>
                                <a href="./mo-hop-lenovo-s60-thiet-ke-giong-iphone5c.html">
                                    <img class="img img-responsive mgt" src="./style/image/news_2.jpg" /></a>
                                <a href="./mo-hop-lenovo-s60-thiet-ke-giong-iphone5c.html">Mở hộp LENOVO S60 : Thiết kế giống iPhone 5c</a>
                            </li>
                            <li>
                                <a href="./iphone6-99-gia-12.7-trieu-co-nen-mua-khong.html">
                                    <img class="img img-responsive mgt" src="./style/image/news_3.jpg" /></a>
                                <a href="./iphone6-99-gia-12.7-trieu-co-nen-mua-khong.html">iPhone 6 99% giá 12.7 triệu có nên mua ?</a>
                            </li>
                            <li>
                                <a href="./mo-hop-smartwatch3-phien-ban-vo-kim-loai.html">
                                    <img class="img img-responsive mgt" src="./style/image/news_1.jpg" /></a>
                                <a href="./mo-hop-smartwatch3-phien-ban-vo-kim-loai.html">Mở hộp Smartwatch 3 phiên bản vỏ kim loại</a>
                            </li>
                            <li>
                                <a href="./iphone6-99-gia-12.7-trieu-co-nen-mua-khong.html">
                                    <img class="img img-responsive mgt" src="./style/image/news_3.jpg" /></a>
                                <a href="./iphone6-99-gia-12.7-trieu-co-nen-mua-khong.html">iPhone 6 99% giá 12.7 triệu có nên mua ?</a>
                            </li>
                        </ul>
                    </div>
                </div>
                -->
                <div class="banner_left">
                    <asp:Repeater ID="image_banner" runat="server" ItemType="DoAnCuoiKy.ImageBanner">
                        <ItemTemplate>
                            <asp:HyperLink runat="server" NavigateUrl="<%# Item.Link %>">
                                <img class="img img-responsive" src="/style/image/banner/<%# Item.Path %>" />
                            </asp:HyperLink>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

            </div>
        </div>
        <div class="clearfix"></div>
    </div>

</asp:Content>
